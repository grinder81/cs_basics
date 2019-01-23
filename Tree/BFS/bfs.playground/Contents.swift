import UIKit

class Edge: Equatable {
    var neighbor: Node
    
    init(neighbor: Node) {
        self.neighbor = neighbor
    }
}

func == (_ lhs: Edge, rhs: Edge) -> Bool {
    return lhs.neighbor == rhs.neighbor
}

class Node: Equatable {
    var neighbors: [Edge]
    var visited: Bool
    var label: String
    var distance: Int?
    
    init(label: String) {
        self.label = label
        self.neighbors = []
        self.visited = false
    }
    
    func remove(_ edge: Edge) {
        self.neighbors.remove(at: self.neighbors.index{ $0 === edge }!)
    }
}

func == (_ lhs: Node, rhs: Node) -> Bool {
    return lhs.label == rhs.label && lhs.neighbors == rhs.neighbors
}

class Graph: Equatable {
    var nodes: [Node]
    
    init() {
        self.nodes = []
    }
    
    func addNode(_ label: String) -> Node {
        let node = Node(label: label)
        nodes.append(node)
        return node
    }
    
    func addEdge(_ source: Node, neighbor: Node) {
        let edge = Edge(neighbor: neighbor)
        source.neighbors.append(edge)
    }
}

func == (_ lhs: Graph, rhs: Graph) -> Bool {
    return lhs.nodes == rhs.nodes
}

public struct Queue<T> {
    var array: [T] = []
    
    var count: Int {
        return array.count
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var front: T? {
        return array.first
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        guard !isEmpty else { return nil }
        return array.removeFirst()
    }
}

func breadthFirstSearch(_ graph: Graph, source: Node) -> [String] {
    var queue = Queue<Node>()
    queue.enqueue(source)
    
    var nodeExplored = [source.label]
    source.visited = true
    
    while let node = queue.dequeue() {
        for edge in node.neighbors {
            let neighborNode = edge.neighbor
            if neighborNode.visited == false {
                queue.enqueue(neighborNode)
                neighborNode.visited = true
                nodeExplored.append(neighborNode.label)
            }
        }
    }
    return nodeExplored
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

//let nodesExplored = breadthFirstSearch(graph, source: nodeA)
//print(nodesExplored)

// https://www.geeksforgeeks.org/find-level-maximum-sum-binary-tree/

func maxLevelSum(_ source: Node) -> Int {
    var queue = Queue<Node>()
    queue.enqueue(source)

    var maxSum = Int.min
    source.visited = true
    
    while !queue.isEmpty {
        // qSize amount of node is in current level
        var sum = 0
        var qSize = queue.count
        while qSize > 0, let node = queue.dequeue() {
            print(node.label)
            for edge in node.neighbors {
                let neighborNode = edge.neighbor
                sum += neighborNode.distance ?? 0
                if neighborNode.visited == false {
                    neighborNode.visited = true
                    queue.enqueue(neighborNode)
                }
            }
            qSize -= 1
        }
        maxSum = max(sum, maxSum)
    }
    return maxSum
}

maxLevelSum(nodeA)
