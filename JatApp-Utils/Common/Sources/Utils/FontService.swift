//
//  FontService.swift
//  JatAppFoundation
//
//  Created by Developer on 2/12/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation
import CoreGraphics

public class FontService {
    
    public enum Style: String {
        case black = "Black"
        case bold = "Bold"
        case heavy = "Heavy"
        case light = "Light"
        case medium = "Medium"
        case regular = "Regular"
        case semibold = "Semibold"
        case thin = "Thin"
        
        public var weight: Font.Weight {
            switch self {
            case .black: return .black
            case .bold: return .bold
            case .heavy: return .heavy
            case .light: return .light
            case .medium: return .medium
            case .regular: return .regular
            case .semibold: return .semibold
            case .thin: return .thin
            }
        }
    }
    
    public enum Family {
        case primary
        case secondary
        case custom(_ number: Int)
        
        var key: String {
            switch self {
            case .primary: return "PrimaryFontFamily"
            case .secondary: return "SecondaryFontFamily"
            case .custom(let number): return "Custom\(number)FontFamily"
            }
        }
    }
    
    private static let defaults = UserDefaults.standard
    
    public static func setup(family: Family, as value: String) {
        defaults[family] = value
    }
    
    public static func font(family: Family, _ style: Style, size: CGFloat) -> Font {
        guard let family: String = defaults[family],
            let font = Font(name: "\(family)-\(style.rawValue)", size: size) else {
                return .systemFont(ofSize: size, weight: style.weight)
        }
        
        return font
    }
}

fileprivate extension UserDefaults {
    
    subscript<T>(key: FontService.Family) -> T? {
        get {
            return value(forKey: "FontService.\(key.key)") as? T
        }
        set {
            set(newValue, forKey: "FontService.\(key.key)")
        }
    }
}
