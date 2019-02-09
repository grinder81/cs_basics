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
            self.insert(word: word)
        }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.words, forKey: "words")
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
    
    func contains(word: String) -> Bool {
        guard !word.isEmpty else { return false }
        
        var currentNode = root
        let characters = Array(word.lowercased())
        var index = 0
        while index < characters.count, let childNode = currentNode.children[characters[index]] {
            currentNode = childNode
            index += 1
        }
        guard index == characters.count, currentNode.isTerminating else { return false }
        return true
    }
    
    func remove(word: String) {
        guard !word.isEmpty else { return }
        guard let terminalNode = findTerminalNodeOf(word: word) else {
            return
        }
        if terminalNode.isLeaf {
            deleteNodesForWordEndingWith(terminalNode: terminalNode)
        } else {
            terminalNode.isTerminating = false
        }
        wordCount -= 1
    }
    
    private func findTerminalNodeOf(word: String) -> Node? {
        let characters = Array(word.lowercased())
        var currentNode = root
        for character in characters {
            guard let childNode = currentNode.children[character] else {
                return nil
            }
            currentNode = childNode
        }
        return currentNode.isTerminating ? currentNode : nil
    }
    
    private func deleteNodesForWordEndingWith(terminalNode: Node) {
        var lastNode = terminalNode
        var character = lastNode.value
        while lastNode.isLeaf, let parentNode = lastNode.parent {
            lastNode = parentNode
            lastNode.children[character!] = nil
            character = lastNode.value
            if lastNode.isTerminating {
                break
            }
        }
    }
    
    func wordsWith(prefix word: String) -> [String] {
        var words: [String] = []
        let lowerCased = word.lowercased()
        if let lastNode = findLastNodeOf(word: word) {
            if lastNode.isTerminating {
                words.append(lowerCased)
            }
            for childNode in lastNode.children.values {
                let childWors = wordsInSubtrie(rootNode: childNode, partialWord: lowerCased)
                words += childWors
            }
        }
        return words
    }
    
    private func findLastNodeOf(word: String) -> Node? {
        var characters = Array(word.lowercased())
        var currentNode = root
        for character in characters {
            guard let childNode = currentNode.children[character] else { return nil }
            currentNode = childNode
        }
        return currentNode
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

var t = Trie()
t.insert(word: "Hello")
t.insert(word: "Hel")
t.contains(word: "Hel")
t.contains(word: "Hel")
t.wordsWith(prefix: "He")

