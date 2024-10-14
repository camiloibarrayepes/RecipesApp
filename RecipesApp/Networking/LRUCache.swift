//
//  LRUCache.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 10/10/24.
//
import Foundation

// Define a protocol for cache functionality
protocol CacheProtocol: AnyObject {
    func put(key: String, value: [Recipe]) async
    func get(key: String) async -> [Recipe]?
}

// Define a node class for the doubly linked list
class CacheNode {
    let key: String
    var value: [Recipe]
    var prev: CacheNode?
    var next: CacheNode?

    init(key: String, value: [Recipe]) {
        self.key = key
        self.value = value
    }
}

// Implement the LRUCache as an actor
actor LRUCache: CacheProtocol {
    private var cache: [String: CacheNode] = [:]
    private var head: CacheNode?
    private var tail: CacheNode?
    private let capacity: Int

    // Initialize the cache with a specified capacity
    init(capacity: Int) {
        self.capacity = capacity
    }

    // Get a value from the cache by key
    func get(key: String) async -> [Recipe]? {
        guard let node = cache[key] else { return nil }
        moveToHead(node) // Move to the head as the most recently used
        return node.value
    }

    // Put a value into the cache
    func put(key: String, value: [Recipe]) {
        if let node = cache[key] {
            node.value = value
            moveToHead(node) // Update and move to the head
        } else {
            let newNode = CacheNode(key: key, value: value)
            cache[key] = newNode
            addNode(newNode) // Add a new node

            if cache.count > capacity {
                removeTail() // Remove the least used node if capacity is exceeded
            }
        }
    }

    // Helper method to add a new node to the head of the list
    private func addNode(_ node: CacheNode) {
        node.next = head
        node.prev = nil

        if let currentHead = head {
            currentHead.prev = node
        }
        head = node

        if tail == nil {
            tail = node
        }
    }

    // Helper method to remove a node from the list
    private func removeNode(_ node: CacheNode) {
        let prev = node.prev
        let next = node.next

        if let prevNode = prev {
            prevNode.next = next
        } else {
            head = next
        }

        if let nextNode = next {
            nextNode.prev = prev
        } else {
            tail = prev
        }

        cache[node.key] = nil
    }

    // Helper method to remove the least recently used (tail) node
    private func removeTail() {
        guard let tailNode = tail else { return }
        removeNode(tailNode)
    }

    // Helper method to move a node to the head of the list
    private func moveToHead(_ node: CacheNode) {
        removeNode(node)
        addNode(node)
    }
}
