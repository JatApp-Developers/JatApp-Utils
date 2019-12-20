//
//  WeakIterator.swift
//  JatApp-Utils
//
//  Created by Developer on 3/20/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

public final class WeakIterator<T>: IteratorProtocol {
    
    private var iterator: NSFastEnumerationIterator
    
    init(_ iterator: NSFastEnumerationIterator) {
        self.iterator = iterator
    }
    
    public func next() -> T? {
        
        while let object = iterator.next() {
            if let reference = object as? WeakBox<T>, let object = reference.object {
                return object
            }
        }
        
        return nil
    }
}
