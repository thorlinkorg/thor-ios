//
//  SC_MessageListController.swift
//  ZhouSiOrePool
//
//  Created by odin on 2020/9/28.
//  Copyright © 2020 odin. All rights reserved.
//

import UIKit

class SC_MessageListController: BaseViewController ,HSTableViewProtocol{
    
    
    @IBOutlet weak var tableView: UITableView!
    var dataList = [SystemInformsModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "系统通知"
        self.view.backgroundColor = .white
        
        
        tableView.delegate = self
        tableView.dataSource = self
        addRefresh(refreshView: tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        registerNibCell(tableView, SystemInformsCell.self)
        
        setupMyEmptyView(tableView: tableView)
    }
    
    override func sendNetRequest() {
        
        NetworkManager<SystemInformsModel>().requestListModel( API.shopCommonGetInform(page: curPage, pageSize: 20), completion: { (response) in
            self.endRefresh(refreshView: self.tableView)
            if self.curPage == 1 {
                self.dataList.removeAll()
            }
            if let list = response?.list {
                self.dataList.append(contentsOf: list)
                self.curPage += 1
                self.mjFooterData(refreshView: self.tableView, listCount: list.count)
            }
            self.tableView.reloadData()
            self.hide_showEmptyView(self.tableView, self.dataList.count)
        }) { (error) in
            self.endRefresh(refreshView: self.tableView)
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
}

extension SC_MessageListController:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count 
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SystemInformsCell = cellWithTableView(tableView)
        
        let model = self.dataList[indexPath.row]
        cell.atitleLabel.text =  model.title
        //        cell.informValue.text = model.informValue
        cell.timeLabel.text = model.createTime
        do{
            let attrStr = try NSAttributedString(data: model.informValue.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            
            cell.informValue.attributedText = attrStr
        }catch let error as NSError {
            print(error.localizedDescription)
        }
        return cell
    }
}







class MessageInfoCell: UITableViewCell {
    
    
    @IBOutlet weak var atitleLabel: UILabel!
    @IBOutlet weak var createTime: UILabel!
    @IBOutlet weak var informValue: UITextView!
}
