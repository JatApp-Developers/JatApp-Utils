//
//  Sequence+Extension.swift
//  JatApp-Foundation
//
//  Created by Developer on 13.12.2019.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

public extension Sequence where Self.Element: Equatable {
    
    /// Example:
    ///  changedSettings.containsOne(of: .caseOne, .caseTwo)
    func containsOne(of items: Self.Element...) -> Bool {
        containsOne(of: items)
    }
    
    func containsOne<T: Sequence>(of items: T) -> Bool where T.Element == Self.Element {
        contains { items.contains($0) }
    }
}
