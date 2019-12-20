//
//  StoryboardConvertable.swift
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

public protocol StoryboardConvertable {
    
    var storyboard: Storyboard { get }
    var bundle: Bundle? { get }
}

public extension StoryboardConvertable where Self: RawRepresentable, Self.RawValue == String {
    
    var storyboard: Storyboard {
        return Storyboard(name: rawValue, bundle: bundle)
    }
    
    var bundle: Bundle? {
        return nil
    }
}
