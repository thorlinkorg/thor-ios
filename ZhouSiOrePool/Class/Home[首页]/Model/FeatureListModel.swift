//
//	FeatureListModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class FeatureListModel : NSObject, Codable{

	var goodsId : Int!
	var homeImgId : Int!
	var imgType : Int!
	var imgUrl : String!
	var type : Int!
	var url : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		goodsId = dictionary["goodsId"] as? Int
		homeImgId = dictionary["homeImgId"] as? Int
		imgType = dictionary["imgType"] as? Int
		imgUrl = dictionary["imgUrl"] as? String
		type = dictionary["type"] as? Int
		url = dictionary["url"] as? String
	}

}
