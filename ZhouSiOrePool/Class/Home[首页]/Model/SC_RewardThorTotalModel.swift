//
//  SC_RewardThorTotalModel.swift
//  ZhouSiOrePool
//
//  Created by 郭健 on 2020/11/19.
//  Copyright © 2020 odin. All rights reserved.
//

class SC_RewardThorTotalModel : NSObject {
    
    //thor奖励记录
    var createTime : String?
    var userId : NSNumber?
    var num : Double?
    var fromAddress : String?
    var toAddress : String?
    var operateType : String?
    var type : String?
    var status : String?
    var symbol : String?
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        createTime = dictionary["createTime"] as? String
        userId = dictionary["userId"] as? NSNumber
        num = dictionary["num"] as? Double
        fromAddress = dictionary["fromAddress"] as? String
        toAddress = dictionary["toAddress"] as? String
        operateType = dictionary["operateType"] as? String
        type = dictionary["type"] as? String
        status = dictionary["status"] as? String
        symbol = dictionary["symbol"] as? String
    }
}
