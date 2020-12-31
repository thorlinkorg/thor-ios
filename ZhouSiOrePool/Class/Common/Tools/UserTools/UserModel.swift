//
//  UserModel.swift
//  Wenyishou
//
//  Created by 永芯 on 2020/5/14.
//  Copyright © 2020 永芯. All rights reserved.
//

import UIKit

class UserModel: NSObject, Codable, NSCoding {
        
    var createTime: String?
    
    //头像
    var avatar : String!
    //邀请码
    var inviteCode : String!
    //登录账号
    var loginName : String!
    //电话
    var phone : String!
    //个性签名
    var remake : String!
    //性别 0男 1女 2未知
    var sex : String!
    //用户登录存放的token信息
    var token : String!
    //用户ID
    var userId : Int!
    //用户名
    var userName : String!

    //email
    var email : String!
    
    


    
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(userId, forKey: "userId")

        if avatar != nil{
            aCoder.encode(avatar, forKey: "avatar")
        }
        
        if inviteCode != nil{
            aCoder.encode(inviteCode, forKey: "inviteCode")
        }
        
        if loginName != nil{
            aCoder.encode(loginName, forKey: "loginName")
        }
        
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }
      
        if remake != nil{
            aCoder.encode(remake, forKey: "remake")
        }
        
        if sex != nil{
            aCoder.encode(sex, forKey: "sex")
        }
       
        if token != nil{
            aCoder.encode(token, forKey: "token")
        }
        
        if userName != nil{
            aCoder.encode(userName, forKey: "userName")
        }
        
        if createTime != nil{
            aCoder.encode(userName, forKey: "createTime")
        }
        
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
    }

    required init?(coder: NSCoder) {
    
        avatar = coder.decodeObject(forKey: "avatar") as? String
        inviteCode = coder.decodeObject(forKey: "inviteCode") as? String
        loginName = coder.decodeObject(forKey: "loginName") as? String
        phone = coder.decodeObject(forKey: "phone") as? String
        remake = coder.decodeObject(forKey: "remake") as? String
        sex = coder.decodeObject(forKey: "sex") as? String
        token  = coder.decodeObject(forKey: "token") as? String
        userName = coder.decodeObject(forKey: "userName") as? String
        createTime = coder.decodeObject(forKey: "createTime") as? String
        userId = coder.decodeObject(forKey: "userId") as? Int
        
        email = coder.decodeObject(forKey: "email") as? String
    }
    
}
