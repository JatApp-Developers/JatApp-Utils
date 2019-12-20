//
//  Equatable.swift
//  JatApp-Foundation
//
//  Created by Developer on 13.12.2019.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

public extension Equatable {
    
     /// Example:
     ///  error.code.isOne(of: NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet)
    func isOne(of items: Self...) -> Bool {
        items.contains(self)
    }
}

