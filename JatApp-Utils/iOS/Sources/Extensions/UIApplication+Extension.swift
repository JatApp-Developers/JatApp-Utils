//
//  UIApplication+Extension.swift
//  JatApp-Utils-iOS
//
//  Created by Developer on 2/25/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import UIKit

public extension UIApplication {
	
	class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
		
		if let tabBarController = controller as? UITabBarController,
			let selected = tabBarController.selectedViewController {
				return topViewController(controller: selected)
		}
		
		if let navigationController = controller as? UINavigationController,
			let visible = navigationController.visibleViewController {
				return topViewController(controller: visible)
		}
		
		if let presented = controller?.presentedViewController {
			return topViewController(controller: presented)
		}
		
		return controller
	}
	
	class func isRightToLeftLayoutDirection() -> Bool {
		return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
	}
}
