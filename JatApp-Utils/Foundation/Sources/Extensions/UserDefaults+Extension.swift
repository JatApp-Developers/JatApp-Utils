//
//  UserDefaults+Extension.swift
//  JatApp-Foundation
//
//  Created by Developer on 10/16/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

public extension UserDefaults {
    
    func obtain<T: Decodable>(forKey key: String) -> T? {
        guard let decodableData = data(forKey: key) else { return nil }
        return T.fromJSONData(decodableData)
    }
    
    func store<T: Encodable>(encodable: T, forKey key: String) {
        if let data = encodable.toJSONData() {
            set(data, forKey: key)
        } else {
            assertionFailure("Couldn't encode \(T.self) to any data")
        }
    }
}

public extension UserDefaults {
    
    subscript<T: RawRepresentable>(key: String) -> T? {
        get {
            if let rawValue = value(forKey: key) as? T.RawValue {
                return T(rawValue: rawValue)
            }
            return nil
        }
        set {
            set(newValue?.rawValue, forKey: key)
        }
    }
    
    subscript<T>(key: String) -> T? {
        get {
            return value(forKey: key) as? T
        }
        set {
            set(newValue, forKey: key)
        }
    }
    
    subscript<T: Codable>(codable key: String) -> T? {
        get {
            guard let data = object(forKey: key) as? Data else { return nil }
            return try? JSONDecoder().decode(T.self, from: data)
        }
        set {
            guard let value = newValue else { return set(nil, forKey: key) }
            if let data = try? JSONEncoder().encode(value) {
                set(data, forKey: key)
            } else {
                assertionFailure("Couldn't encode \(T.self) to any data")
            }
        }
    }
    
    subscript<T, V: RawRepresentable>(key: V) -> T? where V.RawValue == String {
        get {
            return self[key.rawValue]
        }
        set {
            self[key.rawValue] = newValue
        }
    }
}
