//
//  View+Extension.swift
//  JatApp-Foundation
//
//  Created by Developer on 12/18/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

public extension View {
    
    /// Creates and returns a new view that does not convert the autoresizing mask into constraints
    class func createForAutoLayout() -> Self {
        let view = self.init()
        view.prepare()
        return view
    }
    
    func prepare() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
