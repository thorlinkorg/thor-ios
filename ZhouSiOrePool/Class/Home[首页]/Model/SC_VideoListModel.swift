//
//  SC_VideoListModel.swift
//  ZhouSiOrePool
//
//  Created by 郭健 on 2020/10/28.
//  Copyright © 2020 odin. All rights reserved.
//

import Foundation

class SC_VideoListModel : NSObject {
    
    //视频列表
    var videoId : Int?
    var title : String?
    var poster : String?
    var videoUrl : String?
    var sort : Int?
    var type : Int?
    var status : Int?
    var createTime : String?
 
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        videoId = dictionary["videoId"] as? Int
        title = dictionary["title"] as? String
        poster = dictionary["poster"] as? String
        videoUrl = dictionary["videoUrl"] as? String
        sort = dictionary["sort"] as? Int
        type = dictionary["type"] as? Int
        status = dictionary["status"] as? Int
        createTime = dictionary["createTime"] as? String

    }
}
