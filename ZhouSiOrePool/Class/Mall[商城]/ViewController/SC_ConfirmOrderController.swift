//
//  SC_ConfirmOrderController.swift
//  ZhouSiOrePool
//
//  Created by odin on 2020/9/28.
//  Copyright © 2020 odin. All rights reserved.
//

import UIKit


class SC_ConfirmOrderController: BaseViewController,HSTableViewProtocol {
    let hView = UIView.init()

    var specModel : SpecListModel!
    var tableView : UITableView!
    var goodsInfoByGoodsIdModel : GoodsInfoByGoodsIdModel!
    var availableOdin :NSNumber!
    var availableBgc :NSNumber!
    var selectRow  = 2
    var payNum = Int()
    
    
    var  availableUsdt = Double()
    
    var confirmOrderBottomView : ConfirmOrderBottomView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "确认订单"
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        tableView = tableViewConfig(CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - NaviBar_Height - kTabBarHeight + 10 ), self, self, .plain)
        tableView.sectionHeaderHeight = 0.01
        tableView.sectionFooterHeight = 0.01
        tableView.backgroundColor = .clear
        
        registerNibCell(tableView, ConfirmOrderXinXiCell.self)
        
        walletBalance()
        view.addSubview(tableView)
        tableView.reloadData()
        
        
        let bottomView_H = (80.0/375.0)*kScreenWidth
        let bottomView = UIView.init(frame: CGRect.init(x: 0, y:kScreenHeight  - kNavBarHeight - kLiuHaiH  - bottomView_H, width: kScreenWidth, height: bottomView_H))
        bottomView.backgroundColor = .white
        let bottomBtn = UIButton.init(frame: CGRect.init(x: 15.0, y:(bottomView_H - 70.0)/2, width:kScreenWidth - 30.0 , height: 50.0))
        bottomBtn.backgroundColor = themeBackgroundColor
        bottomBtn.setTitle("去付款", for:.normal)
        bottomBtn.addTarget(self, action: #selector(payButtonAction(_:)), for: .touchUpInside)
        bottomBtn.titleLabel?.font =  UIFont(name: "PingFang-SC-Medium", size: 18)
        bottomBtn.titleLabel?.textColor = .white
        bottomView.addSubview(bottomBtn)
        view.addSubview(bottomView)
        
//        let buttonGZ = UIButton.init(frame: CGRect.init(x: 15, y: kScreenHeight-kTabBarHeight - kNavBarHeight - kLiuHaiH - 25, width: kScreenWidth - 30, height: 50))
//        buttonGZ.backgroundColor = baseTabTextColor
//        buttonGZ.setTitle("去付款", for: UIControl.State.normal)
//        buttonGZ.addTarget(self, action: #selector(payButtonAction(_:)), for: .touchUpInside)
//        view.addSubview(buttonGZ)
        
        
    }
    
    
    func setGoodsInfoByGoodsIdModel(_ goodsInfoByGoodsIdModells : GoodsInfoByGoodsIdModel,_ specModells: SpecListModel){
        goodsInfoByGoodsIdModel = goodsInfoByGoodsIdModells
        specModel = specModells
    }
    
    
    
    //    去付款
    @objc func payButtonAction(_ sender:Any){
        
        if self.payNum <= 0 {
            self.payNum = 1
        }
        
        NetworkManager<BaseModel>().requestModel(API.orderSubmit(goodsId: String(goodsInfoByGoodsIdModel.goodsId), storeId: String(goodsInfoByGoodsIdModel.storeId), specId: String(specModel.specId), totalNum: String(self.payNum), payType: String(selectRow), remark: ""), completion: { (response) in
            
            if let dic = response?.dataDict{
                let orderId = dic["orderId"] as!NSNumber
                self.pushPassword(String(format: "%@", orderId))
            }
            
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
//    func updatePayNum(){
//        if selectRow == 0 {
//            let  ODIN =  String(format: "%.2lf ODIN",  Double(self.specModel.odinPrice)  * Double(specModel.payNum))
//            self.confirmOrderBottomView.numLabel.text = ODIN
//        }else{
//            let  BGC = String(format: "%.2lf BGC",  Double(self.specModel.shopPrice) * Double(specModel.payNum))
//            self.confirmOrderBottomView.numLabel.text = BGC
//        }
//    }
    
    
    
    func walletBalance()  {
        NetworkManager<BaseModel>().requestModel(API.userWalletBalance, completion: { (response) in
                if let dict = response?.dataDict {
                    self.availableUsdt = dict["availableUsdt"] as! Double
                    self.tableView.reloadData()
                }
            }) { (error) in
                if let msg = error.message {
                    MBProgressHUD.showText(msg)
                }
            }
    }
    
    func pushPassword(_ orderId:String){
        
        let vc = SC_PayPassWordCView.init()
        vc.orderId = orderId
        vc.view.backgroundColor = vcBoxBlack
        vc.modalPresentationStyle = .overCurrentContext;
        vc.modalTransitionStyle = .crossDissolve;
        keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
        vc.inputFinish = {[weak self] d in
            self?.orderPay(d,orderId)
        }
    }
    
    
    
    func orderPay(_ password:String,_ orderId:String){
        NetworkManager<BaseModel>().requestModel(API.orderPay(insidePayPassword: password, orderId: orderId), completion: { (response) in
            MBProgressHUD.showText("订单已提交")
            if let data = response?.dataDict{
                let orderDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateVC(SC_OrderDetailController.self)!
                orderDetailVC.model = MyOrderListModel.init(fromDictionary: data as! [String : Any])
                self.navigationController?.pushViewController(orderDetailVC, animated: true)
            }
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
}

extension SC_ConfirmOrderController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ConfirmOrderXinXiCell = cellWithTableView(tableView)
        cell.balanceLabel.text = "(您账户当前可用：" + String.init(format: "%.2lf",self.availableUsdt) + " USDT)"
        if goodsInfoByGoodsIdModel != nil {
            cell.setaGoodsInfoByGoodsIdModel(goodsInfoByGoodsIdModel)
        }
        
        cell.block = {[weak self] (objc: Any) -> Void in
            self?.payNum = objc as! Int
            //            self!.updatePayNum()
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return hView
    }
    
}


