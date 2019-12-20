//
//  Navigated.swift
//  JatApp-Utils-iOS
//
//  Created by Developer on 2/14/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    func navigated<T: UINavigationController>(_ classType: T.Type) -> T {
        return T(rootViewController: self)
    }
}
