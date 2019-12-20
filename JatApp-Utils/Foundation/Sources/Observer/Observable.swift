//
//  Observable.swift
//  JatApp-Utils
//
//  Created by Developer on 3/20/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

/// Class that conforms to the `Observable` protocol implement the `notify` method
/// to send notifications to the `Observer`

/// - using `AnyObject` make possible to compare objects that implements protocol
public protocol Observable: AnyObject {
    
    associatedtype Observer
    
    func addObserver(_ observer: Observer) -> ObservationToken
    func addObservers(_ observers: [Observer]) -> [ObservationToken]
    
    func removeObserver(_ observer: Observer)
    func removeAllObservers()
    
    func notifyObservers(_ closure: (Observer) -> Void)
}

private var observerSetKey = "com.jatapp.foundation.observerSet"

public extension Observable {
    
    var observerSet: WeakSet<Observer> {
        return associatedValue(for: self, key: &observerSetKey, defaultValue: WeakSet<Observer>())
    }
    
    private var observers: [Observer] {
        return observerSet.allObjects
    }
    
    @discardableResult
    func addObserver(_ observer: Observer) -> ObservationToken {
        
        observerSet.insert(observer)
        let result = ObservationToken(cancellationClosure: { [weak self] in
            self?.removeObserver(observer)
        })
        
        return result
    }
    
    @discardableResult
    func addObservers(_ observers: [Observer]) -> [ObservationToken] {
        let observationTokens = observers.map { addObserver($0) }
        return observationTokens
    }
    
    func removeObserver(_ observer: Observer) {
        observerSet.remove(observer)
    }
    
    func removeAllObservers() {
        observerSet.removeAllObjects()
    }
    
    func notifyObservers(_ closure: (Observer) -> Void) {
        observers.forEach { closure($0) }
    }
    
    func notifyObservers<T>(_ closure: (T) -> Void) {
        observers.forEach {
            if let observer = $0 as? T {
                closure(observer)
            }
        }
    }
}
