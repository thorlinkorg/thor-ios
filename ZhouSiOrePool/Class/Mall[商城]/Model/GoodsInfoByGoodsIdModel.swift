//
//	GoodsInfoByGoodsIdModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class GoodsInfoByGoodsIdModel : NSObject, NSCoding{

	var cateId : Int!
	var cost : Int!
	var createBy : String!
	var createTime : String!
	var descriptionField : String!
	var givePower : Int!
	var goodsId : Int!
	var goodsInfo : String!
	var goodsName : String!
	var image : String!
	var isDel : Int!
	var isShow : Int!
	var odinPrice : Double!
	var price : Double?
	var remark : String!
	var sales : Int!
	var searchValue : String!
	var shopPrice : Double!
	var sliderImage : String!
	var sort : Int!

	var stock : Int!
	var storeId : Int!
	var storeName : String!
	var unitName : String!
	var updateBy : String!
	var updateTime : String!
	var virtualSales : Int!


    
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		cateId = dictionary["cateId"] as? Int
		cost = dictionary["cost"] as? Int
		createBy = dictionary["createBy"] as? String
		createTime = dictionary["createTime"] as? String
		descriptionField = dictionary["description"] as? String
		givePower = dictionary["givePower"] as? Int
		goodsId = dictionary["goodsId"] as? Int
		goodsInfo = dictionary["goodsInfo"] as? String
		goodsName = dictionary["goodsName"] as? String
		image = dictionary["image"] as? String
		isDel = dictionary["isDel"] as? Int
		isShow = dictionary["isShow"] as? Int
		odinPrice = dictionary["odinPrice"] as? Double
		price = dictionary["price"] as? Double
		remark = dictionary["remark"] as? String
		sales = dictionary["sales"] as? Int
		searchValue = dictionary["searchValue"] as? String
		shopPrice = dictionary["shopPrice"] as? Double
		sliderImage = dictionary["sliderImage"] as? String
		sort = dictionary["sort"] as? Int
	
		stock = dictionary["stock"] as? Int
		storeId = dictionary["storeId"] as? Int
		storeName = dictionary["storeName"] as? String
		unitName = dictionary["unitName"] as? String
		updateBy = dictionary["updateBy"] as? String
		updateTime = dictionary["updateTime"] as? String
		virtualSales = dictionary["virtualSales"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if cateId != nil{
			dictionary["cateId"] = cateId
		}
		if cost != nil{
			dictionary["cost"] = cost
		}
		if createBy != nil{
			dictionary["createBy"] = createBy
		}
		if createTime != nil{
			dictionary["createTime"] = createTime
		}
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if givePower != nil{
			dictionary["givePower"] = givePower
		}
		if goodsId != nil{
			dictionary["goodsId"] = goodsId
		}
		if goodsInfo != nil{
			dictionary["goodsInfo"] = goodsInfo
		}
		if goodsName != nil{
			dictionary["goodsName"] = goodsName
		}
		if image != nil{
			dictionary["image"] = image
		}
		if isDel != nil{
			dictionary["isDel"] = isDel
		}
		if isShow != nil{
			dictionary["isShow"] = isShow
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
		if sliderImage != nil{
			dictionary["sliderImage"] = sliderImage
		}
		if sort != nil{
			dictionary["sort"] = sort
		}
		
		if stock != nil{
			dictionary["stock"] = stock
		}
		if storeId != nil{
			dictionary["storeId"] = storeId
		}
		if storeName != nil{
			dictionary["storeName"] = storeName
		}
		if unitName != nil{
			dictionary["unitName"] = unitName
		}
		if updateBy != nil{
			dictionary["updateBy"] = updateBy
		}
		if updateTime != nil{
			dictionary["updateTime"] = updateTime
		}
		if virtualSales != nil{
			dictionary["virtualSales"] = virtualSales
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         cateId = aDecoder.decodeObject(forKey: "cateId") as? Int
         cost = aDecoder.decodeObject(forKey: "cost") as? Int
         createBy = aDecoder.decodeObject(forKey: "createBy") as? String
         createTime = aDecoder.decodeObject(forKey: "createTime") as? String
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         givePower = aDecoder.decodeObject(forKey: "givePower") as? Int
         goodsId = aDecoder.decodeObject(forKey: "goodsId") as? Int
         goodsInfo = aDecoder.decodeObject(forKey: "goodsInfo") as? String
         goodsName = aDecoder.decodeObject(forKey: "goodsName") as? String
         image = aDecoder.decodeObject(forKey: "image") as? String
         isDel = aDecoder.decodeObject(forKey: "isDel") as? Int
         isShow = aDecoder.decodeObject(forKey: "isShow") as? Int
         odinPrice = aDecoder.decodeObject(forKey: "odinPrice") as? Double
         price = aDecoder.decodeObject(forKey: "price") as? Double
         remark = aDecoder.decodeObject(forKey: "remark") as? String
         sales = aDecoder.decodeObject(forKey: "sales") as? Int
         searchValue = aDecoder.decodeObject(forKey: "searchValue") as? String
         shopPrice = aDecoder.decodeObject(forKey: "shopPrice") as? Double
         sliderImage = aDecoder.decodeObject(forKey: "sliderImage") as? String
         sort = aDecoder.decodeObject(forKey: "sort") as? Int
         
         stock = aDecoder.decodeObject(forKey: "stock") as? Int
         storeId = aDecoder.decodeObject(forKey: "storeId") as? Int
         storeName = aDecoder.decodeObject(forKey: "storeName") as? String
         unitName = aDecoder.decodeObject(forKey: "unitName") as? String
         updateBy = aDecoder.decodeObject(forKey: "updateBy") as? String
         updateTime = aDecoder.decodeObject(forKey: "updateTime") as? String
         virtualSales = aDecoder.decodeObject(forKey: "virtualSales") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if cateId != nil{
			aCoder.encode(cateId, forKey: "cateId")
		}
		if cost != nil{
			aCoder.encode(cost, forKey: "cost")
		}
		if createBy != nil{
			aCoder.encode(createBy, forKey: "createBy")
		}
		if createTime != nil{
			aCoder.encode(createTime, forKey: "createTime")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if givePower != nil{
			aCoder.encode(givePower, forKey: "givePower")
		}
		if goodsId != nil{
			aCoder.encode(goodsId, forKey: "goodsId")
		}
		if goodsInfo != nil{
			aCoder.encode(goodsInfo, forKey: "goodsInfo")
		}
		if goodsName != nil{
			aCoder.encode(goodsName, forKey: "goodsName")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if isDel != nil{
			aCoder.encode(isDel, forKey: "isDel")
		}
		if isShow != nil{
			aCoder.encode(isShow, forKey: "isShow")
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
		if sliderImage != nil{
			aCoder.encode(sliderImage, forKey: "sliderImage")
		}
		if sort != nil{
			aCoder.encode(sort, forKey: "sort")
		}
		
		if stock != nil{
			aCoder.encode(stock, forKey: "stock")
		}
		if storeId != nil{
			aCoder.encode(storeId, forKey: "storeId")
		}
		if storeName != nil{
			aCoder.encode(storeName, forKey: "storeName")
		}
		if unitName != nil{
			aCoder.encode(unitName, forKey: "unitName")
		}
		if updateBy != nil{
			aCoder.encode(updateBy, forKey: "updateBy")
		}
		if updateTime != nil{
			aCoder.encode(updateTime, forKey: "updateTime")
		}
		if virtualSales != nil{
			aCoder.encode(virtualSales, forKey: "virtualSales")
		}

	}

}
