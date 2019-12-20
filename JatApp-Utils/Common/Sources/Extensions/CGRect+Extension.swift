//
//  CGRect+Extension.swift
//  JatApp-Utils-macOS
//
//  Created by Developer on 2/15/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGPoint {
    
    func distanceTo(_ point: CGPoint) -> CGFloat {
        return sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))
    }
    
    func distanceTo(centerOf rect: CGRect) -> CGFloat {
        return sqrt(pow(x - rect.midX, 2) + pow(y - rect.midY, 2))
    }
    
}
