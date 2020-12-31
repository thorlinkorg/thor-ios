//
//  UITableView+exten.swift
//  WuLeiEdu
//
//  Created by 无类 on 2018/4/18.
//  Copyright © 2018年 wulei. All rights reserved.
//
import UIKit

extension UITableView {
    
    func registerNib<T>(_ type: T.Type) {
        let name = String(describing: type)
        register(UINib.init(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
    
    func dequeueCell<T>(_ identifier: T.Type, _ indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: identifier), for: indexPath) as! T
    }
    
}
