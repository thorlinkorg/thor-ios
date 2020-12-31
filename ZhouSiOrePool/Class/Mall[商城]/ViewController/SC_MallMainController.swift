//
//  SC_MallMainController.swift
//  ZhouSiOrePool
//
//  Created by odin on 2020/9/24.
//  Copyright © 2020 odin. All rights reserved.
//

import UIKit

class SC_MallMainController: BaseViewController,HSCollectionViewProtocol{
    
    var collectionView: UICollectionView!
    
    var aindexSelect :Int!
    
    var teSeList = [TeSeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SC_MallVCLayout.layout(mallVC: self)
        addRefresh(refreshView: collectionView)
        setupMyEmptyView(tableView: collectionView)
        
        addRightNavImgItem("msg_icon")
    
    }
    
    override func clickRightItem() {
        let messageListVC = UIStoryboard(name: "Main", bundle: nil).instantiateVC(SC_MessageListController.self)!
        navigationController?.pushViewController(messageListVC, animated: true)
    }
    
    override func sendNetRequest(){
        goodsGetGoodsByOrderType()
    }
    
    func goodsGetGoodsByOrderType(){

        NetworkManager<TeSeModel>().requestModel(API.goodsGetGoodsByOrderType( page: String(curPage), pageSize: "20", orderType: "0"), completion: { (response) in
             self.endRefresh(refreshView: self.collectionView)
            if self.curPage == 1 {
               self.teSeList.removeAll()
            }
            
             if let list = response?.dataArr {
               for item in list{
                   let model = TeSeModel.init(fromDictionary: item as! [String : Any])
                   self.teSeList.append(model)
               }
                self.curPage += 1
                self.mjFooterData(refreshView: self.collectionView, listCount: list.count)
            }

            self.collectionView.reloadData()
        }) { (error) in
             self.endRefresh(refreshView: self.collectionView)
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
}


extension SC_MallMainController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.teSeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:HomeBigCollectionCell = cellWithCollectionView(collectionView, indexPath: indexPath)
        cell.backgroundColor = .white
        cell.setModel(teSeList[indexPath.row])
        return cell
    }
    
    //    MARK: - item 点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SC_MallDetailController.init()
        let model = teSeList[indexPath.row]
        vc.setgoodsId(String(model.goodsId))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ls_w =  kScreenWidth / 375.0
        let itemW = (kScreenWidth - 30.0)
        return CGSize(width: itemW, height: 195 * ls_w)
        
    }
    
    
    //     MARK: - 边框距离
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return  UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        
    }
    
    //    MARK: - 行最小间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14.0
    }
    
    //      MARK: - 列最小间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
