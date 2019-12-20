//
//  Types.swift
//  JatApp-Utils
//
//  Created by Developer on 2/6/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

#if os(macOS)
import Cocoa

public typealias Storyboard = NSStoryboard
public typealias ViewController = NSViewController
public typealias Font = NSFont
public typealias BezierPath = NSBezierPath
public typealias Device = DesktopModel
public typealias Color = NSColor
public typealias Application = NSApplication
public typealias View = NSView

#elseif os(iOS)
import UIKit

public typealias Storyboard = UIStoryboard
public typealias ViewController = UIViewController
public typealias Font = UIFont
public typealias BezierPath = UIBezierPath
public typealias Device = UIDevice
public typealias Color = UIColor
public typealias Application = UIApplication
public typealias View = UIView

#endif
