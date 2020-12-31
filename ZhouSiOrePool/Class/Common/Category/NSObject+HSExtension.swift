//
//  NSObject+HSExtension.swift
//  GMG
//
//  Created by 永芯 on 2020/1/15.
//  Copyright © 2020 永芯. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// The class's name
    class var hs_className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last! as String
    }
    
    /// 类实例方法交换
    ///   - targetSel: 目标方法
    ///   - newSel: 替换方法
    @discardableResult
    static func exchangeMethod(targetSel: Selector, newSel: Selector) -> Bool {
        
        guard let before: Method = class_getInstanceMethod(self, targetSel),
            let after: Method = class_getInstanceMethod(self, newSel) else {
                return false
        }

        method_exchangeImplementations(before, after)
        return true
    }
    
    
}

