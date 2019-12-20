//
//  KeychainSettings.swift
//  JatApp-Foundation
//
//  Created by Developer on 10/17/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

public class KeychainSettings {
    
    public var service: String!
    public var accessGroup: String!
    public var synchronizable: Bool!
    public var accessibility: Accessibility!
}

public extension KeychainSettings {
    
    static func with(_ completionHandler: (KeychainSettings) -> Void) -> KeychainSettings {
        let settings = KeychainSettings()
        completionHandler(settings)
        return settings
    }
}

public extension KeychainManager {
    
    static func with(_ completionHandler: (KeychainSettings) -> Void) -> KeychainManager {
        let settings = KeychainSettings()
        completionHandler(settings)
        return KeychainManager(settings: settings)
    }
}
