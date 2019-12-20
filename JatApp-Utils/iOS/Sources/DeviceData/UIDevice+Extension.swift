//
//  UIDevice+Extension.swift
//  JatApp-Utils-iOS
//
//  Created by Developer on 2/15/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import UIKit.UIDevice

public enum DeviceFamily: CaseIterable {
    case iPhone4
    case iPhone5
    case iPhone6
    case iPhone6Plus
    case iPhoneX
    case iPhoneXSMax
    
    var devices: [DeviceType] {
        switch self {
        case .iPhone4:
            return [.iPhone4s, .iPhone4]
        case .iPhone5:
            return [.iPhoneSE, .iPhone5s, .iPhone5, .iPhone5c, .iPodTouch5, .iPodTouch6]
        case .iPhone6:
            return [.iPhone8, .iPhone7, .iPhone6s, .iPhone6]
        case .iPhone6Plus:
            return [.iPhone8Plus, .iPhone7Plus, .iPhone6sPlus, .iPhone6Plus]
        case .iPhoneX:
            return [.iPhoneX, .iPhoneXS, .iPhone11, .iPhone11Pro]
        case .iPhoneXSMax:
            return [.iPhoneXSMax, .iPhoneXR, .iPhone11ProMax]
        }
    }
    
    var virtualSize: CGSize {
        switch self {
        case .iPhone4:
            return .init(width: 320, height: 480)
        case .iPhone5:
            return .init(width: 320, height: 568)
        case .iPhone6:
            return .init(width: 375, height: 667)
        case .iPhone6Plus:
            return .init(width: 414, height: 736)
        case .iPhoneX:
            return .init(width: 375, height: 812)
        case .iPhoneXSMax:
            return .init(width: 414, height: 896)
        }
    }
    
    init?(screenSize: CGSize) {
        if let type = DeviceFamily.allCases.first(where: {$0.virtualSize == screenSize}) {
            self = type
        } else {
            return nil
        }
    }
}

public enum DeviceType: String, CaseIterable {
    case iPodTouch5 = "iPod Touch 5"
    case iPodTouch6 = "iPod Touch 6"
    case iPhone4 = "iPhone 4"
    case iPhone4s = "iPhone 4s"
    case iPhone5 = "iPhone 5"
    case iPhone5c = "iPhone 5c"
    case iPhone5s = "iPhone 5s"
    case iPhone6 = "iPhone 6"
    case iPhone6Plus = "iPhone 6 Plus"
    case iPhone6s = "iPhone 6s"
    case iPhone6sPlus = "iPhone 6s Plus"
    case iPhone7 = "iPhone 7"
    case iPhone7Plus = "iPhone 7 Plus"
    case iPhoneSE = "iPhone SE"
    case iPhone8 = "iPhone 8"
    case iPhone8Plus = "iPhone 8 Plus"
    case iPhoneX = "iPhone X"
    case iPhoneXS = "iPhone XS"
    case iPhoneXSMax = "iPhone XS Max"
    case iPhoneXR = "iPhone XR"
    case iPhone11 = "iPhone 11"
    case iPhone11Pro = "iPhone 11 Pro"
    case iPhone11ProMax = "iPhone 11 Pro Max"
    case iPad2 = "iPad 2"
    case iPad3 = "iPad 3"
    case iPad4 = "iPad 4"
    case iPadAir = "iPad Air"
    case iPadAir2 = "iPad Air 2"
    case iPadAir3 = "iPad Air 3"
    case iPad5 = "iPad 5"
    case iPad6 = "iPad 6"
    case iPadMini = "iPad Mini"
    case iPadMini2 = "iPad Mini 2"
    case iPadMini3 = "iPad Mini 3"
    case iPadMini4 = "iPad Mini 4"
    case iPadMini5 = "iPad Mini 5"
    case iPadPro9_7 = "iPad Pro (9.7-inch)"
    case iPadPro12_9 = "iPad Pro (12.9-inch)"
    case iPadPro12_9SecondGeneration = "iPad Pro (12.9-inch) (2nd generation)"
    case iPadPro10_5 = "iPad Pro (10.5-inch)"
    case iPadPro11 = "iPad Pro (11-inch)"
    case iPadPro12_9ThirdGeneration = "iPad Pro (12.9-inch) (3rd generation)"
    case iPad10_2SeventhGeneration = "iPad 10.2 Inch 7th Generation"
    case appleTV = "Apple TV"
    case appleTV4K = "Apple TV 4K"
    case homePod = "HomePod"
    
    case unknown
    
    public var family: DeviceFamily? {
        for family in DeviceFamily.allCases where family.devices.contains(self) {
            return family
        }
        return nil
    }
}

public extension UIDevice {
    
    static var currentDeviceType: DeviceType {
        let device: DeviceType?
        
        if let typeByName = DeviceType(rawValue: modelName) {
            device = typeByName
        } else if let typeByScreenSize = DeviceFamily(screenSize: UIScreen.main.bounds.size)?.devices.first {
            device = typeByScreenSize
        } else {
            device = nil
        }
        return device ?? .unknown
    }
}

public extension UIDevice {
    
    static let identifier: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }()
        
    static let modelName: String = {
        
        let identifier = UIDevice.identifier
        
        func mapToDevice(identifier: String) -> String {
            #if os(iOS)
            switch identifier {
            /// iPod
            case "iPod1,1":                                  return "iPod Touch 1"
            case "iPod2,1":                                  return "iPod Touch 2"
            case "iPod3,1":                                  return "iPod Touch 3"
            case "iPod4,1":                                  return "iPod Touch 4"
            case "iPod5,1":                                  return "iPod Touch 5"
            case "iPod7,1":                                  return "iPod Touch 6"
            case "iPod9,1":                                  return "iPod Touch 7"
                
            /// iPhone
            case "iPhone1,1":                                return "iPhone"
            case "iPhone1,2":                                return "iPhone 3G"
            case "iPhone2,1":                                return "iPhone 3GS"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":      return "iPhone 4"
            case "iPhone4,1":                                return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                   return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                   return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                   return "iPhone 5s"
            case "iPhone7,2":                                return "iPhone 6"
            case "iPhone7,1":                                return "iPhone 6 Plus"
            case "iPhone8,1":                                return "iPhone 6s"
            case "iPhone8,2":                                return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                   return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                   return "iPhone 7 Plus"
            case "iPhone8,4":                                return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                 return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                 return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                 return "iPhone X"
            case "iPhone11,8":                               return "iPhone XR"
            case "iPhone11,2":                               return "iPhone XS"
            case "iPhone11,6":                               return "iPhone XS Max"
            case "iPhone11,4":                               return "iPhone XS Max China"
            case "iPhone12,1":                               return "iPhone 11"
            case "iPhone12,3":                               return "iPhone 11 Pro"
            case "iPhone12,5":                               return "iPhone 11 Pro Max"
                
            /// iPad
            case "iPad1,1":                                  return "iPad"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":            return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":            return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":            return "iPad Air"
            case "iPad5,3", "iPad5,4":                       return "iPad Air 2"
            case "iPad11,3", "iPad11,4":                     return "iPad Air 3"
            case "iPad6,11", "iPad6,12":                     return "iPad 5"
            case "iPad7,5", "iPad7,6":                       return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7":            return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":            return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":            return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                       return "iPad Mini 4"
            case "iPad11,1", "iPad11,2":                     return "iPad Mini 5"
            case "iPad6,3", "iPad6,4":                       return "iPad Pro 9.7 Inch"
            case "iPad6,7", "iPad6,8":                       return "iPad Pro 12.9 Inch"
            case "iPad7,1", "iPad7,2":                       return "iPad Pro 12.9 Inch 2. Generation"
            case "iPad7,3", "iPad7,4":                       return "iPad Pro 10.5 Inch"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return "iPad Pro 11 Inch"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return "iPad Pro 12.9 Inch 3. Generation"
            case "iPad7,11", "iPad7,12":                     return "iPad 10.2 Inch 7th Generation"
                
            /// Apple TV
            case "AppleTV2,1":                               return "Apple TV 2nd Generation"
            case "AppleTV3,1", "AppleTV3,2":                 return "Apple TV 3rd Generation"
            case "AppleTV5,3":                               return "Apple TV"
            case "AppleTV6,2":                               return "Apple TV 4K"
                
            /// HomePod
            case "AudioAccessory1,1":                        return "HomePod"
            case "AudioAccessory1,2":                        return "HomePod 2nd model"
                
            /// AirPods
            case "AirPods1,1":                               return "AirPods 1st Generation"
            case "AirPods2,1":                               return "AirPods 2nd Generation"
                
            /// Simulator
            case "i386", "x86_64":                           return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                         return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3":                               return "Apple TV 4"
            case "AppleTV6,2":                               return "Apple TV 4K"
            case "i386", "x86_64":                           return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default:                                         return identifier
            }
            #elseif os(watchOS)
            switch identifier {
            case "Watch1,1":                                 return "Apple Watch Series 0 38mm"
            case "Watch1,2":                                 return "Apple Watch Series 0 42mm"
            case "Watch2,6":                                 return "Apple Watch Series 1 38mm"
            case "Watch2,7":                                 return "Apple Watch Series 1 42mm"
            case "Watch2,3":                                 return "Apple Watch Series 2 38mm"
            case "Watch2,4":                                 return "Apple Watch Series 2 42mm"
            case "Watch3,1", "Watch3,3":                     return "Apple Watch Series 3 38mm"
            case "Watch3,2", "Watch3,4":                     return "Apple Watch Series 3 42mm"
            case "Watch4,1", "Watch4,3":                     return "Apple Watch Series 4 40mm"
            case "Watch4,2", "Watch4,4":                     return "Apple Watch Series 4 44mm"
            case "Watch5,1", "Watch5,3":                     return "Apple Watch Series 5 40mm"
            case "Watch5,2", "Watch5,4":                     return "Apple Watch Series 5 44mm"
            case "i386", "x86_64":                           return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "watchOS"))"
            default:                                         return identifier
            }
            #endif
        }
        return mapToDevice(identifier: identifier)
    }()
}
