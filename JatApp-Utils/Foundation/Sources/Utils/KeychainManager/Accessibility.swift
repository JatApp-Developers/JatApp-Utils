//
//  Accessibility.swift
//  JatApp-Foundation
//
//  Created by Developer on 10/17/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

/// - warning:
/// If change accessibility attribute, first remove the previous key value using the same accessibilty it was saved with
public enum Accessibility {
    case always(thisDeviceOnly: Bool)
    case unlocked(thisDeviceOnly: Bool)
    case afterFirstUnlock(thisDeviceOnly: Bool)
    
    var stringValue: String {
        let result: CFString
        switch self {
        case .always(thisDeviceOnly: let isThisDeviceOnly):
            #if os(iOS)
            if #available(iOS 12, *) {
                result = isThisDeviceOnly ? kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly : kSecAttrAccessibleAfterFirstUnlock
            } else {
                result = isThisDeviceOnly ? kSecAttrAccessibleAlwaysThisDeviceOnly : kSecAttrAccessibleAlways
            }
            #elseif os(macOS)
            result = isThisDeviceOnly ? kSecAttrAccessibleAlwaysThisDeviceOnly : kSecAttrAccessibleAlways
            #endif
        case .unlocked(thisDeviceOnly: let isThisDeviceOnly):
            result = isThisDeviceOnly ? kSecAttrAccessibleWhenUnlockedThisDeviceOnly : kSecAttrAccessibleWhenUnlocked
        case .afterFirstUnlock(thisDeviceOnly: let isThisDeviceOnly):
            result = isThisDeviceOnly ? kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly : kSecAttrAccessibleAfterFirstUnlock
        }
        return String(result)
    }
}
