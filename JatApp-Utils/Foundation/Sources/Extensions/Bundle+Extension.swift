//
//  Bundle+Extension.swift
//  JatApp-Utils-iOS
//
//  Created by Developer on 2/25/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

public extension Bundle {
	
	func bundleObject() -> String {
		let nsObject = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
		return nsObject
	}
	
	var appVersion: Int {
		let infoDictionary = Bundle.main.infoDictionary
		let majorVersion = infoDictionary?["CFBundleShortVersionString"] as? String
		let minorVersion = infoDictionary?["CFBundleVersion"] as? String
		let trim = CharacterSet(charactersIn: ".")
		let cleanString = majorVersion?.components(separatedBy: trim).joined(separator: "")
		let majorVersionInteger = Int(cleanString ?? "") ?? 0 * 10
		let minorVersionInteger = Int(minorVersion ?? "") ?? 0
		let appVersion: Int = majorVersionInteger + minorVersionInteger
		return appVersion
	}
	
	var appMajorVersion: String? {
		let infoDictionary = Bundle.main.infoDictionary
		let majorVersion = infoDictionary?["CFBundleShortVersionString"] as? String
		return majorVersion
	}
	
	var appIdentifier: String? {
		let infoDictionary = Bundle.main.infoDictionary
		let identifier = infoDictionary?["CFBundleIdentifier"] as? String
		return identifier
	}
	
	var shortAppVersion: String? {
		let infoDictionary = Bundle.main.infoDictionary
		let majorVersion = infoDictionary?["CFBundleShortVersionString"] as? String
		let appMajorVersionString = "Version: \(majorVersion ?? "")"
		return appMajorVersionString
	}
	
	var bundleVersion: String? {
		let infoDictionary = Bundle.main.infoDictionary
		let minorVersion = infoDictionary?["CFBundleVersion"] as? String
		return minorVersion
	}
}
