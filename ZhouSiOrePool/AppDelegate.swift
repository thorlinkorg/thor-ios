//
//  AppDelegate.swift
//  ZhouSiOrePool
//
//  Created by odin on 2020/9/24.
//  Copyright © 2020 odin. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var tabbarController :SC_BaseTabBarController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().tintColor = .white
        configUmentAnalyse()
        
        let keyboard = IQKeyboardManager.shared
        keyboard.enable = true
        keyboard.shouldResignOnTouchOutside = true
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        
        setFirstTabbar()
        
        return true
    }

    
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        Unitilty.AboutIsMaxVersion()
    }

    
    func setFirstTabbar()  {
        if UserManager.getUserModel() != nil{
           self.tabbarController = SC_BaseTabBarController.init()
            self.window?.rootViewController = self.tabbarController
       }else{
            let nav = SC_BaseNavigationController.init(rootViewController: SC_NewLoginViewController.init())
            self.window?.rootViewController = nav
       }
        self.window?.makeKeyAndVisible()
    }


}

extension AppDelegate{
    func configUmentAnalyse(){
        let config = UMAnalyticsConfig.sharedInstance()
        config?.appKey = "5fa9029845b2b751a9274c72"
        MobClick.start(withConfigure: config)

        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        MobClick.setAppVersion(version)
        
        MobClick.setLogEnabled(true)
    }
}
