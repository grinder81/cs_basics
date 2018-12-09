import Foundation

/// A node in the trie
/// Represent single character of a word
class TrieNode<T: Hashable> {
    var value: T?
    weak var parent: TrieNode?
    var children: [T: TrieNode] = [:]
    var isTerminating = false
    var isLeaf: Bool {
        return children.count == 0
    }
    
    init(value: T? = nil, parent: TrieNode? = nil) {
        self.value = value
        self.parent = parent
    }
    
    func add(child value: T) {
        guard children[value] == nil else { return }
        children[value] = TrieNode(value: value, parent: self)
    }
}

/// Represent as word
/// each node present as a character
class Trie: NSObject, NSCoding {
    typealias Node = TrieNode<Character>
    
    private let root: Node
    private var wordCount: Int
    
    override init() {
        root = Node()
        wordCount = 0
        super.init()
    }
    
    required convenience init?(coder decoder: NSCoder) {
        self.init()
        let words = decoder.decodeObject(forKey: "words") as? [String]
        for word in words! {
            //self.insert(word: word)
        }
    }
    
    func encode(with coder: NSCoder) {
        //coder.encode(self.words, forKey: "words")
    }
    
    /// All words currently in the trie
    public var words: [String] {
        return wordsInSubtrie(rootNode: root, partialWord: "")
    }
    
    func insert(word: String) {
        guard word.isEmpty == false else { return }
        var currentNode = root
        for character in word.lowercased() {
            if let childNode = currentNode.children[character] {
                currentNode = childNode
            } else {
                currentNode.add(child: character)
                currentNode = currentNode.children[character]!
            }
        }
        
        guard currentNode.isTerminating == false else { return }
        wordCount += 1
        currentNode.isTerminating = true
    }
    
    private func wordsInSubtrie(rootNode: Node, partialWord: String) -> [String] {
        var subtrieWords = [String]()
        var previousLetters = partialWord
        
        if let value = rootNode.value {
            previousLetters.append(value)
        }
        
        if rootNode.isTerminating {
            subtrieWords.append(previousLetters)
        }
        
        for childNode in rootNode.children.values {
            let childWords = wordsInSubtrie(rootNode: childNode, partialWord: previousLetters)
            subtrieWords += childWords
        }
        
        return subtrieWords
    }
}

var strArray1 = [String]()
var strArray2 = [String]()

strArray1.append("1")
strArray1.append("2")
strArray1.append("3")
strArray1.append("4")

strArray2.append("A")
strArray2.append("B")
strArray2.append("C")
strArray2.append("D")

strArray1.append(contentsOf: strArray2)
