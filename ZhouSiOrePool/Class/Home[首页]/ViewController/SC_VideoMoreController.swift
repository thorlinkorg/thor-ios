//
//  SC_VideoMoreController.swift
//  ZhouSiOrePool
//
//  Created by odin on 2020/10/28.
//  Copyright © 2020 odin. All rights reserved.
//

import UIKit
import AVKit

class SC_VideoMoreController: BaseViewController ,HSCollectionViewProtocol{
    
    var collectionView: UICollectionView!
    
    var teVideoSeList = [SC_VideoListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "宙斯矿场视频"
        self.view.backgroundColor = .white
        
        let collectionLayout = UICollectionViewFlowLayout.init()
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-kTabBarHeight), collectionViewLayout: collectionLayout)
        self.collectionView.register(UINib.init(nibName: "SC_FunctionClassCell", bundle: nil), forCellWithReuseIdentifier: "SC_FunctionClassCell")
        self.collectionView.backgroundColor = .white
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.view.addSubview(self.collectionView)
        
        addRefresh(refreshView: self.collectionView)
        setupMyEmptyView(tableView: self.collectionView)
    }
    
    override func sendNetRequest(){
        getHomeVideo()
    }
    
    func getHomeVideo(){
        NetworkManager<BaseModel>().requestModel(API.getHomeVideo(page: String(curPage), pageSize: "20"), completion: { (response) in
            self.endRefresh(refreshView: self.collectionView)
            if self.curPage == 1 {
                self.teVideoSeList.removeAll()
            }
            
            if let list = response?.dataArr {
                for item in list{
                    let model = SC_VideoListModel.init(fromDictionary: item as! [String : Any])
                    self.teVideoSeList.append(model)
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



extension SC_VideoMoreController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.teVideoSeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:SC_FunctionClassCell = cellWithCollectionView(collectionView, indexPath: indexPath)
        let model = self.teVideoSeList[indexPath.row]
        cell.storeImageView.kf.setImage(with: URL.init(string: model.poster!), placeholder: nil, options:[.forceRefresh])
        cell.titleLabel.text = String(model.title ??  "-")
        return cell
    }
    
    //    MARK: - item 点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.teVideoSeList[indexPath.row]
        let videoUrl = String(model.videoUrl!)
        
        let player = AVPlayer(url: NSURL(string: videoUrl)! as URL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (kScreenWidth - 30.0)/2-7.5, height:(110/345)*(kScreenWidth - 30.0))
        
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
