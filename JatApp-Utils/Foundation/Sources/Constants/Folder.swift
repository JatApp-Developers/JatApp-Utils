//
//  Folder.swift
//  JatApp-Foundation
//
//  Created by Developer on 4/15/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

public struct Folder {
    
    public static var applicationDataDirectory: URL? {
        let fileManager = FileManager.default
        if let applicationSupport = try? fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true),
            let bundleID = Bundle.main.bundleIdentifier {
            let applicationDataFolder = applicationSupport.appendingPathComponent(bundleID)
            do {
                try fileManager.createDirectory(at: applicationDataFolder, withIntermediateDirectories: true, attributes: nil)
                Logger.log("[Folder] Successfully create directory at path: \(applicationDataFolder)")
            } catch {
                Logger.log("[Folder] Cannot create directory at path: \(applicationDataFolder)")
            }
            return applicationDataFolder
        }
        return nil
    }
    
    public static var documentsDirectory: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}
