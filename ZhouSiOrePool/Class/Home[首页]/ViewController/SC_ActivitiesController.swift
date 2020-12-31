//
//  SC_ActivitiesController.swift
//  ZhouSiOrePool
//
//  Created by 郭健 on 2020/11/18.
//  Copyright © 2020 odin. All rights reserved.
//

import UIKit

class SC_ActivitiesController: BaseViewController ,HSTableViewProtocol{
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var buyNumLabel: UILabel!
    
    @IBOutlet weak var contributeNumLabel: UILabel!
    
    @IBOutlet weak var upStandardNumLabel: UILabel!
    
    var rewardThorTotalSeList = [SC_RewardThorTotalModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "奖励计划"
        rewardThorTotal()
        addRefresh(refreshView: tableView)
        setupMyEmptyView(tableView: tableView)
    }
    
    override func sendNetRequest(){
        rewardThor()
    }
    
    func rewardThorTotal(){
        NetworkManager<BaseModel>().requestModel(API.rewardThorTotal, completion: { (response) in
            if let dic = response?.dataDict {
                let buyNum = dic["buyNum"] as! NSNumber
                self.buyNumLabel.text = String(format: "%@", buyNum).pointNumbe(length: 2)
                
                let contributeNum = dic["contributeNum"] as! NSNumber
                self.contributeNumLabel.text = String(format: "%@", contributeNum).pointNumbe(length: 2)
                
                let upStandardNum = dic["upStandardNum"] as! NSNumber
                self.upStandardNumLabel.text = String(format: "%@", upStandardNum).pointNumbe(length: 2)
            }
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
    func rewardThor(){
        NetworkManager<BaseModel>().requestModel(API.rewardThor(page: String(curPage), pageSize: "20"), completion: { (response) in
            self.endRefresh(refreshView: self.tableView)
            if self.curPage == 1 {
                self.rewardThorTotalSeList.removeAll()
            }
            
            if let list = response?.dataArr {
                for item in list{
                    let model = SC_RewardThorTotalModel.init(fromDictionary: item as! [String : Any])
                    self.rewardThorTotalSeList.append(model)
                }
                self.curPage += 1
                self.mjFooterData(refreshView: self.tableView, listCount: list.count)
            }
            
            self.tableView.reloadData()
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavBackgroundColor(.clear)
        setNavTintColor(.white)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setNavBackgroundColor(.white)
        setNavTintColor(.black)
    }
}


extension SC_ActivitiesController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rewardThorTotalSeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SC_ActivitiesInfoCell = cellWithTableView(tableView)
        let model = self.rewardThorTotalSeList[indexPath.row]
        switch model.operateType {
        case "9":
            cell.operateTypeLabel.text = "购买奖励"
        case "10":
            cell.operateTypeLabel.text = "邀请奖励"
        default:
            cell.operateTypeLabel.text = "达标奖励"
        }
        
        
        cell.numLabel.text = String(format: "%@", model.num!.removeZerosFromEnd()) + " Thor"
        
        cell.timeLabel.text = model.createTime
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}


class SC_ActivitiesInfoCell: UITableViewCell {
    
    @IBOutlet weak var operateTypeLabel: UILabel!
    
    @IBOutlet weak var numLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
}



