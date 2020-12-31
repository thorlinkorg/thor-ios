//
//  SC_MallDetailController.swift
//  ZhouSiOrePool
//
//  Created by odin on 2020/9/28.
//  Copyright © 2020 odin. All rights reserved.
//

import UIKit
import WebKit
import LLCycleScrollView


class SC_MallDetailController: BaseViewController {
    
    var bannerView: LLCycleScrollView!
    var tableView: UITableView!
    var webView: WKWebView!
    var goodsId: String!
    var amailLabelDetailsView: MailLabelDetailsView!
    var specListModel:SpecListModel!
    var goodsInfoByGoodsIdModel:GoodsInfoByGoodsIdModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "商品详情"
        self.view.backgroundColor = .white
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - NaviBar_Height - kTabBarHeight + 10 ))
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        view.addSubview(tableView)
        
        let tableHeaderView = UIView.init(frame:CGRect.init(x: 0, y: 0, width: kScreenWidth, height: (250.0/345.0)*(kScreenWidth - 30.0) + 230))
        let  bannerViewframe = CGRect.init(x: 0, y: 8 , width: kScreenWidth, height: (250.0/345.0)*(kScreenWidth - 30.0))
        bannerView = LLCycleScrollView.init()
        bannerView.frame = bannerViewframe
        
        //        let arr = Bundle.main.loadNibNamed("MailLabelDetailsView", owner: nil, options: nil)
        //        let mailLabelDetailsView:MailLabelDetailsView = arr![0]  as! MailLabelDetailsView
        let mailLabelDetailsView = MailLabelDetailsView.loadFromNib()
        mailLabelDetailsView.frame = CGRect.init(x: 0, y: bannerView.bottom, width: kScreenWidth , height: 150.0)
        amailLabelDetailsView = mailLabelDetailsView
        
        let fengeView = UIView.init(frame: CGRect(x: 0, y: mailLabelDetailsView.bottom, width: kScreenWidth, height: 10))
        fengeView.backgroundColor = vcBackLightGrayColor
        
        
        let arr2 = Bundle.main.loadNibNamed("MailDetailsTextView", owner: nil, options: nil)
        let mailDetailsTextView:MailDetailsTextView = arr2![0]  as! MailDetailsTextView
        mailDetailsTextView.frame = CGRect.init(x: 0, y: fengeView.bottom, width: kScreenWidth , height: 67.0)
        
        
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width:kScreenWidth, height: 0))
        
        tableHeaderView.addSubview(bannerView)
        tableHeaderView.addSubview(mailLabelDetailsView)
        tableHeaderView.addSubview(fengeView)
        tableHeaderView.addSubview(mailDetailsTextView)
        tableView.tableHeaderView = tableHeaderView
        tableView.tableFooterView = webView
        //        tableHeaderView.addSubview(webView)
        webView.navigationDelegate = self
        webView.backgroundColor = .clear
        //        let urlRequest = URLRequest(url: URL.init(string: "https://www.baidu.com")!)
        //加载请求
        //        webView.load(urlRequest)
        
        let bottomView_H = (80.0/375.0)*kScreenWidth
        let bottomView = UIView.init(frame: CGRect.init(x: 0, y:kScreenHeight  - kNavBarHeight - kLiuHaiH  - bottomView_H, width: kScreenWidth, height: bottomView_H))
        bottomView.backgroundColor = .white
        let bottomBtn = UIButton.init(frame: CGRect.init(x: 15.0, y:(bottomView_H - 70.0)/2, width:kScreenWidth - 30.0 , height: 50.0))
        bottomBtn.backgroundColor = themeBackgroundColor
        bottomBtn.setTitle("立即购买", for:.normal)
        bottomBtn.addTarget(self, action: #selector(guigeAction), for: .touchUpInside)
        bottomBtn.titleLabel?.font =  UIFont(name: "PingFang-SC-Medium", size: 18)
        bottomBtn.titleLabel?.textColor = .white
        bottomView.addSubview(bottomBtn)
        view.addSubview(bottomView)
        //        view.bringSubviewToFront(bottomView)
        
        getGoodsInfoByGoodsId()
    }
    func setgoodsId(_ agoodsId : String){
        goodsId = agoodsId
    }
    
    @objc func guigeAction(){
        
        if goodsInfoByGoodsIdModel == nil {
            MBProgressHUD.showText("数据异常，请刷新重试")
            return
        }
        
        let vc = SC_ConfirmOrderController.init()
        vc.setGoodsInfoByGoodsIdModel(self.goodsInfoByGoodsIdModel!, self.specListModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func getGoodsInfoByGoodsId(){

        NetworkManager<BaseModel>().requestModel(API.goodsGetGoodsInfoByGoodsId(aid: goodsId), completion: { (response) in
            if let dic = response?.dataDict{
                
                self.goodsInfoByGoodsIdModel = GoodsInfoByGoodsIdModel.init(fromDictionary: dic as! [String : Any])
                let description = dic["description"] as! String
                self.lodeWebViewContent(description)
                
                let sliderImage = dic["sliderImage"] as! String
                let array : Array = sliderImage.components(separatedBy: ",")
                self.bannerView.imagePaths = array
                
                let goodsName = dic["goodsName"] as! String
                let givePower = dic["givePower"] as! NSNumber
//                let price = dic["price"] as! String

                self.amailLabelDetailsView.goodsName.text =  goodsName
                self.amailLabelDetailsView.givePower.text = String(format: "%@", givePower) + " XPoc"

                self.amailLabelDetailsView.priceLabel.text =  String(self.goodsInfoByGoodsIdModel?.price ?? 0) + " USDT 起"
                
                
                let specList = dic["specList"] as! Array<NSDictionary>
//                self.SpecListArr.removeAll()

                for dic in specList{
//                    self.SpecListArr.append(SpecListModel.init(fromDictionary: dic as! [String : Any]))
                    self.specListModel = SpecListModel.init(fromDictionary: dic as! [String : Any])
                }
            }
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
            
        }
    }
    
    func lodeWebViewContent(_ content:String){
        let test =    String(format: "<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style type='text/css'>img{width:%fpx}</style>%@",kScreenWidth - 10.0,content)
        let basePath = Bundle.main.url(forResource: "/JJA", withExtension: nil)
        // 注：baseURL如果设置为nil的话，html中的css将失效
        webView.loadHTMLString(test, baseURL: basePath)
    }
    
    
}


extension SC_MallDetailController:WKNavigationDelegate{
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        
        
    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        webView.evaluateJavaScript("document.body.scrollHeight") { (result, error) in
            print(CGFloat(result as! Float))
            self.tableView.tableFooterView?.height = CGFloat(result as! Float) + kNavBarHeight
            self.tableView.reloadData()
        }
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        
        
    }
    
    
    
}
