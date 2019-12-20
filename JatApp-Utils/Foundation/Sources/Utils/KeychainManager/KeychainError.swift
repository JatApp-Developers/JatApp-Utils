//
//  KeychainError.swift
//  JatApp-Foundation
//
//  Created by Developer on 10/17/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

public enum KeychainError: String, Error {
    
    case notFound
    case unexpected
    case emptyResults
    
    var stringValue: String {
        
        switch self {
        case .notFound:
            return "The item not found"
        case .unexpected:
            return "Unexpected error has occurred"
        case .emptyResults:
            return "No results found"
        }
    }
}
