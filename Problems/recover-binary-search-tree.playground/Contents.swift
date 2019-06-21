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

class Solution {
    
    var nodeOne: TreeNode?
    var nodeTwo: TreeNode?
    var prevNode: TreeNode?
    
    func helper(_ root: TreeNode?) {
        if root == nil { return }
        helper(root?.left)
        
        if let preVal = prevNode?.val {
            if nodeOne == nil && preVal >= root!.val {
                nodeOne = prevNode
            }
            
            if nodeOne != nil && preVal >= root!.val {
                nodeTwo = root
            }
        }
        
        prevNode = root
        helper(root?.right)
    }
    
    func recoverTree(_ root: TreeNode?) {
        helper(root)
        if let n1 = nodeOne, let n2 = nodeTwo {
            let t = n1.val
            n1.val = n2.val
            n2.val = t
        }
    }
}
