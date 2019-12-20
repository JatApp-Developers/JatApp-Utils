//
//  UIWindow+Extension.swift
//  JatApp-Utils-iOS
//
//  Created by Developer on 2/21/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import UIKit

public extension UIWindow {
	
	func change(root viewController: UIViewController, animated: Bool) {
		
		if animated, let snapshot = self.snapshotView(afterScreenUpdates: true) {
			viewController.view.addSubview(snapshot)
			
			UIView.animate(withDuration: 0.3, animations: {
				snapshot.layer.opacity = 0
				snapshot.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.1)
			}) { finished in
				snapshot.removeFromSuperview()
			}
		}
		rootViewController = viewController
	}
}
