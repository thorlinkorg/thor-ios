//
//  String+HSExtension.swift
//  MySwiftDemo
//
//  Created by 永芯 on 2019/12/4.
//  Copyright © 2019 永芯. All rights reserved.
//

import UIKit
import CommonCrypto

extension String {
    
    // MARK: - 类型转换
    var length: Int {
        ///更改成其他的影响含有emoji协议的签名
        return self.utf16.count
    }
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    var intValue: Int32 {
        return (self as NSString).intValue
    }
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    var integerValue: Int {
        return (self as NSString).integerValue
    }
    var longLongValue: Int64 {
        return (self as NSString).longLongValue
    }
    var boolValue: Bool {
        return (self as NSString).boolValue
    }
    
    // JSONString转换为字典
    func jsonToDictionary() -> [String: AnyObject]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    func htmlEntityDecode() ->String {
        var newStr = self.replacingOccurrences(of: "//", with: "http://")
        newStr = newStr.replacingOccurrences(of: "\\\"", with: "\"")
        return newStr
    }
    
    // MARK: - 截取
    
    /// 截取第一个到第任意位置
    func stringCut(end: Int) ->String{
        //        if !(end < self.count) { return "截取超出范围" }
        //        let sInde = index(startIndex, offsetBy: end)
        //        return String(self[..<sInde])
        return String(self.prefix(end))
    }
    
    /// 截取任意位置到结束
    func stringCutToEnd(star: Int) -> String {
        if !(star < self.count) { return "截取超出范围" }
        let sRang = index(startIndex, offsetBy: star)..<endIndex
        return String(self[sRang])
    }
    
    /// 字符串任意位置插入
    func stringInsert(content: String,locat: Int) -> String {
        if !(locat < self.count) { return "超出范围" }
        let str1 = stringCut(end: locat)
        let str2 = stringCutToEnd(star: locat)
        return str1 + content + str2
    }
    //获取子字符串
    func substingInRange(_ r: Range<Int>) -> String? {
        if r.lowerBound < 0 || r.upperBound > self.count {
            return nil
        }
        let startIndex = self.index(self.startIndex, offsetBy:r.lowerBound)
        let endIndex   = self.index(self.startIndex, offsetBy:r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    func pointTwoNumbe() -> String {
        if self.isEmpty {
            return "0.00"
        }
        return String(format: "%.2f", self.doubleValue)
    }
    /// 保留小数点后最大几位数
    func pointNumbe(length: Int = 2) -> String {
        let formatter = NumberFormatter.init()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = length
        formatter.groupingSeparator = ""
        return formatter.string(from: NSNumber.init(value: Double(self) ?? 0.0))!
    }
    
    // 移除末尾多余的0
    func removeFootZero(length: Int = 1) -> String {
        let formatter = NumberFormatter.init()
        formatter.numberStyle = .decimal
        // 设置最小整数位数（不足的前面补0）
        formatter.minimumIntegerDigits = length
        formatter.groupingSeparator = ""
        return formatter.string(from: NSNumber.init(value: Double(self) ?? 0.0))!
    }
    
    
    //value 是AnyObject类型是因为有可能所传的值不是String类型，有可能是其他任意的类型。
    static public func StringIsEmpty(value: String?) -> Bool {
        //首先判断是否为nil
        if (nil == value) {
            //对象是nil，直接认为是空串
            return true
        }else{
            //然后是否可以转化为String
            if let myValue  = value {
                //然后对String做判断
                return myValue == "" || myValue == "(null)" || 0 == myValue.count || myValue == " "
            }else{
                //字符串都不是，直接认为是空串
                return true
            }
        }
    }
    
    /// 隐藏中间的四位数字
    mutating func phoneNoAddAsterisk() -> String {
        if self.length > 7 {
            let startIndexs = self.index(self.startIndex, offsetBy:3)
            let endIndexs = self.index(self.startIndex, offsetBy:6)
            let ranges = startIndexs...endIndexs
            self.replaceSubrange(ranges, with:"****")
            return self;
        }
        return self;
    }
    
    // MARK: - 去空格
    
    /// 去掉首尾空格
    var removeHeadAndTailSpace:String {
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }
    
    /// 去掉首尾空格 包括后面的换行 \n
    var removeHeadAndTailSpacePro:String {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }
    
    /// 去除字符串中所有的空格
    var removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    
    // MARK: - 格式校验
    
    ///判断是否是中文
    func isChinese() -> Bool {
        let match = "(^[\u{4e00}-\u{9fa5}]+$)"
        let predicate = NSPredicate(format: "SELF matches %@", match)
        return predicate.evaluate(with: self)
    }
    
    ///判断是否是数字
    func isNumber() -> Bool {
        let match = "(^[1-9]d*.d*|0.d*[1-9]d*$)"
        let predicate = NSPredicate(format: "SELF matches %@", match)
        return predicate.evaluate(with: self)
    }
    
    // 判断输入的字符串是否为数字，不含其它字符
    func isPurnInt(string: String) -> Bool {
        let scan: Scanner = Scanner(string: string)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }
    
    func isEthAddress() -> Bool {
        let addressRegex = "0x[a-zA-Z0-9]{40}"
        let addressTest = NSPredicate(format: "SELF MATCHES %@", addressRegex)
        return addressTest.evaluate(with: self)
    }
    
    func substring(from index: Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex..<self.endIndex]
            
            return String(subString)
        } else {
            return self
        }
    }
    
    func replaceODINToEthAddress()->String{
        if self.hasPrefix("odx"){
            return "0x" + self.substring(from: 3)
        } else if self.hasPrefix("0T"){
            return "0x" + self.substring(from: 2)
        }
        return self
    }
    
    
    ///判断手机号码格式是否正确
    func valiMobile() -> Bool {
        let phoneRegex = "^1[23456789]{1}\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
    /// 检查邮箱格式
    func validateEmail() -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    /// 检查支付密码
    func checkPaypass() -> Bool {
        let regex = "[0-9._%+-]{6}"
        let predicateTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicateTest.evaluate(with: self)
    }
    
    /// URL
    func isUrl() -> Bool {
        let regex = "[a-zA-z]+://.*"
        let predicateTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicateTest.evaluate(with: self)
    }
    
    /// 检密码
    func checkPassword() -> Bool {
        let regex = "^[A-Za-z0-9\\^\\$\\.\\+\\*_@!#%&~=-]{6,20}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isMatch:Bool = predicate.evaluate(with: self)
        return isMatch
    }
    
    /// 校验身份证
    func checkUserIdCard() ->Bool {
        let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
        return isMatch;
    }
    
    
    /// 验证身份证
    func checkIdentityCardNumber() -> Bool {
        var value = self
        value = value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        var length : Int = 0
        length = value.count
        if length != 15 && length != 18{
            //不满足15位和18位，即身份证错误
            return false
        }
        // 省份代码
        let areasArray = ["11","12", "13","14", "15","21", "22","23", "31","32", "33","34", "35","36", "37","41", "42","43", "44","45", "46","50", "51","52", "53","54", "61","62", "63","64", "65","71", "81","82", "91"]
        // 检测省份身份行政区代码
        let index = value.index(value.startIndex, offsetBy: 2)
        //        let valueStart2 = value.substring(to: index)
        let valueStart2 = String(value[..<index])
        //标识省份代码是否正确
        var areaFlag = false
        for areaCode in areasArray {
            if areaCode == valueStart2 {
                areaFlag = true
                break
            }
        }
        if !areaFlag {
            return false
        }
        var regularExpression : NSRegularExpression?
        var numberofMatch : Int?
        var year = 0
        switch length {
        case 15:
            //获取年份对应的数字
            let startIndex = value.index(value.startIndex, offsetBy: 6)
            let endIndex = value.index(value.startIndex, offsetBy: 8)
            let yearStr = String(value[startIndex..<endIndex])
            
            year = yearStr.integerValue + 1900
            if year % 4 == 0 || (year % 100 == 0 && year % 4 == 0) {
                //创建正则表达式 NSRegularExpressionCaseInsensitive：不区分字母大小写的模式
                //测试出生日期的合法性
                regularExpression = try! NSRegularExpression.init(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$", options: NSRegularExpression.Options.caseInsensitive)
            }else{
                //测试出生日期的合法性
                regularExpression = try! NSRegularExpression.init(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$", options: NSRegularExpression.Options.caseInsensitive)
            }
            numberofMatch = regularExpression?.numberOfMatches(in: value, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange.init(location: 0, length: value.count))
            if numberofMatch! > 0 {
                return true
            }else{
                return false
            }
        case 18:
            let startIndex = value.index(value.startIndex, offsetBy: 6)
            let endIndex = value.index(value.startIndex, offsetBy: 10)
            let yearStr = String(value[startIndex..<endIndex])
            
            year = yearStr.integerValue
            if year % 4 == 0 || (year % 100 == 0 && year % 4 == 0) {
                //测试出生日期的合法性
                regularExpression = try! NSRegularExpression.init(pattern: "^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$", options: NSRegularExpression.Options.caseInsensitive)
                
            }else{
                //测试出生日期的合法性
                regularExpression = try! NSRegularExpression.init(pattern: "^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$", options: NSRegularExpression.Options.caseInsensitive)
                
            }
            numberofMatch = regularExpression?.numberOfMatches(in: value, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange.init(location: 0, length: value.count))
            
            if numberofMatch! > 0 {
                let a = getStringByRangeIntValue(value, r: 0..<1) * 7
                let b = getStringByRangeIntValue(value, r: 10..<11) * 7
                let c = getStringByRangeIntValue(value, r: 1..<2) * 9
                let d = getStringByRangeIntValue(value, r: 11..<12) * 9
                let e = getStringByRangeIntValue(value, r: 2..<3) * 10
                let f = getStringByRangeIntValue(value, r: 12..<13) * 10
                let g = getStringByRangeIntValue(value, r: 3..<4) * 5
                let h = getStringByRangeIntValue(value, r: 13..<14) * 5
                let i = getStringByRangeIntValue(value, r: 4..<5) * 8
                let j = getStringByRangeIntValue(value, r: 14..<15) * 8
                let k = getStringByRangeIntValue(value, r: 5..<6) * 4
                let l = getStringByRangeIntValue(value, r: 15..<16) * 4
                let m = getStringByRangeIntValue(value, r: 6..<7) * 2
                let n = getStringByRangeIntValue(value, r: 16..<17) * 2
                let o = getStringByRangeIntValue(value, r: 7..<8) * 1
                let p = getStringByRangeIntValue(value, r: 8..<9) * 6
                let q = getStringByRangeIntValue(value, r: 9..<10) * 3
                let S = a + b + c + d + e + f + g + h + i + j + k + l + m + n + o + p + q
                
                let Y = S % 11
                var M = "F"
                let JYM = "10X98765432"
                //                    M = (JYM as NSString).substring(with: NSRange.init(location: Y, length: 1))
                M = JYM.substingInRange(Y..<Y+1) ?? ""
                //                    let lastStr = valueNSStr.substring(with: NSRange.init(location: 17, length: 1))
                let lastStr = value.substingInRange(17..<18)
                if lastStr == "x" {
                    if M == "X" {
                        return true
                    }else{
                        return false
                    }
                }else{
                    if M == lastStr {
                        return true
                    }else{
                        return false
                    }
                }
                
            }else{
                return false
            }
        default:
            return false
        }
    }
    private func getStringByRangeIntValue(_ Str : String ,r: Range<Int>) -> Int{
        
        if r.lowerBound < 0 || r.upperBound > self.count {
            return 0
        }
        let startIndex = self.index(self.startIndex, offsetBy:r.lowerBound)
        let endIndex   = self.index(self.startIndex, offsetBy:r.upperBound)
        let a = String(self[startIndex..<endIndex])
        return Int(a) ?? 0
        
    }
    
    /// 校验验证码
    func checkAuthCodeStr() ->Bool {
        //        let pattern: String = "[a-zA-Z0-9._%+-]+"
        let pattern = "^([0-9]){4,6}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
        return isMatch;
    }
    /// 限制输入长度
    func check(length:Int) ->Bool {
        //        let pattern: String = "[a-zA-Z0-9._%+-]+"
        let pattern = "[0-9]{0,\(length.description)}$"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
        return isMatch;
    }
    
    /// 校验金额
    /// - Parameter precision: 精度
    func validateMoney(precision:Int) -> Bool {
        let stringRegex: String = "(([0]|(0[.]\\d{0,\(precision)}))|([1-9]\\d{0,20}(([.]\\d{0,\(precision)})?)))?"
        let pred: NSPredicate = NSPredicate(format: "SELF MATCHES %@", stringRegex)
        return pred.evaluate(with: self)
    }
    
    /// 检测银行卡
    func verifyBankCard() -> Bool {
        let pattern = "^([0-9]{16}|[0-9]{19}|[0-9]{17}|[0-9]{18}|[0-9]{20}|[0-9]{21})$"
        let regex = try! NSRegularExpression(pattern: pattern, options:NSRegularExpression.Options.dotMatchesLineSeparators)
        if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) {
            return true
        }
        return false
    }
    /// 处理银行卡号(隐藏几位)
    mutating func bankCardAddAsterisk() -> String {
        if self.count == 0 {
            return self
        }
        let startIndexs = self.index(self.startIndex, offsetBy:4)
        let endIndexs = self.index(self.startIndex, offsetBy:10)
        let ranges = startIndexs...endIndexs
        self.replaceSubrange(ranges, with:"***********")
        return self
    }
    
    /// 格式化 每4位空格
    public func formateForBankCard(joined: String = " ") -> String {
        guard self.count > 0 else {
            return self
        }
        let length: Int = self.count
        let count: Int = length / 4
        var data: [String] = []
        for i in 0..<count {
            let start: Int = 4 * i
            let end: Int = 4 * (i + 1)
            data.append(self.substingInRange(start..<end)!)
        }
        if length % 4 > 0 {
            data.append(self.substingInRange(4 * count..<length)!)
        }
        let result = data.joined(separator: " ")
        return result
    }
    
    
    // base64编码
    var toBase64 : String! {
        
        let utf8EncodeData = self.data(using: String.Encoding.utf8, allowLossyConversion: true)
        // 将NSData进行Base64编码
        let base64String = utf8EncodeData?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: UInt(0)))
        
        
        return base64String
    }
    
    
    
    // MARK: - 加密解密
    
    var sha256String: String! {
        
        func digest(input : NSData) -> NSData {
            let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
            var hash = [UInt8](repeating: 0, count: digestLength)
            CC_SHA256(input.bytes, UInt32(input.length), &hash)
            return NSData(bytes: hash, length: digestLength)
        }
        
        func hexStringFromData(input: NSData) -> String {
            var bytes = [UInt8](repeating: 0, count: input.length)
            input.getBytes(&bytes, length: input.length)
            
            var hexString = ""
            for byte in bytes {
                hexString += String(format:"%02x", UInt8(byte))
            }
            
            return hexString
        }
        
        if let stringData = self.data(using: .utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return ""
        
    }
    
    
    // 自定义加密 加密后截取后40位
    var baseSha256String: String! {
        let firSha = self.sha256String
        if firSha?.length ?? 0 >= 40 {
            return firSha?.stringCutToEnd(star: 24)
        }
        return ""
    }
    
    // JSONString转换为字典
    func getDictionaryFromJSONString() -> [String: AnyObject] {
        
        let jsonData:Data = self.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! [String: AnyObject]
        }
        return [String: AnyObject]()
    }
    
    
    // MARK: email
    func isValidEmail() -> Bool {
        #if os(Linux) && !swift(>=3.1)
        let regex = try? RegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        #else
        let regex = try? NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        #endif
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    }
    
    
    //    private func digest(input : NSData) -> NSData {
    //        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
    //        var hash = [UInt8](repeating: 0, count: digestLength)
    //        CC_SHA256(input.bytes, UInt32(input.length), &hash)
    //        return NSData(bytes: hash, length: digestLength)
    //    }
    //    private func hexStringFromData(input: NSData) -> String {
    //        var bytes = [UInt8](repeating: 0, count: input.length)
    //        input.getBytes(&bytes, length: input.length)
    //
    //        var hexString = ""
    //        for byte in bytes {
    //            hexString += String(format:"%02x", UInt8(byte))
    //        }
    //
    //        return hexString
    //    }
    
    func md5() -> String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
        
    }
    
    // MARK: - 文件目录
    
    /// 将当前字符串拼接到cache目录后面
    func cacheDir() -> String{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        return (path as NSString).appendingPathComponent((self as NSString).lastPathComponent)
    }
    
    /// 将当前字符串拼接到doc目录后面
    func docDir() -> String{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
        return (path as NSString).appendingPathComponent((self as NSString).lastPathComponent)
    }
    
    //    /// 将当前字符串拼接到tmp目录后面
    //    func tmpDir() -> String{
    //       let path = NSTemporaryDirectory() as NSString
    //       return path.appendingPathComponent((self as NSString).lastPathComponent)
    //    }
    
    /// 文件创建
    func createDirectory() -> Bool {
        
        var isDirectory = ObjCBool.init(false)
        let fileManager = FileManager.default
        let isExist = fileManager.fileExists(atPath: self, isDirectory: &isDirectory)
        
        var flag = false
        
        if !isExist {//不存在 创建
            flag = fileManager.createFile(atPath: self, contents: nil, attributes: nil)
            if flag {
                print("文件创建成功")
                return true
            }else {
                print("文件创建失败")
                return false
            }
        }
        //  存在
        if isDirectory.boolValue {
            return true
        }
        return true
    }
    
    func reviseString()->String{
        let conversionValue = Double(self)
        let doubleString = String(format: "%lf", conversionValue ?? 0)
        let decNumber = NSDecimalNumber(string: doubleString)
        
        return decNumber.stringValue
    }
    
    func deleteFile() -> Bool {
        do {
            try FileManager.default.removeItem(atPath: self)
            return true
        } catch {
            return false
        }
    }
    
    /// Calculate the size of string, and limit the width 计算字符串的大小，并限制宽度
    func hs_sizeWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGSize {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size: CGSize = self.boundingRect(
            with: constraintRect,
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        ).size
        return size
    }
    /// Calculate the height of string, and limit the width 计算字符串的高度，限制宽度
    func hs_heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil)
        return boundingBox.height
    }
    /// Calculate the width of string with current font size.  使用当前字体大小计算字符串的宽度。
    func hs_widthWithCurrentFont(_ font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: font.pointSize)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil)
        return boundingBox.width
    }
}


extension Data {
    func dataToDictionary() ->Dictionary<String, Any>?{
        let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? Dictionary<String,Any>
        return json
    }
}


extension Double{
    
    func wShowString()->String{
        if self >= 100000000{
            //            return "\(self / 100000000.0)" + "亿"
            return String(format: "%.4lf 亿", self / 100000000.0)
        } else if self >= 10000{
            //            return "\(self / 10000.0)" + "万"
            return String(format: "%.4lf 万", self / 10000.0)
        } else if self == 0.0{
            return "-"
        } else {
            return "\(self)"
        }
    }
}
