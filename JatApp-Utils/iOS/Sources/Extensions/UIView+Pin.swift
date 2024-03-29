//
//  UIView+Pin.swift
//  JatApp-Utils-iOS
//
//  Created by Developer on 14.11.2019.
//  Copyright © 2019 JatApp. All rights reserved.
//

import UIKit

public extension UIView {
    
    enum Position {
        case topRight(offset: CGPoint)
        case topMid(offset: CGPoint)
        case topLeft(offset: CGPoint)
        case midRight(offset: CGPoint)
        case center(offset: CGPoint)
        case midLeft(offset: CGPoint)
        case bottomRight(offset: CGPoint)
        case bottomMid(offset: CGPoint)
        case bottomLeft(offset: CGPoint)
        
        func constraints(superview: UIView, subview: UIView) -> [NSLayoutConstraint] {
            let constraints: [NSLayoutConstraint]
            switch self {
            case .topRight(let offset):
                constraints = [
                    subview.topAnchor.constraint(equalTo: superview.topAnchor, constant: offset.y),
                    subview.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: offset.x)
                ]
            case .topMid(let offset):
                constraints = [
                    subview.topAnchor.constraint(equalTo: superview.topAnchor, constant: offset.y),
                    subview.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: offset.x)
                ]
            case .topLeft(let offset):
                constraints = [
                    subview.topAnchor.constraint(equalTo: superview.topAnchor, constant: offset.y),
                    subview.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: offset.x)
                ]
                
            case .midRight(let offset):
                constraints = [
                    subview.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: offset.y),
                    subview.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: offset.x)
                ]
            case .center(let offset):
                constraints = [
                    subview.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: offset.y),
                    subview.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: offset.x)
                ]
            case .midLeft(let offset):
                constraints = [
                    subview.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: offset.y),
                    subview.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: offset.x)
                ]
            case .bottomRight(let offset):
                constraints = [
                    subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: offset.y),
                    subview.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: offset.x)
                ]
            case .bottomMid(let offset):
                constraints = [
                    subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: offset.y),
                    subview.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: offset.x)
                ]
            case .bottomLeft(let offset):
                constraints = [
                    subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: offset.y),
                    subview.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: offset.x)
                ]
            }
            return constraints
        }
    }
    
    enum Size {
        
        case equal
        case constant(width: CGFloat, height: CGFloat)
        case proportional(width: CGFloat, height: CGFloat)
        case width(_ value: CGFloat, proportionalHeight: CGFloat)
        case height(_ value: CGFloat, proportionalWidth: CGFloat)
        case protortionalWidth(value: CGFloat)
        case protortionalHeight(value: CGFloat)
        case constantWidth(value: CGFloat)
        case constantHeight(value: CGFloat)
        
        func constraints(superview: UIView, subview: UIView) -> [NSLayoutConstraint] {
            let constraints: [NSLayoutConstraint]
            
            switch self {
            case .equal:
                constraints = [
                    subview.widthAnchor.constraint(equalTo: superview.widthAnchor),
                    subview.heightAnchor.constraint(equalTo: superview.heightAnchor)
                ]
            case .constant(let width, let height):
                constraints = [
                    subview.widthAnchor.constraint(equalToConstant: width),
                    subview.heightAnchor.constraint(equalToConstant: height)
                ]
            case .proportional(let width, let height):
                constraints = [
                    subview.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: width),
                    subview.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: height)
                ]
            case .width(let value, let proportionalHeight):
                constraints = [
                    subview.widthAnchor.constraint(equalToConstant: value),
                    subview.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: proportionalHeight)
                ]
            case .height(let value, let proportionalWidth):
                constraints = [
                    subview.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: proportionalWidth),
                    subview.heightAnchor.constraint(equalToConstant: value),
                ]
            case .protortionalWidth(let value):
                constraints = [
                    subview.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: value)
                ]
            case .protortionalHeight(let value):
                constraints = [
                    subview.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: value)
                ]
            case .constantWidth(let value):
                constraints = [
                    subview.widthAnchor.constraint(equalToConstant: value)
                ]
            case .constantHeight(let value):
                constraints = [
                    subview.heightAnchor.constraint(equalToConstant: value)
                ]
            }
            return constraints
        }
    }
    
    func pinTo(view: UIView, addAsSubview: Bool = true, position: Position? = .center(offset: .zero), size: Size? = .equal) {
        translatesAutoresizingMaskIntoConstraints = false
        if addAsSubview {
            view.addSubview(self)
        }
        
        var constraints: [NSLayoutConstraint] = []
        
        if let positionConstraints = position?.constraints(superview: view, subview: self) {
            constraints.append(contentsOf: positionConstraints)
        }
        
        if let sizeConstraints = size?.constraints(superview: view, subview: self) {
            constraints.append(contentsOf: sizeConstraints)
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    func pinTo(view: UIView, addAsSubview: Bool = true, insets: UIEdgeInsets) {

        translatesAutoresizingMaskIntoConstraints = false
        if addAsSubview {
            view.addSubview(self)
        }
        
        let constraints: [NSLayoutConstraint] = [
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: insets.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func pinToSuperviewEdges(withInset inset: CGFloat = 0.0) {
        
        guard let superview = superview else {
            fatalError("View's (\(self)) superview must not be nil.")
        }
        
        let topAnchor: NSLayoutYAxisAnchor
        let bottomAnchor: NSLayoutYAxisAnchor
        let leadingAnchor: NSLayoutXAxisAnchor
        let trailingAnchor: NSLayoutXAxisAnchor

        if #available(iOS 11.0, *) {
            topAnchor = superview.safeAreaLayoutGuide.topAnchor
            bottomAnchor = superview.safeAreaLayoutGuide.bottomAnchor
            leadingAnchor = superview.safeAreaLayoutGuide.leadingAnchor
            trailingAnchor = superview.safeAreaLayoutGuide.trailingAnchor
        } else {
            topAnchor = superview.topAnchor
            bottomAnchor = superview.bottomAnchor
            leadingAnchor = superview.leadingAnchor
            trailingAnchor = superview.trailingAnchor
        }
        
        let constraints: [NSLayoutConstraint] = [
            topAnchor.constraint(equalTo: self.topAnchor, constant: inset),
            bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: inset),
            leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: inset)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
