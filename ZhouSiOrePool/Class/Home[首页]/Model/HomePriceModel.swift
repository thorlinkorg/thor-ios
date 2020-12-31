//
//  HomePriceModel.swift
//  ZhouSiOrePool
//
//  Created by odin on 2020/10/10.
//  Copyright © 2020 odin. All rights reserved.
//

import Foundation


class HomePriceModel : NSObject, Codable{


    var name : String!
    var price : String!
    var rose : String!
    var type : Int!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){

        name = dictionary["name"] as? String
        price = dictionary["price"] as? String
//        rose = dictionary["rose"] as? String
        type = dictionary["type"] as? Int
        
        if var gainStr = dictionary["rose"] as? String{
            if gainStr.hasPrefix("-"){
                let index = gainStr.firstIndex(of: "-")!
                gainStr.remove(at: index)
                if gainStr.hasPrefix("."){
                    gainStr = "-0" + gainStr
                } else {
                    gainStr = "-" + gainStr
                }
            } else if gainStr.hasPrefix("."){
                gainStr = "0" + gainStr
            }
            rose = gainStr
        } else {
            rose = (dictionary["rose"] as? String)
        }
    }


}
