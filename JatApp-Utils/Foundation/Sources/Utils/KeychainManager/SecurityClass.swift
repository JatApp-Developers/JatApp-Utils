//
//  SecurityClass.swift
//  JatApp-Foundation
//
//  Created by Developer on 10/16/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

public enum SecurityClass: RawRepresentable, CaseIterable {
    
    public typealias RawValue = String
    
    case genericPassword, internetPassword, certificate, key, identity
    
    public init?(rawValue: String) {
        switch rawValue {
        case String(kSecClassGenericPassword):
            self = .genericPassword
        case String(kSecClassInternetPassword):
            self = .internetPassword
        case String(kSecClassCertificate):
            self = .certificate
        case String(kSecClassKey):
            self = .key
        case String(kSecClassIdentity):
            self = .identity
        default:
            self = .genericPassword
        }
    }
    
    public var rawValue: String {
        switch self {
        case .genericPassword:
            return String(kSecClassGenericPassword)
        case .internetPassword:
            return String(kSecClassInternetPassword)
        case .certificate:
            return String(kSecClassCertificate)
        case .key:
            return String(kSecClassKey)
        case .identity:
            return String(kSecClassIdentity)
        }
    }
}
