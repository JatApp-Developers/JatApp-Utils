//
//  DesktopModel.swift
//  JatApp-Utils-macOS
//
//  Created by Developer on 2/15/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

#if os(macOS)
public class DesktopModel {
    
    static let identifier: String = {
        var size = 0
        sysctlbyname("hw.model", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: size)
        sysctlbyname("hw.model", &machine, &size, nil, 0)
        return String(cString: machine)
    }()
    
    static let modelName: String = {
        let identifier = DesktopModel.identifier
        
        func mapToDevice(identifier: String) -> String {
            switch identifier {
            /// MacBook
            case "MacBookMacBook10,1": return "MacBook Retina, 12-inch, 2017"
            case "MacBook9,1": return "MacBook Retina, 12-inch, Early 2016"
            case "MacBook8,1": return "MacBook Retina, 12-inch, Early 2015"
            case "MacBook7,1": return "MacBook 13-inch, Mid 2010"
            case "MacBook6,1": return "MacBook 13-inch, Late 2009"
            case "MacBook5,2": return "MacBook 13-inch, Mid 2009"
                
            /// MacBookAir
            case "MacBookAir8,1": return "MacBookAir Retina, 13-inch, 2018"
            case "MacBookAir8,2": return "MacBookAir Retina, 13-inch, Mid 2019"
            case "MacBookAir7,2": return "MacBookAir 13-inch, 2017; 13-inch, Early 2015"
            case "MacBookAir7,1": return "MacBookAir 11-inch, Early 2015"
            case "MacBookAir6,2": return "MacBookAir 13-inch, Early 2014; 13-inch, Mid 2013"
            case "MacBookAir6,1": return "MacBookAir 11-inch, Early 2014; 11-inch, Mid 2013"
            case "MacBookAir5,1": return "MacBookAir 11-inch, Mid 2012"
            case "MacBookAir5,2": return "MacBookAir 13-inch, Mid 2012"
            case "MacBookAir4,1": return "MacBookAir 11-inch, Mid 2011"
            case "MacBookAir4,2": return "MacBookAir 13-inch, Mid 2011"
            case "MacBookAir3,1": return "MacBookAir 11-inch, Late 2010"
            case "MacBookAir3,2": return "MacBookAir 13-inch, Late 2010"
            case "MacBookAir2,1": return "MacBookAir Mid 2009"
                
            /// MacBook Pro
            case "MacBookPro15,4": return "MacBook Pro 13-inch, Mid 2019, Two Thunderbolt 3 Ports"
            case "MacBookPro15,3": return "MacBook Pro 15-inch, Mid 2019"
            case "MacBookPro15,1": return "MacBook Pro 15-inch, 2018"
            case "MacBookPro15,2": return "MacBook Pro 13-inch, 2018, Four Thunderbolt 3 ports"
            case "MacBookPro14,3": return "MacBook Pro 15-inch, 2017"
            case "MacBookPro14,2": return "MacBook Pro 13-inch, 2017, Four Thunderbolt 3 ports"
            case "MacBookPro14,1": return "MacBook Pro 13-inch, 2017, Two Thunderbolt 3 ports"
            case "MacBookPro13,3": return "MacBook Pro 15-inch, 2016"
            case "MacBookPro13,2": return "MacBook Pro 13-inch, 2016, Four Thunderbolt 3 ports"
            case "MacBookPro13,1": return "MacBook Pro 13-inch, 2016, Two Thunderbolt 3 ports"
            case "MacBookPro11,4": return "MacBook Pro Retina, 15-inch, Mid 2015"
            case "MacBookPro11,5": return "MacBook Pro Retina, 15-inch, Mid 2015"
            case "MacBookPro12,1": return "MacBook Pro Retina, 13-inch, Early 2015"
            case "MacBookPro11,2": return "MacBook Pro Retina, 15-inch, Mid 2014; Late 2013"
            case "MacBookPro11,3": return "MacBook Pro Retina, 15-inch, Mid 2014; Late 2013"
            case "MacBookPro11,1": return "MacBook Pro Retina, 13-inch, Mid 2014; Late 2013"
            case "MacBookPro10,1": return "MacBook Pro Retina, 15-inch, Early 2013; Mid 2012"
            case "MacBookPro10,2": return "MacBook Pro Retina, 13-inch, Early 2013; Late 2012"
            case "MacBookPro9,1": return "MacBook Pro 15-inch, Mid 2012"
            case "MacBookPro9,2": return "MacBook Pro 13-inch, Mid 2012"
            case "MacBookPro8,3": return "MacBook Pro 17-inch, 2011"
            case "MacBookPro8,2": return "MacBook Pro 15-inch, 2011"
            case "MacBookPro8,1": return "MacBook Pro 13-inch, Late 2011"
            case "MacBookPro6,1": return "MacBook Pro 17-inch, Mid 2010"
            case "MacBookPro6,2": return "MacBook Pro 15-inch, Mid 2010"
            case "MacBookPro7,1": return "MacBook Pro 13-inch, Mid 2010"
            case "MacBookPro5,2": return "MacBook Pro 17-inch, Mid 2009; Early 2009"
            case "MacBookPro5,3": return "MacBook Pro 15-inch, Mid 2009; 2.53GHz, Mid 2009"
            case "MacBookPro5,5": return "MacBook Pro 13-inch, Mid 2009"
            case "MacBookPro5,1": return "MacBook Pro 15-inch, Late 2008"
            case "MacBookPro4,1": return "MacBook Pro Early 2008"
            case "MacBookPro16,1": return "MacBook Pro 16-inch"
                
            /// iMac
            case "iMac18,1": return "iMac 21.5-inch, 2017"
            case "iMac18,2": return "iMac Retina 4K, 21.5-inch, 2017"
            case "iMac18,3": return "iMac Retina 5K, 27-inch, 2017"
            case "iMac16,1": return "iMac 21.5-inch, Late 2015"
            case "iMac16,2": return "iMac Retina 4K, 21.5-inch, Late 2015"
            case "iMac15,1": return "iMac Retina 5K, 27-inch, Mid 2015; Late 2014"
            case "iMac17,1": return "iMac Retina 5K, 27-inch, Late 2015"
            case "iMac14,4": return "iMac 21.5-inch, Mid 2014"
            case "iMac14,1": return "iMac 21.5-inch, Late 2013"
            case "iMac14,2": return "iMac 27-inch, Late 2013"
            case "iMac13,1": return "iMac 21.5-inch, Late 2012"
            case "iMac13,2": return "iMac 27-inch, Late 2012"
            case "iMac12,1": return "iMac 21.5-inch, Mid 2011"
            case "iMac12,2": return "iMac 27-inch, Mid 2011"
            case "iMac11,2": return "iMac 21.5-inch, Mid 2010"
            case "iMac11,3": return "iMac 27-inch, Mid 2010"
            case "iMac9,1": return "iMac Early 2009"
            case "iMac10,1": return "iMac Late 2009"
            case "iMac19,1": return "iMac Retina 5K 27-inch, 2019"
            case "iMac19,2": return "iMac Retina 4K 21.5-inch, 2019"
                
            /// Mac mini
            case "Macmini8,1": return "Mac mini 2018"
            case "Macmini7,1": return "Mac mini Late 2014"
            case "Macmini6,1", "Macmini6,2": return "Mac mini Late 2012"
            case "Macmini5,1", "Macmini5,2": return "Mac mini Mid 2011"
            case "Macmini4,1": return "Mac mini Mid 2010"
            case "Macmini3,1": return "Mac mini 2009"
                
            /// Mac Pro
            case "MacPro7,1": return "Mac Pro Late 2019"
            case "MacPro6,1": return "Mac Pro Late 2013"
            case "MacPro5,1": return "Mac Pro Mid 2012; Mid 2010"
            case "MacPro4,1": return "Mac Pro Early 2009"
                
            /// iMacPro
            case "iMacPro1,1": return "iMacPro 2017"
                
            default: return identifier
            }
        }
        return mapToDevice(identifier: identifier)
    }()
}
#endif
