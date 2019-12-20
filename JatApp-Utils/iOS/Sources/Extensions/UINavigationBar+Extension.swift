//
//  UINavigationBar+Extension.swift
//  JatApp-Utils
//
//  Created by Developer on 2/13/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import UIKit

public extension UINavigationBar {
    
    func makeTransparent() {
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
    }
    
    func undoTransparency() {
        setBackgroundImage(nil, for: .default)
    }
    
    func setupDefaultSettings() {
        barTintColor = .white
        tintColor = UIColor(red: 48.0/255.0, green: 62.0/255.0, blue: 78.0/255.0, alpha: 1.0)
        shadowImage = UIImage()
    }
}

