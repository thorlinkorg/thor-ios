//
//  Unitilty.swift
//  MySwiftDemo
//
//  Created by 永芯 on 2019/12/5.
//  Copyright © 2019 永芯. All rights reserved.
//

import UIKit
import Photos

class Unitilty: NSObject {
        
    //MARK:---时间
    
    /// 获取当前时间戳
    static func getCurrentTimeStamp() -> TimeInterval{
        let nowDate = Date.init()
        //10位数时间戳
//        let interval = Int(nowDate.timeIntervalSince1970)
//        let interval = nowDate.timeIntervalSince1970
        //13位数时间戳 (13位数的情况比较少见)
        let interval = CLongLong(round(nowDate.timeIntervalSince1970*1000))
        return TimeInterval(interval)
    }
    
    /// 获取当前的时间(年-月-日 时-分-秒)
//    class func getNowDate() -> String {
//        return Unitilty.getNowDate()
//    }
    
    static func getNowDate(_ formate:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        let date:NSDate = NSDate()
        let dateStr = dateFormatter.string(from: date as Date)
        return dateStr
    }
    

    
    /// 日期 -> 字符串
    static func dateToString(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    /// 字符串 -> 日期
    static func stringToDate(_ string:String, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: string)
        return date!
    }
    
    /// 将时间戳转化成对应格式的时间字符串
    static func getDateFormatString(timeStamp:Int, formate:String = "yyyy-MM-dd HH:mm:ss") ->String{

        let interval:TimeInterval = TimeInterval.init(timeStamp/1000)
        let date = Date(timeIntervalSince1970: interval)
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale.init(identifier: "zh_CN")
        //自定义日期格式
        dateformatter.dateFormat = formate
        return dateformatter.string(from: date)

    }
    

    /// 秒数转化为时间字符串
    static func secondsToTimeString(seconds: Int) -> String {
        //天数计算
        let days = (seconds)/(24*3600);
        
        //小时计算
        let hours = (seconds)%(24*3600)/3600;
        
        //分钟计算
        let minutes = (seconds)%3600/60;
        
        //秒计算
        let second = (seconds)%60;
        
        var timeString = ""
    
        if days != 0 {
            timeString  = String(format: "%lu天 %02lu:%02lu:%02lu", days, hours, minutes, second)
        }else if hours != 0 {
            timeString  = String(format: "%02lu:%02lu:%02lu", hours, minutes, second)
        }else {
            timeString  = String(format: "%02lu:%02lu", minutes, second)
        }
        return timeString
    }
    
    
    
    static func hourDaoJiShi(_ time:String) -> Int{
        let curCalendar:NSCalendar = NSCalendar.current as NSCalendar

        let aformatter = DateFormatter()
        aformatter.dateFormat = "yyyy-MM-dd"
        aformatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        let  dates = aformatter.string(from: Date())
        let datesH = dates + " " + time

        var dateresult = Unitilty.stringConvertDate(string: datesH)
        let datadq =
            Unitilty.stringConvertDate(string: Unitilty.getNowDate())
        // date1 < date2 升序排列
        if dateresult.compare(datadq) == .orderedAscending ||  dateresult.compare(datadq) ==  .orderedSame
        {
              print("<")
            dateresult = curCalendar.date(byAdding: NSCalendar.Unit.hour, value:  24, to: dateresult as Date, options: NSCalendar.Options())!
            
        }
        
        
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let result = gregorian!.components(NSCalendar.Unit.second, from: datadq, to:dateresult as Date, options: NSCalendar.Options())
        
        return result.second!
    }
    
    
   static func stringConvertDate(string:String, dateFormat:String="yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: string)
        return date!
    }
    
    
    ///json解析
    static func jsonFromObject(dic:Dictionary<String, Any>) -> String {
        do{
            let json = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
            if let str = String(data: json, encoding: .utf8) {
                return str
            }
            return ""
//            return NSString.init(data: json as Data, encoding: String.Encoding.utf8.rawValue)! as String
        }catch{
            return ""
        }
    }
    
    /// 字典排序
    func dictSort(dict:Dictionary<String, Any>) -> String {
        let keys = dict.sorted(by: {$0.0 < $1.0})
        var str = ""
        for key in keys {
            str.append(key.key)
            let value = key.value as! String
            if value.count > 0 {
                str.append(value)
            }else {
                str.append("")
            }
        }
        return str
    }
    
    /// 相机权限
    class func cameraPermissions(authorizedBlock: @escaping (()->Void), deniedBlock: (()->Void)?) {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        
        // .notDetermined  .authorized  .restricted  .denied
        switch authStatus {
        case .notDetermined:
            // 第一次触发授权 alert
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                self.cameraPermissions(authorizedBlock: authorizedBlock, deniedBlock: deniedBlock)
            })
        case .authorized:
            DispatchQueue.main.async {
                authorizedBlock()
            }
        default:
            DispatchQueue.main.async {
                if deniedBlock != nil {
                    deniedBlock!()
                }
            }
        }
    }
    
    /// 相册权限
    class func photoAlbumPermissions(authorizedBlock: @escaping (()->Void), deniedBlock: (()->Void)?) {
        let authStatus = PHPhotoLibrary.authorizationStatus()
        
        // .notDetermined  .authorized  .restricted  .denied
        switch authStatus {
        case .notDetermined:
            // 第一次触发授权 alert
            PHPhotoLibrary.requestAuthorization { (status:PHAuthorizationStatus) -> Void in
                self.photoAlbumPermissions(authorizedBlock: authorizedBlock, deniedBlock: deniedBlock)
            }
        case .authorized:
            DispatchQueue.main.async {
                authorizedBlock()
            }
        default:
            DispatchQueue.main.async {
                if deniedBlock != nil {
                    deniedBlock!()
                }
            }
        }
        
        // 使用
//        Unitilty.photoAlbumPermissions(authorizedBlock: {
//            print("打开相册")
//        }, deniedBlock: {
//            print("没有权限打开相册")
//        })
    }
    
    static func selectPicture(_ vc: UIViewController, allowsEditing:Bool = false) {
        let alert = UIAlertController.init(style: .actionSheet)
        alert.addAction(title: "拍照") { (action) in
            Unitilty.cameraPermissions(authorizedBlock: {
                self.presentImagePicker(vc, type: .camera, allowsEditing: allowsEditing)
            }) {
            }
        }
        alert.addAction(title: "从手机相册中选择") { (action) in
            Unitilty.photoAlbumPermissions(authorizedBlock: {
                self.presentImagePicker(vc, type: .photoLibrary, allowsEditing: allowsEditing)
            }) {
            }
        }
        alert.addAction(title: "取消", style: .cancel)
        vc.present(alert, animated: true, completion: nil)
    }
    
    private static func presentImagePicker(_ vc: UIViewController, type:UIImagePickerController.SourceType, allowsEditing:Bool){
        if UIImagePickerController.isSourceTypeAvailable(type) {
            let picker = UIImagePickerController.init()
            picker.sourceType = type
            picker.allowsEditing = allowsEditing
            picker.delegate = vc as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            DispatchQueue.main.async {
                vc.present(picker, animated: true, completion: nil)
            }
        } else {
            print("设备不支持")
        }
        
    }
    
    static func AboutIsMaxVersion() {
        

        
        
        //获取历史版本
        NetworkManager<BaseModel>().requestModel(API.versionGets, completion: { (response) in
            if let dict = response?.dataDict {
//                forceUpdate
                if let versionNo = dict["version"] as? String {
                    let curVersionNo = Bundle.hs_appVersion
                    if versionNo > curVersionNo {
                        IsSh = false
                        if let content = dict["update_desc"] {
                        
                            let vc = VersionUpdateVController.init()
                            vc.updateDescText = (content as! String)
                            vc.downUrl =  (dict["update_url"] as! String)
                             vc.view.backgroundColor = vcBoxBlack
                             vc.modalPresentationStyle = .overCurrentContext;
                            vc.modalTransitionStyle = .crossDissolve;
                                 
                            keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)

                        }
                    } else if versionNo < curVersionNo {
                        IsSh = true
                    } else {
                        IsSh = false
                    }
                }
            }
        }) { (error) in
            IsSh = true
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }

    }
    
    /// 判断是否在交易时间
    static func tradingHours() -> Bool {
        let calendar = Calendar.current;
        let now = Date();
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
        let second = calendar.component(.second, from: now)
        let curTime = hour * 60 * 60 + minute * 60 + second
        let start = 9 * 60 * 60;
        let end = 23 * 60 * 60;
        
        if curTime > start && curTime < end {
            return true
        }
        return false
    }
    
    /// 判断系统当前选择的语言
//    static func getLanguageType() -> String {
//        let def = UserDefaults.standard
//        let allLanguages: [String] = def.object(forKey: "AppleLanguages") as! [String]
////        "zh-Hans-US", "en"
//        let chooseLanguage = allLanguages.first
//        return chooseLanguage ?? "en"
//    }
    //将文件大小转换文KB\MB\GB
    static func byteCountFormatter(size:UInt) -> String {
        let tokens = ["B","KB","MB","GB","TB","PB", "EB"]
        var multiplyFactor = 0
        var convertedValue = size
        while convertedValue > 1024 {
            convertedValue /= 1024
            multiplyFactor += 1
        }
        return convertedValue.description + " " + tokens[multiplyFactor]
    }
    
    
        /// 判断系统当前选择的语言
        static func getLanguageType() -> String {
            let def = UserDefaults.standard
            let allLanguages: [String] = def.object(forKey: "AppleLanguages") as! [String]
    //        "zh-Hans-US", "en"
            let chooseLanguage = allLanguages.first
            return chooseLanguage ?? "en"
        }
    
    
    

}

