//
//  Global.swift
//  PMS
//
//  Created by 永芯 on 2019/7/9.
//  Copyright © 2019 huasen. All rights reserved.
//

import UIKit

// MARK: - 布局

let kScreenBounds = UIScreen.main.bounds
//屏高
let kScreenHeight = kScreenBounds.height
//屏宽
let kScreenWidth = kScreenBounds.width
//屏幕大小
let kScreenSize = kScreenBounds.size

let ScreenScale = (kScreenWidth/375.0)

//状态栏默认高度
let kStatusBarHeight:CGFloat = (IsFullScreen ? 45.0 : 20.0)
//导航栏默认高度
let kNavBarHeight:CGFloat = 44.0
//Tabbar默认高度
let kTabBarHeight:CGFloat = (IsFullScreen ? 83.0 : 49.0)

let kLiuHaiH :CGFloat = (IsFullScreen ? 37.0 : 20.0)
let iskLiuHaiH :CGFloat = (IsFullScreen ? 17 : 0.0)
let keyWindow = UIApplication.shared.keyWindow
//var keyWindow : UIWindow? {
//    if #available(iOS 13.0, *) {
//        return UIApplication.shared.windows.first
//    }
//    return UIApplication.shared.keyWindow
//}

//iPhonex以上判断
//let IS_IPhoneX_All = (kScreenHeight == 812 || kScreenHeight == 896)




public let Toast:((String) -> Void) = {(toastStr:String)->Void in
    if nil == keyWindow{
        
    }else{
//        MBProgressHUD.showText(toastStr)
//       keyWindow!.makeToast(toastStr, duration: 1, position: CSToastPositionCenter)
    }
    
}

/// 国际化
public func Localized(_ string:String) -> String {
    return NSLocalizedString(string, comment: "")
}


var IsFullScreen: Bool {
    if #available(iOS 11, *) {
//        guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
        guard let w = UIApplication.shared.windows.first else {
            return false
        }
        if w.safeAreaInsets.left > 0.0 || w.safeAreaInsets.bottom > 0.0 {
            return true
        }
    }
    return false
}

 // MARK: - 查找顶层控制器、
 // 获取顶层控制器 根据window
func getTopVC() -> (UIViewController?) {
    var window = UIApplication.shared.keyWindow
    // UIWindow.Level window三种等级 normal，alert，statusBar,normal才是真正要用到的
    if window?.windowLevel != UIWindow.Level.normal{
        let windows = UIApplication.shared.windows
        for  windowTemp in windows{
            if windowTemp.windowLevel == UIWindow.Level.normal{
                window = windowTemp
                break
            }
        }
    }
    let vc = window?.rootViewController
    return getTopVC(withCurrentVC: vc)
 }

  ///根据控制器获取 顶层控制器
func getTopVC(withCurrentVC VC :UIViewController?) -> UIViewController? {
    if VC == nil {
        print("🌶： 找不到顶层控制器")
        return nil
    }
    if let presentVC = VC?.presentedViewController {
        //modal出来的 控制器
        return getTopVC(withCurrentVC: presentVC)
    }else if let tabVC = VC as? UITabBarController {
        if let selectVC = tabVC.selectedViewController {
          return getTopVC(withCurrentVC: selectVC)
        }
        return nil
    } else if let naiVC = VC as? UINavigationController {
        return getTopVC(withCurrentVC:naiVC.visibleViewController)
    } else {
        // 返回顶控制器
        return VC
    }
}

public func DebugLog<T>(_ object: T?, filename: String = #file, line: Int = #line, funcname: String = #function) {
    #if DEBUG
        guard let object = object else { return }
        print("***** \(Date()) \(filename.components(separatedBy: "/").last ?? "") (line: \(line)) :: \(funcname) :\n \(object)")
    #endif
}


var IsSh: Bool = true


