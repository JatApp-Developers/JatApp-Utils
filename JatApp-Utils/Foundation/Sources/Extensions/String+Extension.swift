//
//  String+Extension.swift
//  JatApp-Foundation
//
//  Created by Developer on 4/12/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation
import CommonCrypto

public extension String {
    
    var md5String: String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        
        if let data = data(using: .utf8) {
            _ = data.withUnsafeBytes { body in
                if let buffer: UnsafePointer<UInt8> = body.baseAddress?.assumingMemoryBound(to: UInt8.self) {
                    CC_MD5(buffer, CC_LONG(data.count), &digest)
                }
            }
        }
        
        return digest.reduce("") { $0 + String(format:"%02x", $1) }
    }
    
    func string(afterLast substring: String, options: CompareOptions) -> String? {
        if let range = range(of: substring, options: options, range: nil, locale: nil) {
            let indexStart = range.upperBound
            let string = String(self[indexStart...])
            return string
        }
        return nil
    }
    
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
