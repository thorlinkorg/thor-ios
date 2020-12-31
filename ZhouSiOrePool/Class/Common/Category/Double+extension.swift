//
//  Double+extension.swift
//  ZhouSiOrePool
//
//  Created by odin on 2020/10/14.
//  Copyright © 2020 odin. All rights reserved.
//

import Foundation


extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
