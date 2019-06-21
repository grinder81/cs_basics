import UIKit

/*
 class Node {
     public int val;
     public Node left;
     public Node right;
    
     public Node() {}
    
     public Node(int _val,Node _left,Node _right) {
         val = _val;
         left = _left;
         right = _right;
     }
 };
class Solution {
    Node head;
    Node tail;
    
    private void helper(Node node) {
    if (node != null) {
    helper(node.left);
    if (tail != null) {
    tail.right = node;
    node.left = tail;
    } else {
    head = node;
    }
    tail = node;
    helper(node.right);
    }
    }
    
    public Node treeToDoublyList(Node root) {
    if (root == null) {
    return root;
    }
    helper(root);
    head.left = tail;
    tail.right = head;
    return head;
    }
}
*/
