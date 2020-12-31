//
//  Bundle+HSExtension.swift
//  GMG
//
//  Created by 永芯 on 2020/1/8.
//  Copyright © 2020 永芯. All rights reserved.
//

import Foundation
import UIKit

public extension Bundle {
    /// The app's name
    static var hs_appName: String? {
        guard let name =  Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String else {
            return nil
        }
        return name
    }
    
    /// The app's version
    static var hs_appVersion: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    /// The app's build number
    static var hs_appBuild: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
    
    /// The app's bundle identifier
    static var hs_bundleIdentifier: String {
        return Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    }

    /// The app's bundle name
    static var hs_bundleName: String {
        return Bundle.main.infoDictionary!["CFBundleName"] as! String
    }
    
    /// The app's version and build number
    static var hs_appVersionAndBuild: String {
        let version = hs_appVersion, build = hs_appBuild
        return version == build ? "v\(version)" : "v\(version)(\(build))"
    }
    
    /// App's icon file path
    class var hs_iconFilePath: String {
        let iconFilename = Bundle.main.object(forInfoDictionaryKey: "CFBundleIconFile")
        let iconBasename = (iconFilename as! NSString).deletingPathExtension
        let iconExtension = (iconFilename as! NSString).pathExtension
        return Bundle.main.path(forResource: iconBasename, ofType: iconExtension)!
    }
    
    /// App's icon image
    class func hs_iconImage() -> UIImage? {
        guard let image = UIImage(contentsOfFile:self.hs_iconFilePath) else {
            return nil
        }
        return image
    }
}
