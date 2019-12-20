//
//  PrimitiveTypes+Extension.swift
//  JatApp-Utils-macOS
//
//  Created by Developer on 2/25/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

public extension Int {
	
	/// Convert Int to Boolean value
	var boolValue: Bool { return self != 0 }
}

public extension Bool {
	
	init<T: BinaryInteger>(_ intValue: T) {
		self.init(intValue != 0)
	}
}

public extension Float {
	
	func string(fractionDigits:Int) -> String {
		let formatter = NumberFormatter()
		formatter.minimumFractionDigits = fractionDigits
		formatter.maximumFractionDigits = fractionDigits
		formatter.roundingMode = .halfEven
		formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_US_POSIX")
		return formatter.string(for: self) ?? "\(self)"
	}
}
