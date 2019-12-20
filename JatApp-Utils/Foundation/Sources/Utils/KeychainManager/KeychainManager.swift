//
//  KeychainManager.swift
//  JatApp-Utils-macOS
//
//  Created by Developer on 3/18/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation
import Security

/// A simple wrapper for the Keychain instance

/// Class Key Constant
private let Class = String(kSecClass)

/// Attribute Key Constants
private let AttributeAccessible = String(kSecAttrAccessible)

private let AttributeService = String(kSecAttrService)
private let AttributeGeneric = String(kSecAttrGeneric)
private let AttributeAccount = String(kSecAttrAccount)
private let AttributeAccessGroup = String(kSecAttrAccessGroup)
private let AttribureSynchronizable = String(kSecAttrSynchronizable)

/// Return Type Key Constants
private let ReturnData = String(kSecReturnData)
private let ReturnPersistentRef = String(kSecReturnPersistentRef)
private let ValuePersistentRef = String(kSecValuePersistentRef)
private let ReturnAttributes = String(kSecReturnAttributes)

/// Value Type Key Constants
private let ValueData = String(kSecValueData)

/// Search Constants
private let MatchLimit = String(kSecMatchLimit)
private let MatchLimitOne = String(kSecMatchLimitOne)
private let MatchLimitAll = String(kSecMatchLimitAll)

public protocol KeychainManageable: AnyObject {
    
    @discardableResult
    func insert(forKey key: String, with data: Data?) -> Bool
    func string(from persistentReference: Data) -> String?
    func dataRef(forKey key: String) -> Data?
    func data(forKey key: String) -> Data?
    func string(forKey key: String) -> String?
    func bool(forKey key: String) -> Bool?
    @discardableResult
    func update(forKey key: String, with data: Data?) -> Bool
    @discardableResult
    func remove(forKey key: String) -> Bool
    @discardableResult
    func removeAllKeys(_ securityClass: SecurityClass) -> Bool
    @discardableResult
    func removeAllKeys() -> Bool
    func removeAllKeys(except list: [String])
    func wipe()
    subscript(key: String) -> Data? { get set }
    subscript(key: String) -> String? { get set }
    subscript(key: String) -> Bool? { get set }
}

public extension KeychainManageable {
    
    /// Set `nil` to remove `Data` object  for a specified key name
    subscript(key: String) -> Data? {
        get {
            return data(forKey: key)
        }
        set {
            guard let newValue = newValue else {
                remove(forKey: key)
                return
            }
            
            insert(forKey: key, with: newValue)
        }
    }
    
    /// Set `nil` to remove `String` object for a specified key name
    subscript(key: String) -> String? {
        get {
            return string(forKey: key)
        }
        set {
            guard let newValue = newValue else {
                remove(forKey: key)
                return
            }
            
            let data = newValue.data(using:.utf8)
            
            insert(forKey: key, with: data)
        }
    }
    
    /// Set `nil` to remove `Bool` object  for a specified key name
    subscript(key: String) -> Bool? {
        get {
            return bool(forKey: key)
        }
        set {
            guard let newValue = newValue else {
                remove(forKey: key)
                return
            }
            
            let bytes: Bytes = newValue ? [1] : [0]
            let data = Data(bytes)
            
            insert(forKey: key, with: data)
        }
    }
}

public class KeychainManager: KeychainManageable {
    
    /// Common identifier that all keys are linked to
    var service: String = ""
    /// Used to share keychain items between applications
    var accessGroup: String? = nil
    var synchronizable: Bool
    var accessibility: Accessibility

    public init(settings: KeychainSettings) {
        self.service = settings.service
        self.accessGroup = settings.accessGroup
        self.synchronizable = settings.synchronizable
        self.accessibility = settings.accessibility 
    }
    
    /// Prepare the keychain query dictionary used to access the keychain for a specified key name
    ///  - parameter key: the key this query is for
    ///  - returns: *dictionary* with all the needed properties setup to access the keychain
    private func prepareDictionary(key: String? = nil) -> [String: Any] {
        
        var dictionary: [String: Any] = [:]
        
        /// Setup default access as generic password
        dictionary[Class] = String(kSecClassGenericPassword)
        
        /// Uniquely identify this keychain accessor
        dictionary[AttributeService] = service
        
        /// Set accessibility attribute
        dictionary[AttributeAccessible] = accessibility.stringValue
        
        if synchronizable {
            dictionary[AttribureSynchronizable] = kCFBooleanTrue
        }
        
        /// Set the keychain access group if defined
        if let accessGroup = self.accessGroup {
            dictionary[AttributeAccessGroup] = accessGroup
        }
        
        /// Uniquely identify the account who will be accessing the keychain
        if let key = key {
            let encodedKey: Data? = key.data(using: .utf8)
            dictionary[AttributeGeneric] = encodedKey
            dictionary[AttributeAccount] = encodedKey
        }
        
        return dictionary
    }
    
    /// Save a Data object to the keychain associated with a specified key. If data
    /// already exists for the given key, it will be overwritten with the new value
    @discardableResult
    public func insert(forKey key: String, with data: Data?) -> Bool {
        
        var dictionary = prepareDictionary(key: key)
        
        dictionary[ValueData] = data
        
        /// Specify we want persistent Data/CFData reference returned
        dictionary[ReturnPersistentRef] = kCFBooleanTrue
        
        let status = SecItemAdd(dictionary as CFDictionary, nil)
        if status == errSecSuccess {
            return true
        } else if status == errSecDuplicateItem {
            return update(forKey: key, with: data)
        } else {
            return false
        }
    }
    
    /// This function converts persistent data reference object to string representation
    ///
    /// - returns: A String representation of previosly stored object
    public func string(from persistentReference: Data) -> String? {
        var returnValue: String?
        var dictionary = [String: Any]()
        dictionary[Class] = String(kSecClassGenericPassword)
        dictionary[ReturnData] = kCFBooleanTrue
        dictionary[ValuePersistentRef] = persistentReference
        
        var result: CFTypeRef? = nil
        let status = SecItemCopyMatching(dictionary as CFDictionary, &result)
        if let passwordData = result as? Data, status == errSecSuccess {
            returnValue = String(data: passwordData, encoding: .utf8)
        }
        return returnValue
    }
    
    
    /// - returns: A persistent data reference object for a specified key
    public func dataRef(forKey key: String) -> Data? {
        var dictionary = prepareDictionary(key: key)
        
        /// Limit search results to one
        dictionary[MatchLimit] = MatchLimitOne
        
        /// Specify we want persistent Data/CFData reference returned
        dictionary[ReturnPersistentRef] = kCFBooleanTrue
        
        var result: CFTypeRef? = nil
        let status = SecItemCopyMatching(dictionary as CFDictionary, &result)
        if status != errSecSuccess {
            return nil
        }
        return result as? Data
    }
    
    /// - returns: A Data object for a specified key
    public func data(forKey key: String) -> Data? {
        var dictionary = prepareDictionary(key: key)
        
        /// Limit search results to one
        dictionary[MatchLimit] = MatchLimitOne
        
        /// Specify we want Data/CFData returned
        dictionary[ReturnData] = kCFBooleanTrue
        
        var result: AnyObject?
        let status = SecItemCopyMatching(dictionary as CFDictionary, &result)
        return status == noErr ? result as? Data : nil
    }
    
    /// - returns: A string value for a specified key
    public func string(forKey key: String) -> String? {
        guard let data = data(forKey: key) else {
            return nil
        }
        return String(data: data, encoding: .utf8) as String?
    }
    
    /// - returns: The boolean value that corresponds to the given key.
    /// `nil` if unable to read the data
    public func bool(forKey key: String) -> Bool? {
        guard let data = data(forKey: key) else {
            return nil
        }
        guard let byte = data.first else {
            return nil
        }
        return byte == 1
    }
    
    /// Update existing data associated with a specified key name
    public func update(forKey key: String, with data: Data?) -> Bool {
        let dictionary = prepareDictionary(key: key)
        var dictUpdate = [String: Any]()
        dictUpdate[ValueData] = data
        
        let status = SecItemUpdate(dictionary as CFDictionary, dictUpdate as CFDictionary)
        return status == errSecSuccess
    }
    
    /// Remove an object associated with a specified key
    @discardableResult
    public func remove(forKey key: String) -> Bool {
        let dictionary = prepareDictionary(key: key)
        
        let status = SecItemDelete(dictionary as CFDictionary)
        if status != errSecSuccess && status != errSecItemNotFound {
            return false
        }
        return true
    }
    
    /// Remove all keychain data added through KeychainManager
    @discardableResult
    public func removeAllKeys(_ securityClass: SecurityClass) -> Bool {
        var dictionary: [String: Any] = [:]

        dictionary[Class] = securityClass.rawValue
        dictionary[AttributeService] = service
        if let accessGroup = self.accessGroup {
            dictionary[AttributeAccessGroup] = accessGroup
        }
        
        let status = SecItemDelete(dictionary as CFDictionary)
        if status != errSecSuccess && status != errSecItemNotFound {
            return false
        }
        return true
    }
    
    /// Remove all generic password data added through KeychainManager
    @discardableResult
    public func removeAllKeys() -> Bool {
        removeAllKeys(.genericPassword)
    }
    
    /// Remove all keychain data added through KeychainManager except list of keys
    /// - parameter list: the list of keys to keep from deletion in KeychainManager
    public func removeAllKeys(except list: [String]) {
        
        do {
            let allKeys = try obtainAllKeys()
            let filteredKeys = allKeys.filter { !list.contains($0) }
            filteredKeys.forEach { remove(forKey: $0) }
        } catch let error {
            print("Failed to remove keys. Reason: \(error.localizedDescription)")
        }
    }
    
    /// Obtain all keys previously used to persist any data
    private func obtainAllKeys() throws -> [String] {
        
        var dictionary = prepareDictionary()
        dictionary[ReturnAttributes] = kCFBooleanTrue
        dictionary[MatchLimit] = MatchLimitAll
        
        var result: CFTypeRef? = nil
        let status = SecItemCopyMatching(dictionary as CFDictionary, &result)
        guard status == errSecSuccess else {
            throw KeychainError.unexpected
        }
        
        guard let results = result as? [[AnyHashable: Any]] else {
            throw KeychainError.emptyResults
        }
        
        return results.compactMap {
            guard let accountData = $0[AttributeAccount] as? Data else { return nil }
            return String(data: accountData, encoding: .utf8)
        }
    }
    
    /// Remove all keychain data
    public func wipe() {
                
        SecurityClass.allCases.forEach {
            removeAllKeys($0)
        }
    }
}
