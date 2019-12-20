//
//  ViewController+Extension.swift
//  JatApp-Utils
//
//  Created by Developer on 2/15/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

#if os(macOS)
import Cocoa
#elseif os(iOS)
import UIKit
#endif

public extension ViewController {

     static func instantiateInitial(storyboard: String) -> ViewController {
		
        let bundle = Bundle(for: self)
        let storyboard = Storyboard(name: storyboard, bundle: bundle)
        
        #if os(macOS)
        let controller = storyboard.instantiateInitialController()
        guard let result = controller as? NSViewController else {
            fatalError("Oh no! initial controller absent")
        }
        #elseif os(iOS)
        let controller = storyboard.instantiateInitialViewController()
        guard let result = controller else {
            fatalError("Oh no! initial controller absent")
        }
        #endif

        return result
    }
}
