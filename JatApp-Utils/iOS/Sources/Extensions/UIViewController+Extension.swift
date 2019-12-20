//
//  UIViewController+Extension.swift
//  JatApp-Utils-iOS
//
//  Created by Developer on 2/25/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import UIKit

public extension UIViewController {
	
	var isModal: Bool {
		
		let isPresentingViewController = presentingViewController != nil
		let isNavigationViewController = navigationController?.presentingViewController?.presentedViewController == navigationController
		let isTabBarController = tabBarController?.presentingViewController is UITabBarController
		
		return isPresentingViewController || isNavigationViewController || isTabBarController || false
	}
}
