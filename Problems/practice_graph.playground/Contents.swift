
// https://leetcode.com/problems/binary-tree-level-order-traversal/
// https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/
// https://leetcode.com/problems/average-of-levels-in-binary-tree/
// https://leetcode.com/problems/minimum-depth-of-binary-tree/
// https://www.geeksforgeeks.org/level-order-successor-of-a-node-in-binary-tree/
// https://leetcode.com/problems/binary-tree-right-side-view/
// https://leetcode.com/problems/boundary-of-binary-tree/
// https://leetcode.com/problems/binary-tree-maximum-path-sum/


class Edge: Equatable {
    var neighbor: Node
    init(node: Node) {
        self.neighbor = node
    }
}

func == (_ lhs: Edge, _ rhs: Edge) -> Bool {
    return lhs.neighbor == rhs.neighbor
}

class Node: Equatable {
    var value: Int?
    var visited: Bool
    var label: String
    
    init(label: String) {
        self.label = label
        self.visited = false
    }
}

func == (_ lhs: Node, _ rhs: Node) -> Bool {
    return lhs.label == rhs.label
}
