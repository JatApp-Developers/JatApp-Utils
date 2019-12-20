//
//  Dictionary+Extension.swift
//  JatApp-Foundation
//
//  Created by Developer on 10/16/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    func prepareJSONData(prettify: Bool = false) -> Data? {
        
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }
    
    func prepareJSONString(prettify: Bool = false) -> String? {
        
        guard let jsonData = prepareJSONData(prettify: prettify) else {
            return nil
        }
        
        return String(data: jsonData, encoding: .utf8)
    }
}
