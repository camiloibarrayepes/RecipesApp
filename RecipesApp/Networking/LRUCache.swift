//
//  LRUCache.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 10/10/24.
//

import Foundation

// Nodo para la lista doblemente enlazada
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

// Clase para el caché LRU
class LRUCache {
    private var cache: [String: CacheNode] = [:] // Diccionario para acceso rápido
    private var head: CacheNode?
    private var tail: CacheNode?
    private let capacity: Int
    
    init(capacity: Int) {
        self.capacity = capacity
    }
    
    func get(key: String) -> [Recipe]? {
        guard let node = cache[key] else { return nil }
        moveToHead(node) // Mover el nodo a la cabeza (más recientemente utilizado)
        return node.value
    }
    
    func put(key: String, value: [Recipe]) {
        if let node = cache[key] {
            node.value = value
            moveToHead(node) // Actualizar y mover a la cabeza
        } else {
            let newNode = CacheNode(key: key, value: value)
            cache[key] = newNode
            addNode(newNode) // Añadir nuevo nodo a la cabeza
            
            if cache.count > capacity {
                removeTail() // Eliminar el nodo menos utilizado si se supera la capacidad
            }
        }
    }
    
    private func addNode(_ node: CacheNode) {
        node.next = head
        node.prev = nil
        
        if head != nil {
            head!.prev = node
        }
        head = node
        
        if tail == nil {
            tail = node
        }
    }
    
    private func removeNode(_ node: CacheNode) {
        let prev = node.prev
        let next = node.next
        
        if prev != nil {
            prev!.next = next
        } else {
            head = next
        }
        
        if next != nil {
            next!.prev = prev
        } else {
            tail = prev
        }
        
        cache[node.key] = nil
    }
    
    private func removeTail() {
        guard let tailNode = tail else { return }
        removeNode(tailNode)
    }
    
    private func moveToHead(_ node: CacheNode) {
        removeNode(node)
        addNode(node)
    }
}
