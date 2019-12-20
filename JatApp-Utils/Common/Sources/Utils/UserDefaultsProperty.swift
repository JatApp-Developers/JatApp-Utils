//
//  UserDefaultsProperty.swift
//  JatAppFoundation
//
//  Created by Developer on 12/20/18.
//  Copyright © 2018 JatApp. All rights reserved.
//

import Foundation

public class UserDefaultsProperty<ValueType>: NSObject {
    public typealias ValueChangedCallback = (ValueType) -> Void
    
    private let defaults: UserDefaults
    private let key: UserDefaultsKey
    private let notifyQueue: DispatchQueue
    private let defaultValue: ValueType
    
    private var valueChangedCallback: ValueChangedCallback?
    
    public var value: ValueType {
        get {
            return defaults.value(forKey: key.userDefaultsKeyValue) as? ValueType ?? defaultValue
        }
        set {
            defaults.set(newValue, forKey: key.userDefaultsKeyValue)
        }
    }
    
    public init(key: UserDefaultsKey, defaultValue: ValueType, notifyQueue: DispatchQueue = .main, defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.key = key
        self.notifyQueue = notifyQueue
        self.defaultValue = defaultValue
        super.init()
        
        #if DEBUG
        if key.userDefaultsKeyValue.contains(".") {
            print("UserDefaultsProperty - \(key.userDefaultsKeyValue): UserDefaults key contains \".\"(dot). Property updates subscription is unsupported")
        }
        #endif
        
        if defaults.value(forKey: self.key.userDefaultsKeyValue) as? ValueType == nil {
            value = defaultValue
        }
        
        defaults.addObserver(self, forKeyPath: self.key.userDefaultsKeyValue, options: [.new], context: nil)
    }
    
    public func subscribe(callback: @escaping ValueChangedCallback) {
        valueChangedCallback = callback
    }
    
    public func subscribeAndCall(callback: @escaping ValueChangedCallback) {
        valueChangedCallback = callback
        callback(value)
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard let newValue = change?[.newKey] as? ValueType else {return}
        notifyQueue.async {[weak self] in
            self?.valueChangedCallback?(newValue)
        }
    }
    
    deinit {
        defaults.removeObserver(self, forKeyPath: key.userDefaultsKeyValue)
    }
}

public protocol UserDefaultsKey {
    var userDefaultsKeyValue: String { get }
}

extension String: UserDefaultsKey {
    public var userDefaultsKeyValue: String {
        return self
    }
}

public extension UserDefaultsKey where Self: RawRepresentable, Self.RawValue == String {
    
    var userDefaultsKeyValue: String {
        return rawValue
    }
}
