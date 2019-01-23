import UIKit

// Node
class Node: Equatable {
    var neighbors: [Edge]
    var label: String
    var value: Int?
    var visited: Bool
    
    init(label: String) {
        self.label = label
        self.neighbors = []
        self.visited = false
    }
}

func == (_ lhs: Node, _ rhs: Node) -> Bool {
    return lhs.label == rhs.label && lhs.neighbors == rhs.neighbors
}

// Edge
class Edge: Equatable {
    var neighbor: Node
    init(neighbor: Node) {
        self.neighbor = neighbor
    }
}

func == (_ lhs: Edge, _ rhs: Edge) -> Bool {
    return lhs.neighbor == rhs.neighbor
}

// Graph
class Graph: Equatable {
    var nodes: [Node]
    init() {
        self.nodes = []
    }
    
    func addNode(_ label: String) -> Node {
        let node = Node(label: label)
        self.nodes.append(node)
        return node
    }
    
    func addEdge(_ source: Node, neighbor: Node) {
        let edge = Edge(neighbor: neighbor)
        source.neighbors.append(edge)
    }
}

func == (_ lhs: Graph, _ rhs: Graph) -> Bool {
    return lhs.nodes == rhs.nodes
}

struct Stack<T> {
    var data: [T] = []
    
    var isEmpty: Bool {
        return data.isEmpty
    }
    
    var size: Int {
        return data.count
    }
    
    var top: T? {
        return data.last
    }
    
    mutating func push(_ element: T) {
        data.append(element)
    }
    
    mutating func pop() -> T? {
        guard !data.isEmpty else { return nil }
        return data.removeLast()
    }
}

func depthFirstSearch(_ source: Node) -> [String] {
    var nodesExplored = [source.label]
    source.visited = true
    for edge in source.neighbors {
        let neighbor = edge.neighbor
        if neighbor.visited == false {
            nodesExplored += depthFirstSearch(neighbor)
        }
    }
    return nodesExplored
}

func depthFirstSearchIterative(_ source: Node) -> [String] {
    var stack = Stack<Node>()
    stack.push(source)

    var nodesExplored: [String] = []
    
    while !stack.isEmpty, let node = stack.pop() {
        node.visited = true
        nodesExplored.append(node.label)
        for edge in node.neighbors {
            if edge.neighbor.visited == false {
                stack.push(edge.neighbor)
            }
        }
    }
    
    return nodesExplored
}

func topologicalSort(_ graph: Graph) -> [String] {
    var stack: [String] = []
    
    func dfs(_ source: Node) {
        source.visited = true
        for edge in source.neighbors {
            if edge.neighbor.visited == false {
                dfs(edge.neighbor)
            }
        }
        stack.append(source.label)
    }
    
    for node in graph.nodes {
        if node.visited == false {
            dfs(node)
        }
    }
    
    return stack.reversed()
}


let graph = Graph()

let nodeA = graph.addNode("a")
let nodeB = graph.addNode("b")
let nodeC = graph.addNode("c")
let nodeD = graph.addNode("d")
let nodeE = graph.addNode("e")
let nodeF = graph.addNode("f")
let nodeG = graph.addNode("g")
let nodeH = graph.addNode("h")

graph.addEdge(nodeA, neighbor: nodeB)
graph.addEdge(nodeA, neighbor: nodeC)
graph.addEdge(nodeB, neighbor: nodeD)
graph.addEdge(nodeB, neighbor: nodeE)
graph.addEdge(nodeC, neighbor: nodeF)
graph.addEdge(nodeC, neighbor: nodeG)
graph.addEdge(nodeE, neighbor: nodeH)
graph.addEdge(nodeE, neighbor: nodeF)
graph.addEdge(nodeF, neighbor: nodeG)

//depthFirstSearch(nodeA)

topologicalSort(graph)
