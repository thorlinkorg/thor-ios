//
//	SystemInformsModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class SystemInformsModel : NSObject, Codable {

	var createBy : String!
	var createTime : String!
	var id : Int!
	var informValue : String!
	var remark : String!
	var searchValue : String!
	var status : String!
	var title : String!
	var type : String!
	var updateBy : String!
	var updateTime : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		createBy = dictionary["createBy"] as? String
		createTime = dictionary["createTime"] as? String
		id = dictionary["id"] as? Int
		informValue = dictionary["informValue"] as? String
		remark = dictionary["remark"] as? String
		searchValue = dictionary["searchValue"] as? String
		status = dictionary["status"] as? String
		title = dictionary["title"] as? String
		type = dictionary["type"] as? String
		updateBy = dictionary["updateBy"] as? String
		updateTime = dictionary["updateTime"] as? String
	}
}
