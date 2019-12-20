//
//  BaseRouter.swift
//  JatApp-Utils-iOS
//
//  Created by Developer on 2/14/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import UIKit

// MARK: - BaseRouter
public protocol BaseRouter {
    
    associatedtype ViewType
    
    var view: ViewType? { get set }
    var viewController: UIViewController? { get }
    var navigationController: UINavigationController? { get }
}

public extension BaseRouter {
    
    var viewController: UIViewController? {
        return view as? UIViewController
    }
    
    var navigationController: UINavigationController? {
        return viewController?.navigationController
    }
}

public protocol RouterPresentable {
    func push(viewController: UIViewController)
    func present(viewController: UIViewController, transitionStyle: UIModalTransitionStyle)
}

public extension RouterPresentable where Self: BaseRouter {
    
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(viewController: UIViewController, transitionStyle: UIModalTransitionStyle = .coverVertical) {
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = transitionStyle
        navigationController?.present(viewController, animated: true, completion: nil)
    }
}

public protocol RouterDismissable {
    func pop()
    func pop(to viewController: UIViewController)
    func popToRoot()
    
    func dismiss(viewController: UIViewController?)
}

public extension RouterDismissable where Self: BaseRouter {
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func pop(to viewController: UIViewController) {
        navigationController?.popToViewController(viewController, animated: true)
    }
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func dismiss(viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) {
        let visibleViewController = navigationController?.visibleViewController
        visibleViewController?.dismiss(animated: true, completion: nil)
    }
}
