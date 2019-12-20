//
//  CGPoint+Extension.swift
//  JatApp-Utils-macOS
//
//  Created by Developer on 2/15/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGRect {
    
    func distanceTo(centerOf rect: CGRect) -> CGFloat {
        return sqrt(pow(midX - rect.midX, 2) + pow(midY - rect.midY, 2))
    }
    
    func distanceFromCenterTo(_ point: CGPoint) -> CGFloat {
        return sqrt(pow(midX - point.x, 2) + pow(midY - point.y, 2))
    }
    
}
