//
//  UserManager.swift
//  Wenyishou
//
//  Created by 永芯 on 2020/5/14.
//  Copyright © 2020 永芯. All rights reserved.
//

import UIKit

var KUserID: String! {
    if let uid = UserDefaults.standard.string(forKey: "uidKey") {
        return uid
    }
    return ""
}
var KUserName: String! {
    if let uid = UserDefaults.standard.string(forKey: UserNameKey) {
        return uid
    }
    return ""
}

var KSignKey: String! {
    if let signKey = UserDefaults.standard.string(forKey: "SignKey") {
        return signKey
    }
    return ""
}


let RealNameStateKey = "RealNameStateKey"
let UserInfoCompleteKey = "UserInfoCompleteKey"
let UserNameKey = "UserNameKey"

class UserManager: NSObject {
    /// 存储用户信息
    static func saveUserInfo(model: UserModel) {
        // 归档之后才能保存（模型要encode） 完成！
        let data = NSKeyedArchiver.archivedData(withRootObject: model)
        UserDefaults.standard.set(data, forKey: "userModelKey")
        let id = String(model.userId)
        UserDefaults.standard.set(id, forKey: "uidKey")
       
    }
    /// 获取用户信息
    static func getUserModel() -> UserModel?{
        if let userModelData = UserDefaults.standard.data(forKey: "userModelKey"), let mdoel = NSKeyedUnarchiver.unarchiveObject(with: userModelData) as? UserModel {
            return mdoel
        }
        
        return nil
    }
    
    static func pushLogin() -> Bool{
        if self.getUserModel() == nil {
            let vc = SC_BaseNavigationController.init(rootViewController: SC_LoginViewController.init())
            keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
            return true
        }
        return false
    }
    
   
    
    static func updateUserInfo(_ block: @escaping (UserModel) -> Void) {
//        NetworkManager<UserModel>().requestModel(API.getUserInfo, completion: { (response) in
//            if let userModel = response?.data {
//                UserManager.saveUserInfo(model: userModel)
//                block(userModel)
//            }
//        }) { (error) in
//            if let msg = error.message {
//                MBProgressHUD.showText(msg)
//            }
//        }
        
    }
    

    /// 修改用户信息 只传修改的参数
    static func update(_ nickname:String = "", nickPic:String = "", completion: @escaping () -> Void) {
        var para : [String:String]?
        
        if nickname.isEmpty {
            para = ["nickPic":nickPic]
        } else if nickPic.isEmpty {
            para = ["nickname":nickname]
        } else {
            return
        }
        
//        NetworkManager<BaseModel>().requestModel(API.userUpdate(para: para!), completion: { (response) in
//            completion()
//        }) { (error) in
//            if let msg = error.message {
//                MBProgressHUD.showText(msg)
//            }
//        }
    }
 
    /// 检查账户信息是否完善
//    static func checkUserInfoComplete(vc : BaseViewController) {
//        NetworkManager<AccountModel>().requestModel(API.selLoginUserAccountExist, completion: { (response) in
//            if let model = response?.data {
//                if model.isBankCard && model.isAliPay && !(model.tel ?? "").isEmpty && model.payPassword?.length == 6 {
//                    UserDefaults.standard.set(true, forKey: UserInfoCompleteKey)
////                    let exvc = ExchangeTabbarVC.init()
////                    vc.navigationController?.pushViewController(exvc, animated: true)
//                } else {
//                    UserDefaults.standard.set(false, forKey: UserInfoCompleteKey)
//                    MBProgressHUD.showText("请完善账户信息")
////                    let setVc = SettingVC.init()
////                    vc.navigationController?.pushViewController(setVc, animated: true)
//                }
//            }
//        }) { (error) in
//            if let msg = error.message {
//                MBProgressHUD.showText(msg)
//            }
//        }
//    }
    
    static func showLogin(vc:UIViewController?) {
        DispatchQueue.main.async {
//            let loginvc = LoginVC.init()
//            let navVC = BaseNavigationController.init(rootViewController: loginvc)
//            navVC.modalPresentationStyle = .overFullScreen
//            if let _ = vc {
//                vc!.present(navVC, animated: true, completion: nil)
//            } else {
//                let curVC = getTopVC()
//                curVC?.present(navVC, animated: true, completion: nil)
//            }
        }
    }
    
    /// 退出登录
    static func loginOut() {

//        NetworkManager<BaseModel>().requestModel(API.userLogOut, completion: { (_) in
            self.deleteDefaults()
//        }) { (error) in
//            if let msg = error.message {
//                MBProgressHUD.showText(msg)
//            }
//        }
    }
    
    static func deleteDefaults() {
        UserDefaults.standard.removeObject(forKey: "userModelKey")
        UserDefaults.standard.removeObject(forKey: "uidKey")
        UserDefaults.standard.removeObject(forKey: "Access-Token")

        //删除所有
        //获取应用域的所有字符串
//        if let appDomain = Bundle.main.bundleIdentifier {
//            UserDefaults.standard.removePersistentDomain(forName: appDomain)
//        }

        
        let myAppdelegate = UIApplication.shared.delegate as! AppDelegate
        myAppdelegate.setFirstTabbar()

    }
    
    /// 注销账号
//    static func deleteAccount() {
//        NetworkManager<BaseModel>().requestModel(API.userLogOff, completion: { (_) in
//            self.loginOut()
//        }) { (error) in
//            if let msg = error.message {
//                MBProgressHUD.showText(msg)
//            }
//        }
//    }
}
