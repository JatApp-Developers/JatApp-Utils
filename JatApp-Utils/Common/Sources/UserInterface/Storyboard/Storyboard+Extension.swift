//
//  Storyboard+Extension.swift
//  JatApp-Utils
//
//  Created by Developer on 2/6/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

#if os(macOS)
import Cocoa
#elseif os(iOS)
import UIKit
#endif

public extension Storyboard {
    
    func initial<T>() -> T {
        #if os(macOS)
        let controller = instantiateInitialController()
        #elseif os(iOS)
        let controller = instantiateInitialViewController()
        #endif
        guard let result = controller as? T else {
            fatalError("Oh no! Initial controller absent")
        }
        
        return result
    }
    
    func controller<T>(withIdentifier identifier: String) -> T {
        #if os(macOS)
        let controller = instantiateController(withIdentifier: identifier)
        #elseif os(iOS)
        let controller = instantiateViewController(withIdentifier: identifier)
        #endif
        guard let result = controller as? T else {
            fatalError("Oh no! \(identifier) controller absent")
        }
        
        return result
    }
}
