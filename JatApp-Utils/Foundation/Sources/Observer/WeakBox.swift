//
//  WeakBox.swift
//  JatApp-Utils
//
//  Created by Developer on 3/20/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

/// Using WeakBox we can turn any strong reference into a weak one
///
public final class WeakBox<T>: NSObject {
    
    private weak var weakObject: AnyObject?
    
    private let memoryAddress: Int
    
    public var object: T? {
        return weakObject as? T
    }
    
    public init(_ object: T) {
        self.memoryAddress = unsafeBitCast(object as AnyObject, to: Int.self)
        self.weakObject = object as AnyObject
        super.init()
    }
    
    public override var hash: Int {
        return memoryAddress
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        if let reference = object as? WeakBox {
            return self.memoryAddress == reference.memoryAddress
        }
        return false
    }
}
