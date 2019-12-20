//
//  Storyboarded.swift
//  JatApp-Utils
//
//  Created by Developer on 1/24/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

#if os(macOS)
import Cocoa
#elseif os(iOS)
import UIKit
#endif

public protocol Storyboarded {
    
    static func instantiateFromStoryboard(named name: StoryboardConvertable) -> Self
}

public extension Storyboarded where Self: ViewController {
    
    static func instantiateFromStoryboard(named name: StoryboardConvertable) -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        
        return name.storyboard.controller(withIdentifier: className)
    }
}
