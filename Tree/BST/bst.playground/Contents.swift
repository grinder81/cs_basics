import UIKit

class Node {
    var key: Int
    var parent: Node?
    var left: Node?
    var right: Node?
    
    init(key: Int) {
        self.key = key
    }
}

class BST {
    var root: Node?
    
    // Traversal O(n)
    func inOrder(_ node: Node?) {
        if let node = node {
            inOrder(node.left)
            print(node.key)
            inOrder(node.right)
        }
    }
    
    func preOrder(_ node: Node?) {
        if let node = node {
            print(node.key)
            preOrder(node.left)
            preOrder(node.right)
        }
    }
    
    func postOrder(_ node: Node?) {
        if let node = node {
            postOrder(node.left)
            postOrder(node.right)
            print(node.key)
        }
    }
    
    // Search O(n)
    func search(_ key: Int) -> Node? {
        return searchInternal(root, key)
    }
    
    private func searchInternal(_ node: Node?, _ key: Int) -> Node? {
        guard let node = node else { return nil }
        if key == node.key {
            return node
        } else if key < node.key {
            return searchInternal(node.left, key)
        } else {
            return searchInternal(node.right, key)
        }
    }
    
    // O(h)
    func insert(_ key: Int) {
        root = insert(root, nil, key)
    }
    
    private func insert(_ node: Node?, _ parent: Node?, _ key: Int) -> Node {
        guard let node = node else {
            var leaf = Node(key: key)
            leaf.parent = parent
            return leaf
        }
        // position must be in left
        if key < node.key {
            node.left = insert(node.left, node, key)
        } else {
            node.right = insert(node.right, node, key)
        }
        return node
    }
    
    // O(h)
    func deleteNode(_ node: Node?, _ key: Int) -> Node? {
        guard let node = node else { return root }
        
        if key < node.key {
            var left = deleteNode(node.left, key)
            left?.parent = node
            node.left = left
        } else if key > node.key {
            var right = deleteNode(node.right, key)
            right?.parent = node
            node.right = right
        } else {
            if node.left == nil {
                node.parent = nil
                return node.right
            } else if node.right == nil {
                node.parent = nil
                return node.left
            } else {
                // Get the smallest one on the right sub tree
                // (inorder successor)
                let inorderSuccessor = minimumValue(node.right)
                // make current node value by the smallest one
                // on the right sub tree and this is the current root
                node.key   = inorderSuccessor!.key
                // delete the inorder successor where current
                // node right is it's root
                node.right = deleteNode(node.right, node.key)
            }
        }
        return node
    }
    
    // O(h)
    func minimumValue(_ node: Node?) -> Node? {
        var current = node
        while let left = current?.left {
            current = left
        }
        return current
    }
    
    // O(h)
    func maximumValue(_ node: Node?) -> Node? {
        var current = node
        while let right = current?.right {
            current = right
        }
        return current
    }
    
    // O(n)
    func height() -> Int {
        return heightInternal(root)
    }
    
    private func heightInternal(_ node: Node?) -> Int {
        guard let node = node else { return 0 }
        return 1 + max(heightInternal(node.left), heightInternal(node.right))
    }
    
    // O(n)
    func depth(_ key: Int) -> Int {
        return depthInternal(root, key, 0)
    }
    
    private func depthInternal(_ node: Node?, _ key: Int, _ d: Int) -> Int {
        guard let node = node else { return 0 }
        if key == node.key {
            return d
        } else if key < node.key {
            return depthInternal(node.left, key, d + 1)
        } else {
            return depthInternal(node.right, key, d + 1)
        }
    }
    
    // O(h)
    // Previous small element in sorted order
    func predecessor(_ node: Node) -> Node? {
        if let left = node.left {
            return maximumValue(node.left)
        } else {
            // Back track till root where any node key < current not key
            var current = node
            while let parent = current.parent {
                if current.key > parent.key {
                    return parent
                }
                current = parent
            }
            return nil
        }
    }

    // O(h)
    // Next big element in sorted order
    func successor(_ node: Node) -> Node? {
        if let right = node.right {
            print(right.key)
            return minimumValue(node.right)
        } else {
            var current = node
            while let parent = current.parent {
                if current.key < parent.key {
                    return parent
                }
                current = parent
            }
            return nil
        }
    }
    
    // O(h)
    func isBST() -> Bool {
        return isBSTInternal(root, Int.min, Int.max)
    }
    
    private func isBSTInternal(_ node: Node?, _ minValue: Int, _ maxValue: Int) -> Bool {
        guard let node = node else { return true }
        if node.key < minValue || node.key > maxValue { return false }
        
        let l = isBSTInternal(node.left,  minValue, maxValue)
        let r = isBSTInternal(node.right, minValue, maxValue)
        return l && r
    }
    
    // An empty bst is balanced tree
    // A non-empty is balanced if:
    //  a. Left Subtree TL is balanced
    //  b. Right Subtree RL is balanced
    //  c. Height Diff = (TL - RL) <= 1
    func isBalanced() -> Bool {
        return isBalancedInternal(root).0
    }
    
    private func isBalancedInternal(_ node: Node?) -> (Bool, Int) {
        guard let node = node else { return (true, 0) }
        
        let l = isBalancedInternal(node.left)
        let r = isBalancedInternal(node.right)
        
        // Any subtree false mean not balaced
        if (l.0 && r.0) == false { return (false, 0) }
        
        // Diff of height is > 1 and return false
        if abs(l.1 - r.1) > 1 { return (false, 0) }
        
        return (true, max(l.1, r.1) + 1)
    }
    
    
}

var bst = BST()
bst.insert(50)
bst.insert(30)
bst.insert(20)
bst.insert(70)

bst.isBalanced()

//bst.insert(40)

//bst.depth(50)
//
//bst.inOrder(bst.root)
//
//bst.deleteNode(bst.root, 50)
//
//print("Delete 50")
//
//bst.preOrder(bst.root)
//bst.inOrder(bst.root)
//bst.postOrder(bst.root)
//
