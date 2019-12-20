//
//  LocalizationAdapter.swift
//  JatAppFoundation
//
//  Created by Developer on 1/11/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

#if os(macOS)
import Cocoa
#else
import UIKit
#endif

public struct LocalizationAdapter {
    
    public enum Language {
        case hindi
        case turkish
        //Add language if needed
        
        var code: String {
            switch self {
            case .hindi: return "hi"
            case .turkish: return "tr"
            }
        }
    }

    public static var isRightToLeftAdaptNeeded: Bool {
        return Application.shared.userInterfaceLayoutDirection == .rightToLeft
    }

    public static func rightToLeftAdapt(_ adaptBlock: () -> ()) {
        if isRightToLeftAdaptNeeded {
            adaptBlock()
        }
    }
    
    public static func adaptFor(_ languages: Language..., adaptBlock: () -> ()) {
        let code = Locale.current.languageCode
        if languages.contains(where: { $0.code == code }) {
            adaptBlock()
        }
    }
    
    public static func adaptExept(_ languages: Language..., adaptBlock: () -> ()) {
        let code = Locale.current.languageCode
        if !languages.contains(where: { $0.code == code }) {
            adaptBlock()
        }
    }
}
