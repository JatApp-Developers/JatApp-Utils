//
//  EncodableType.swift
//  JatApp-Foundation
//
//  Created by Developer on 11/4/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

/// A type that can encode itself into dictionary
public protocol EncodableType {
    func encode() -> [String: Any]
}

public extension EncodableType {
    
    /// `Data` form of encoding
    ///
    /// - returns: `Data`
    func toJSONData() -> Data? {
        return try? JSONSerialization.data(withJSONObject: encode(), options: [])
    }
    
    /// `String` form of encoding
    ///
    /// - returns: `String`
    func toJSONString() -> String? {
        return self.toJSONData().flatMap { String(data: $0, encoding: .utf8) }
    }
}
