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
    var maxSum = Int.min
    
    func helper(_ root: TreeNode?) -> Int {
        guard root != nil else { return 0 }
        let n = root!.val
        let l = max(helper(root?.left), 0)
        let r = max(helper(root?.right), 0)
        maxSum = max(maxSum, n + l + r)
        return n + max(l, r)
    }
    
    func maxPathSum(_ root: TreeNode?) -> Int {
        helper(root)
        return maxSum
    }
}
