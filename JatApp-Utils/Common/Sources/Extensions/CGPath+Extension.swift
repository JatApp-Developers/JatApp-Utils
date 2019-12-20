//
//  CGPath+Extension.swift
//  JatApp-Utils
//
//  Created by Developer on 7/25/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

#if os(macOS)
import Cocoa
#elseif os(iOS)
import UIKit
#endif
import CoreGraphics

public extension CGPath {
    
    func drawInnerShadow(with context: CGContext,
                         shadowColor: CGColor = Color.black.withAlphaComponent(1 / 3).cgColor, // default NSShadow color
                         blur: CGFloat = 3.0, // CALayer default
                         offset: CGSize = CGSize(width: 0, height: -3)) {  // CALayer default
        context.saveGState()
        context.addPath(self)
        context.clip()
        let colorWithoutAlpha = shadowColor.copy(alpha: 1.0) ?? shadowColor
        context.setAlpha(shadowColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        context.setShadow(offset: offset, blur: blur, color: colorWithoutAlpha)
        context.setBlendMode(.sourceOut)
        context.setFillColor(colorWithoutAlpha)
        context.addPath(self)
        context.fillPath()
        context.endTransparencyLayer()
        context.restoreGState()
    }
}
