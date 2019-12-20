//
//  GlobalFunctions.swift
//  JatApp-Utils
//
//  Created by Developer on 3/20/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

public func associatedValue<T>(for object: Any, key: UnsafeRawPointer, defaultValue: @autoclosure () -> T) -> T {
	return synchronized(object) {
		if let nonNilValue = objc_getAssociatedObject(object, key) {
			guard let typeSafeValue = nonNilValue as? T else {
				fatalError("Unexpected: different kind of value already exists for key '\(key)': \(nonNilValue)")
			}
			return typeSafeValue
		} else {
			let newValue = defaultValue()
			objc_setAssociatedObject(object, key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			assert(objc_getAssociatedObject(object, key) != nil, "Associated values are not supported for object: \(object)")
			assert(objc_getAssociatedObject(object, key) is T, "Associated value could not be cast back to specified type: \(String(describing: T.self))")
			return newValue
		}
	}
}

@discardableResult
public func synchronized<T>(_ object: Any, block: () throws -> T) rethrows -> T {
	objc_sync_enter(object)
	defer {
		objc_sync_exit(object)
	}
	return try block()
}
