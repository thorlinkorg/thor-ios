//
//  Date+exten.swift
//  WuLeiEdu
//
//  Created by 无类 on 2018/5/22.
//  Copyright © 2018年 wulei. All rights reserved.
//

import Foundation


extension Date {
    
    func toFormatString(_ format: String = "yyyy-MM-ddHH:mm:ss") -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
    
    
    // 获取当前时区的Date
    static func getCurrentDate() -> Date {
        let nowDate = Date()
        let zone = NSTimeZone.system
        let interval = zone.secondsFromGMT(for: nowDate)
        let localeDate = nowDate.addingTimeInterval(TimeInterval(interval))
        return localeDate
    }
    
    // 时间戳转换成Date
    static func timestampToDate(timeInterval: Double) -> Date {
        let date = Date.init(timeIntervalSince1970: timeInterval / 1000)
        let zone = NSTimeZone.system
        let interval = zone.secondsFromGMT(for: date)
        let localeDate = date.addingTimeInterval(TimeInterval(interval))
        return localeDate
    }

    
}
