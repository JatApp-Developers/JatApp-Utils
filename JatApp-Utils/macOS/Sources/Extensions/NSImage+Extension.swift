//
//  NSImage+Extension.swift
//  JatApp-Utils-macOS
//
//  Created by Developer on 4/4/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Cocoa

public extension NSImage {
    
    func withCornerRadius(_ cornerRadius: CGFloat) -> NSImage {
        let image = NSImage(size: size)
        let rect = NSRect(origin: .zero, size: size)
        let path = NSBezierPath(roundedRect: rect, xRadius: cornerRadius, yRadius: cornerRadius)
        image.lockFocus()
        path.addClip()
        draw(in: rect, from: rect, operation: .sourceOver, fraction: 1.0)
        image.unlockFocus()
        return image
    }
    
    func resized(proportionallyTo width: CGFloat) -> NSImage? {
        let coefficient = width / size.width
        return resized(to: NSSize(width: width, height: size.height * coefficient))
    }
    
    func resized(to size: NSSize) -> NSImage? {
        if isValid {
            let resized = NSImage(size: size)
            resized.lockFocus()
            self.size = size
            NSGraphicsContext.current?.imageInterpolation = .high
            draw(at: .zero, from: NSRect(origin: .zero, size: size), operation: .copy, fraction: 1.0)
            resized.unlockFocus()
            return resized
        }
        return nil
    }
    
    func withGradient(_ gradient: NSGradient?, angle: CGFloat = 0) -> NSImage {
        guard let gradient = gradient else {
            return self
        }
        
        let rect = NSRect(origin: .zero, size: size)
        let image = NSImage(size: size)
        
        image.lockFocus()
        gradient.draw(in: rect, angle: angle)
        draw(in: rect, from: rect, operation: .destinationAtop, fraction: 1.0)
        image.unlockFocus()
        
        return image
    }
    
    func withTintColor(_ tintColor: NSColor) -> NSImage {
        let image = copy() as! NSImage
        let rect = NSRect(origin: .zero, size: image.size)
        
        image.isTemplate = true
        image.lockFocus()
        tintColor.set()
        rect.fill(using: .sourceAtop)
        image.unlockFocus()
        image.isTemplate = false
        
        return image
    }
    
    func gradientAccented(with highlight: CGFloat = 0.7, angle: CGFloat = 90) -> NSImage {
        guard #available(OSX 10.14, *) else {
            return self
        }
        
        let color: NSColor = .controlAccentColor
        guard let highlight = color.highlight(withLevel: highlight), let gradient = NSGradient(colors: [color, highlight]) else {
            return self
        }
        
        return withGradient(gradient, angle: angle)
    }
    
    var accented: NSImage {
        guard #available(OSX 10.14, *) else {
            return self
        }
        
        return withTintColor(.controlAccentColor)
    }
    
    var mirror: NSImage {
        let mirror = NSImage(size: size)
        
        let transform = NSAffineTransform()
        transform.translateX(by: size.width, yBy: 0)
        transform.scaleX(by: -1, yBy: 1)
        
        mirror.lockFocus()
        NSGraphicsContext.current?.imageInterpolation = .high
        transform.concat()
        draw(at: .zero, from: NSRect(origin: .zero, size: size), operation: .sourceOver, fraction: 1.0)
        mirror.unlockFocus()
        return mirror
    }
}
