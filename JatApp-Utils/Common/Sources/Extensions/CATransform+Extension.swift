//
//  CATransform+Extension.swift
//  JatApp-Utils
//
//  Created by Developer on 7/1/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import QuartzCore

public extension CATransform3D {
    
    func scale(x: CGFloat = 1, y: CGFloat = 1, z: CGFloat = 1) -> CATransform3D {
        return CATransform3DScale(self, x, y, z)
    }
    
    func translate(x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) -> CATransform3D {
        return CATransform3DTranslate(self, x, y, z)
    }
    
    func rotate(angle: CGFloat = 0, x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) -> CATransform3D {
        return CATransform3DRotate(self, angle, x, y, z)
    }
    
    func concat(_ transform: CATransform3D) -> CATransform3D {
        return CATransform3DConcat(self, transform)
    }
    
    func invert() -> CATransform3D {
        return CATransform3DInvert(self)
    }
}

