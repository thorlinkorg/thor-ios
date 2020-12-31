//
//	SpecListModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class SpecListModel : NSObject,Codable, NSCoding{

	var cost : Float!
	var createBy : String!
	var createTime : String!
	var givePower : Int!
	var goodsId : Int!
	var image : String!
	var odinPrice : Double!
	
	var price : Int!
	var remark : String!
	var sales : Int!
	var searchValue : String!
	var shopPrice : Double!
	var specId : Int!
	var specName : String!
	var stock : Int!
	var storeId : Int!
	var updateBy : String!
	var updateTime : String!
    
//    购买数量自己添加
    var payNum : Int!
    
    var payRemark : String!

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		cost = dictionary["cost"] as? Float
		createBy = dictionary["createBy"] as? String
		createTime = dictionary["createTime"] as? String
		givePower = dictionary["givePower"] as? Int
		goodsId = dictionary["goodsId"] as? Int
		image = dictionary["image"] as? String
        odinPrice = dictionary["odinPrice"] as? Double
	
		price = dictionary["price"] as? Int
		remark = dictionary["remark"] as? String
		sales = dictionary["sales"] as? Int
		searchValue = dictionary["searchValue"] as? String
		shopPrice = dictionary["shopPrice"] as? Double
		specId = dictionary["specId"] as? Int
		specName = dictionary["specName"] as? String
		stock = dictionary["stock"] as? Int
		storeId = dictionary["storeId"] as? Int
		updateBy = dictionary["updateBy"] as? String
		updateTime = dictionary["updateTime"] as? String
        
        payNum = dictionary["payNum"] as? Int
        payRemark = dictionary["payRemark"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if cost != nil{
			dictionary["cost"] = cost
		}
		if createBy != nil{
			dictionary["createBy"] = createBy
		}
		if createTime != nil{
			dictionary["createTime"] = createTime
		}
		if givePower != nil{
			dictionary["givePower"] = givePower
		}
		if goodsId != nil{
			dictionary["goodsId"] = goodsId
		}
		if image != nil{
			dictionary["image"] = image
		}
		if odinPrice != nil{
			dictionary["odinPrice"] = odinPrice
		}
		
		if price != nil{
			dictionary["price"] = price
		}
		if remark != nil{
			dictionary["remark"] = remark
		}
		if sales != nil{
			dictionary["sales"] = sales
		}
		if searchValue != nil{
			dictionary["searchValue"] = searchValue
		}
		if shopPrice != nil{
			dictionary["shopPrice"] = shopPrice
		}
		if specId != nil{
			dictionary["specId"] = specId
		}
		if specName != nil{
			dictionary["specName"] = specName
		}
		if stock != nil{
			dictionary["stock"] = stock
		}
		if storeId != nil{
			dictionary["storeId"] = storeId
		}
		if updateBy != nil{
			dictionary["updateBy"] = updateBy
		}
		if updateTime != nil{
			dictionary["updateTime"] = updateTime
		}
        
        if payNum != nil{
            dictionary["payNum"] = payNum
        }
        
        if payRemark != nil{
            dictionary["payRemark"] = payNum
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         cost = aDecoder.decodeObject(forKey: "cost") as? Float
         createBy = aDecoder.decodeObject(forKey: "createBy") as? String
         createTime = aDecoder.decodeObject(forKey: "createTime") as? String
         givePower = aDecoder.decodeObject(forKey: "givePower") as? Int
         goodsId = aDecoder.decodeObject(forKey: "goodsId") as? Int
         image = aDecoder.decodeObject(forKey: "image") as? String
         odinPrice = aDecoder.decodeObject(forKey: "odinPrice") as? Double
        
         price = aDecoder.decodeObject(forKey: "price") as? Int
         remark = aDecoder.decodeObject(forKey: "remark") as? String
         sales = aDecoder.decodeObject(forKey: "sales") as? Int
         searchValue = aDecoder.decodeObject(forKey: "searchValue") as? String
         shopPrice = aDecoder.decodeObject(forKey: "shopPrice") as? Double
         specId = aDecoder.decodeObject(forKey: "specId") as? Int
         specName = aDecoder.decodeObject(forKey: "specName") as? String
         stock = aDecoder.decodeObject(forKey: "stock") as? Int
         storeId = aDecoder.decodeObject(forKey: "storeId") as? Int
         updateBy = aDecoder.decodeObject(forKey: "updateBy") as? String
         updateTime = aDecoder.decodeObject(forKey: "updateTime") as? String
        
        payNum = aDecoder.decodeObject(forKey: "payNum") as? Int
        payRemark = aDecoder.decodeObject(forKey: "payRemark") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if cost != nil{
			aCoder.encode(cost, forKey: "cost")
		}
		if createBy != nil{
			aCoder.encode(createBy, forKey: "createBy")
		}
		if createTime != nil{
			aCoder.encode(createTime, forKey: "createTime")
		}
		if givePower != nil{
			aCoder.encode(givePower, forKey: "givePower")
		}
		if goodsId != nil{
			aCoder.encode(goodsId, forKey: "goodsId")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if odinPrice != nil{
			aCoder.encode(odinPrice, forKey: "odinPrice")
		}
		
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if remark != nil{
			aCoder.encode(remark, forKey: "remark")
		}
		if sales != nil{
			aCoder.encode(sales, forKey: "sales")
		}
		if searchValue != nil{
			aCoder.encode(searchValue, forKey: "searchValue")
		}
		if shopPrice != nil{
			aCoder.encode(shopPrice, forKey: "shopPrice")
		}
		if specId != nil{
			aCoder.encode(specId, forKey: "specId")
		}
		if specName != nil{
			aCoder.encode(specName, forKey: "specName")
		}
		if stock != nil{
			aCoder.encode(stock, forKey: "stock")
		}
		if storeId != nil{
			aCoder.encode(storeId, forKey: "storeId")
		}
		if updateBy != nil{
			aCoder.encode(updateBy, forKey: "updateBy")
		}
		if updateTime != nil{
			aCoder.encode(updateTime, forKey: "updateTime")
		}
        
        if payNum != nil{
            aCoder.encode(payNum, forKey: "payNum")
        }
        
        if payRemark != nil{
            aCoder.encode(payRemark, forKey: "payRemark")
        }

	}

}
