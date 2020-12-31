//
//  UIStoryboard+extension.swift
//  DiceCircle
//
//  Created by tianqi on 2017/7/22.
//  Copyright © 2017年 com.david. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    /// Usage: let storyboard = UIStoryboard.mainStoryboard
    public static var mainStoryboard: UIStoryboard? {
        let bundle = Bundle.main
        guard let name = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else {
            return nil
        }
        return UIStoryboard(name: name, bundle: bundle)
    }


    /// Usage: let profileVC = storyboard!.instantiateVC(ProfileViewController) /* profileVC is of type ProfileViewController */
    public func instantiateVC<T>(_ identifier: T.Type) -> T? {
        let storyboardID = String(describing: identifier)
        if let vc = instantiateViewController(withIdentifier: storyboardID) as? T {
            return vc
        } else {
            return nil
        }
        
    }
}
