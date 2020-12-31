//
//  ColorTool.swift
//  XHYKProduct
//
//  Created by luyongpeng on 2020/7/24.
//  Copyright © 2020 Swift. All rights reserved.
//

import UIKit


//导航栏高
let NaviBar_Height:CGFloat = (IsFullScreen ? 88.0 : 64.0)

//安全区高

let SafeArea_BottomHeight:CGFloat = (IsFullScreen ? 34.0 : 0.0)

//主题色
public let themeBackgroundColor = UIColor.init(0x2496A6)

// MARK: - 颜色
//导航栏颜色 0x2A1B69
public let tabbarBackgroundColor = UIColor.init(0xFFFFFF)

/// 页面背景 灰色
public let vcBackLightGrayColor = UIColor.init(0xF1F1F1)

/// cell背景颜色 浅蓝
public let vcBackDeepBlueColor = UIColor.init(0x253147 )

public let vcBackGreyColor = UIColor.init(0xF4F4F4)

public let lineViewColor = UIColor.init(0xB3BCFF)

public let baseNoTextColor = UIColor.init(0x999999)

public let baseTabTextColor = UIColor.init(0x2495A5)

public let chartFillColor = UIColor.init(0xD7F2F6)

public let yelloRedwColor = UIColor.init(0xEA6206)

public let  vcBoxBlack = UIColor.init(white: 0x000000, alpha: 0.4)


public let  textFPlaceholderLabelTextColor  = UIColor.init(white: 0x000000, alpha: 0.4)


/// 默认字体颜色
public let defaultTextColor = UIColor.init(0x253147)
/// 黄色字体颜色
public let baseYellowTextColor = UIColor.init(0xFEAA0A)

public let blackColor1 = UIColor.init(0x121212)


public let blackColor2 = UIColor.init(0x333333)



class ColorTool: NSObject {

    static func navTintColor(_ navigationController:UINavigationController, _ color: UIColor) {
            let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: color]
        navigationController.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : Any]
            
        }
    

    
}
