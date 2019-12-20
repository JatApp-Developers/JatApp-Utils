//
//  Logger.swift
//  JatApp-Foundation
//
//  Created by Developer on 3/12/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

public protocol Logging {

    static func makeLogging(active isActive: Bool)
    static func log(_ value: Any...)
}

public class Logger {
    
    private let path: URL? = {
        let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        if let directory = directory {
            let path = directory.appendingPathComponent("0475148A-4EE3-4F85-A54C-D3A15BADD933")
            return path
        }
        return nil
    }()
    
    private func shouldClean(at path: String) -> Bool {
        let limit = 10 * 1024 * 1024
        let attributes = try? FileManager.default.attributesOfItem(atPath: path)
        if let attributes = attributes, let size = attributes[FileAttributeKey.size] as? UInt64 {
            return size > limit
        }
        return false
    }
    
    private init() {}
    
    private let shouldUseLoggerDefaultsKey = "com.jatapp.foundation.shouldUseLogger"
    
    private var shouldUseLogger: Bool {
        get {
            return UserDefaults.standard.bool(forKey: shouldUseLoggerDefaultsKey)
        }
        set {
            if shouldUseLogger != newValue {
                UserDefaults.standard.set(newValue, forKey: shouldUseLoggerDefaultsKey)
            }
        }
    }
}

extension Logger: TextOutputStream {
    
    public func write(_ string: String) {
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        let message: String
        if string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            message = string
        } else {
            message = "[\(Date()) " + "\(appName ?? "")] " + string
        }
        
        #if DEBUG
        print(message, terminator: "")
        #endif
        
        guard let path = path, shouldUseLogger else {
            return
        }
        
        if let handle = try? FileHandle(forWritingTo: path) {
            if shouldClean(at: path.path) {
                handle.truncateFile(atOffset: 0)
            }
            handle.seekToEndOfFile()
            handle.write(message.data(using: .utf8)!)
            handle.closeFile()
        } else {
            if shouldClean(at: path.path) {
                try? "".write(to: path, atomically: false, encoding: .utf8)
            }
            try? message.data(using: .utf8)?.write(to: path)
        }
    }
}

extension Logger: Logging {
    
    private static var shared = Logger()
    
    public static func log(_ value: Any...) {
        value.forEach { print($0, to:&shared) }
    }
    
    public static func makeLogging(active isActive: Bool) {
        shared.shouldUseLogger = isActive
    }
}

//Convenience
public protocol Loggable: AnyObject {
    
    func log(_ value: Any)
    static func log(_ value: Any)
}

public extension Loggable {
    
    func log(_ value: Any) {
        Logger.log("[\(Self.self)]: \(value)")
    }
    
    static func log(_ value: Any) {
        Logger.log("[\(Self.self)]: \(value)")
    }
}
