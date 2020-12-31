//
//  QiniuManager.swift
//  GMG
//
//  Created by yx on 2019/12/11.
//  Copyright © 2019 yx All rights reserved.
//

import UIKit
import Qiniu

class QiniuManager: NSObject {
    
/**
     app_qiniu_access_key：B56BVHUmB4dkXf74tBP08Ix6T3XkbtGNAVYTLeTx
     app_qiniu_secret_key：5IIoDQnVE8DEiADfhtj3Egt3-2TR6QiVLOfkLeNx
     app_qiniu_buckect：heijingshop
     app_qiniu_cdn：xx.nearu.vip
     */
    
//     文件上传拼接路径 http://pfldczj5q.bkt.clouddn.com(七牛云域名，更换域名注意更换对应存储空间名称)
//    let fileUploadURL = "http://resource.chainonedapp.com/"
    
     let fileUploadURL = "https://img.nearu.vip/"

    func uploadFile(_ token: String, image: UIImage, success:@escaping ((String)->())) {
        let config = QNConfiguration.build { (builder) in
            builder?.useHttps = false
        }
        var fileName = "HeiJinimg_ios_" + Unitilty.getNowDate() + (arc4random()%1000).description
        fileName = fileName.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        let manager = QNUploadManager.sharedInstance(with: config)
        manager?.put(image.pngData(), key: fileName, token: token, complete: { (info, key, resp) in
            if let keyname = resp?["key"] as? String {
                let urlStr = self.fileUploadURL + keyname
                success(urlStr)
            }

        }, option: QNUploadOption.defaultOptions())


    }

}
