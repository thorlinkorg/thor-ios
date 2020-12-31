//
//	HomeActivityModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class HomeActivityModel : NSObject,Codable{

	var activityId : Int?
	var createBy : String?
	var createTime : String?
	var icon : String?
	var isShow : Int?
	var remark : String?
	var searchValue : String?
	var sort : Int?
	var title : String?
	var updateBy : String?
	var updateTime : String?


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		activityId = dictionary["activityId"] as? Int
		createBy = String((dictionary["createBy"] as? String) ?? "")
		createTime = String((dictionary["createTime"] as? String) ?? "")
		icon = String((dictionary["icon"] as? String) ?? "")
		isShow = dictionary["isShow"] as? Int
		
		remark = String((dictionary["remark"] as? String) ?? "")
		searchValue = String((dictionary["searchValue"] as? String) ?? "")
		sort = dictionary["sort"] as? Int
		title = String((dictionary["title"] as? String) ?? "")
		updateBy = String((dictionary["updateBy"] as? String) ?? "")
		updateTime = String((dictionary["updateTime"] as? String) ?? "")
	}

}
