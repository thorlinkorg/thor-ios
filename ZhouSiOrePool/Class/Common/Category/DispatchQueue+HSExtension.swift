//
//  DispatchQueue+HSExtension.swift
//  GMG
//
//  Created by 永芯 on 2020/1/15.
//  Copyright © 2020 永芯. All rights reserved.
//

import Foundation

extension DispatchQueue {
    private static var _onceTracker = [String]()
    /// 执行一次
    public static func once(token: String, block: () -> ()) {
        objc_sync_enter(self)
        defer {
            // 在 return 之前执行
            objc_sync_exit(self)
        }
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }
    
}
