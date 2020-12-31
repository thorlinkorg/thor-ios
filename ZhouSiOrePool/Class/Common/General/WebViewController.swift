//
//  WebViewController.swift
//  HSEther
//
//  Created by 永芯 on 2019/9/18.
//  Copyright © 2019 com.houshuai. All rights reserved.
//

import UIKit
import WebKit
import SnapKit


//@objcMembers
class WebViewController: BaseViewController, WKScriptMessageHandler,WKUIDelegate {
    
    
    @objc enum LoadType : Int  {
        case web
        case HTML
        case File
        case beiyong
        case fangshuiqiang
        case yinsi
        case fuwu
        case thor
    }
    
    var webView : WKWebView!
    var loadType:LoadType = .web
    
    var urlStr:String = "https://www.baidu.com"
    var customTitle = ""
    var returnTextBlock : ((String,String)->Void)?
    // 进度条
    lazy var progressView:UIProgressView = {
        let progress = UIProgressView()
        progress.frame = CGRect(x:0,y:0,width:self.view.frame.size.width,height:2)
        progress.progressTintColor = .orange
        progress.trackTintColor = .clear
        return progress
    }()
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
        setNavTintColor(.black)
       
    
//        setNavTintColor(.clear)
//        if loadType != .fangshuiqiang {
//            setNavTintColor(.clear)
//             self.setNavBackgroundColor(.clear)
//            self.tabBarController?.tabBar.isHidden = false
//        }
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            setNavBackgroundColor(tabbarBackgroundColor)
            setNavTintColor(.black)
        self.progressView.isHidden = false
        UIView.animate(withDuration: 1.0) {
            self.progressView.progress = 0.0
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageV = UIImageView.init(image: UIImage.init(named: "bg_main"))
              imageV.frame = CGRect.init(x: 0, y: -kLiuHaiH - 44.0, width: kScreenWidth, height: kScreenHeight)
              view.addSubview(imageV)
        navigationItem.title = customTitle
        
        self.view.addSubview(self.progressView)

        let wkConfig = WKWebViewConfiguration.init()
        wkConfig.allowsInlineMediaPlayback = true
        if loadType == .fangshuiqiang{
            wkConfig.userContentController = WKUserContentController.init()
            wkConfig.userContentController.add(self, name: "btnClick")
            wkConfig.userContentController.add(self, name: "successClick")
        }
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height - kLiuHaiH - 44.0 - 100), configuration: wkConfig)
        webView.navigationDelegate = self
        webView.backgroundColor = .clear
        webView.isHidden = true
        self.view.addSubview(webView)
        
        self.progressView.snp.makeConstraints { (maker) in
            maker.top.left.right.equalTo(0)
            maker.height.equalTo(2)
        }
        
        webView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.progressView.snp_bottomMargin)
            maker.left.right.bottom.equalTo(0)
        }
        
        self.typeChanged(loadType)
    }
    
    override func clickLeftItem() {
        
        if loadType == .fangshuiqiang {
    
            navigationController?.popViewController(animated: true)
            return
        }
        
        if self.webView.canGoBack {
            self.webView.goBack()
        }
        else{
            super.clickLeftItem()
        }
    }
    
    

    func typeChanged(_ type:LoadType){
        switch type {
        case .web:
            //设置访问的url
            if let url = URL(string: self.urlStr) {
                //根据url创建请求
                let urlRequest = URLRequest(url: url)
               //加载请求
               webView.load(urlRequest)
            }

        case .HTML:
            
            self.webView.loadHTMLString(self.urlStr, baseURL: nil)
        case .yinsi:
            getPrivacyAgreement()
        case .File:
            let path = Bundle.main.path(forResource: self.urlStr, ofType: nil)
            let url = URL(fileURLWithPath: path!)
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        case .beiyong:
            let path = Bundle.main.path(forResource: "File", ofType: "pdf")
            let url = URL(fileURLWithPath: path!)
            let data = try! Data(contentsOf: url)
            webView.load(data, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: NSURL() as URL)
        case .fangshuiqiang:
            let path = Bundle.main.path(forResource: "WaterproofWall", ofType: "html")
            let url = URL(fileURLWithPath: path!)
            webView.loadFileURL(url, allowingReadAccessTo:URL.init(fileURLWithPath: Bundle.main.bundlePath))
        
        case .fuwu:
            privacyAgreement()
        case .thor:
            getThorUrl()
            
        default:
            print("出现错误")
        }
    }
    
//    隐私协议
      func getPrivacyAgreement(){
        NetworkManager<BaseModel>().requestModel(API.getAllAgreement, completion: { (response) in
            if let dic = response?.dataDict{
                let textValue = dic["privacyAgreement"] as! String
                self.webView.load(NSURLRequest(url: NSURL(string: textValue)! as URL) as URLRequest)

            }
            self.navigationItem.title = "隐私协议"
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
      }
    
    //    服务协议
    func privacyAgreement(){
        NetworkManager<BaseModel>().requestModel(API.getAllAgreement, completion: { (response) in
            if let dic = response?.dataDict{
                let textValue = dic["serverAgreement"] as! String
                self.webView.load(NSURLRequest(url: NSURL(string: textValue)! as URL) as URLRequest)
            }
            self.navigationItem.title = "服务协议"
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
    //    雷神官网链接
    func getThorUrl(){
        NetworkManager<BaseModel>().requestModel(API.getAllAgreement, completion: { (response) in
            if let dic = response?.dataDict{
                let textValue = dic["thorUrl"] as! String
                self.webView.load(NSURLRequest(url: NSURL(string: textValue)! as URL) as URLRequest)
            }
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
 
}

extension WebViewController:WKNavigationDelegate{
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        if customTitle.isEmpty {
            self.navigationItem.title = "加载中..."
        }
        /// 获取网页的progress
        UIView.animate(withDuration: 0.5) {
            self.progressView.isHidden = false
            self.progressView.progress = Float(self.webView.estimatedProgress)
        }

    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        
        if customTitle.isEmpty {
            /// 获取网页title
            self.title = self.webView.title
        }
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = 1.0
            self.progressView.isHidden = true
        }
        if loadType == .fangshuiqiang {
            self.title = "安全验证"
//            self.webView.isHidden = false
        }
         DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1) {
            webView.isHidden = false
        }
        
        
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = 0.0
            self.progressView.isHidden = true
        }
        /// 弹出提示框点击确定返回
//        let alertView = UIAlertController.init(title: "提示", message: "加载失败", preferredStyle: .alert)
//        let okAction = UIAlertAction.init(title:"确定", style: .default) { okAction in
//            _=self.navigationController?.popViewController(animated: true)
//        }
//        alertView.addAction(okAction)
//        self.present(alertView, animated: true, completion: nil)
        
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if (message.name  == "btnClick") {
             self.returnTextBlock!("","")
        }
        
        if (message.name == "successClick") {
            let dic = message.body as! Dictionary<String, String>
            self.returnTextBlock!(dic["ticket"]!,dic["randstr"]!)
        }
        clickLeftItem()
    }
    
    

}
