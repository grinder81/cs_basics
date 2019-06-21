import UIKit

// https://leetcode.com/problems/binary-search-tree-iterator/


public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}


class BSTIterator {
    
    var stack: [TreeNode] = []
    
    private func push(_ node: TreeNode?) {
        var current = node
        while let left = current?.left {
            stack.append(current!)
            current = left
        }
        stack.append(current!)
    }
    
    init(_ root: TreeNode?) {
        push(root)
    }
    
    /** @return the next smallest number */
    func next() -> Int {
        let top = stack.last!
        push(top.right)
        return top.val
    }
    
    /** @return whether we have a next smallest number */
    func hasNext() -> Bool {
        return !stack.isEmpty
    }
}

