//
//  WeakSet.swift
//  JatApp-Utils
//
//  Created by Developer on 3/20/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

public final class WeakSet<T>: ExpressibleByArrayLiteral {
    
    private var objects = NSMutableSet()
    private var queue = DispatchQueue(label: "WeakSetQueue", attributes: .concurrent)
    
    public var count: Int {
        var result = 0
        queue.sync {
            result = self.objects.count
        }
        return result
    }
    
    // MARK: - Initialization
    public convenience required init(arrayLiteral elements: T...) {
        self.init(elements)
    }
    
    public init<S: Sequence>(_ sequence: S) where S.Iterator.Element == T {
        for element in sequence {
            insert(element)
        }
    }
    
    public func insert(_ object: T) {
        
        if !contains(object) {
            queue.async(flags: .barrier) {
                let reference = WeakBox(object)
                self.objects.add(reference)
            }
        }
    }
    
    public func remove(_ object: T) {
        
        queue.async(flags: .barrier) {
            let reference = WeakBox(object)
            self.objects.remove(reference)
        }
    }
    
    public func removeAllObjects() {
        allObjects.forEach { remove($0) }
    }
    
    public func contains(_ object: T) -> Bool {
        
        var result = false
        queue.sync {
            let reference = WeakBox(object)
            result = objects.contains(reference) && reference.object != nil
        }
        return result
    }
    
    public func cleanup() {
        
        let copy = objects.copy() as! NSSet
        copy.allObjects.forEach {
            guard let reference = $0 as? WeakBox<T>, reference.object == nil else {
                return
            }
            objects.remove($0)
        }
    }
    
    public var allObjects: [T] {
        cleanup()
        var result: [T] = []
        queue.sync { result = self.map { return $0 } }
        return result
    }
}

extension WeakSet: Sequence {
    
    public typealias Iterator = WeakIterator<T>
    
    public func makeIterator() -> Iterator {
        let copy = objects.copy() as! NSSet
        return Iterator(copy.makeIterator())
    }
}
