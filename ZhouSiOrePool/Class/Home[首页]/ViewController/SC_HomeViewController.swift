//
//  SC_HomeViewController.swift
//  Cookies
//
//  Created by odin on 2020/9/21.
//

import UIKit
import LLCycleScrollView
import AVKit

class SC_HomeViewController: BaseViewController,HSCollectionViewProtocol{
    
    //首页轮播
    var slideshowList = Array<FeatureListModel>.init()
    //特色轮播
    var featureList =  Array<FeatureListModel>.init()
    //首页活动
    var homeActivityList = [HomeActivityModel]()
    
    var teSeList = [HomePriceModel]()
    
    var teVideoSeList = [SC_VideoListModel]()
    
    var slideshowListPath = Array<String>.init()
    
    var collectionView: UICollectionView!
    
    var homeActivityFlag : String = ""
    var homeActivityImg : String = ""
    
    let collArr = ["充币","提币","我的资产","邀请好友"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "ZEUS"
        self.view.backgroundColor = .white
        addRightNavImgItem("msg_icon")
        
        let collectionLayout = UICollectionViewFlowLayout.init()
        let rect = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-kTabBarHeight)
        collectionView = UICollectionView(frame: rect, collectionViewLayout: collectionLayout)
        
        collectionView.register(UINib.init(nibName: "BannerViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerViewCell")
        collectionView.register(UINib.init(nibName: "MineCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MineCollectionCell")
        collectionView.register(UINib.init(nibName: "SC_ActivitiesRewardCell", bundle: nil), forCellWithReuseIdentifier: "SC_ActivitiesRewardCell")
        collectionView.register(UINib.init(nibName: "SC_FunctionTipCell", bundle: nil), forCellWithReuseIdentifier: "SC_FunctionTipCell")
        collectionView.register(UINib.init(nibName: "SC_FunctionClassCell", bundle: nil), forCellWithReuseIdentifier: "SC_FunctionClassCell")
        collectionView.register(UINib.init(nibName: "SC_TextTipCell", bundle: nil), forCellWithReuseIdentifier: "SC_TextTipCell")
        collectionView.register(UINib.init(nibName: "SC_HomeInfoCell", bundle: nil), forCellWithReuseIdentifier: "SC_HomeInfoCell")
        collectionView.register(UINib.init(nibName: "SC_MarketInfoCell", bundle: nil), forCellWithReuseIdentifier: "SC_MarketInfoCell")
        
        self.view.addSubview(collectionView)
        collectionView.backgroundColor =  .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        addRefresh(refreshView: collectionView)
        setupMyEmptyView(tableView: collectionView)
    }
    
    override func sendNetRequest(){
        getHomeImg()
        getHomeVideo()
        getHomeActivityImg()
        getHomePrice()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        getHomePrice()
    }
    
    
    override func clickRightItem() {
        let messageListVC = UIStoryboard(name: "Main", bundle: nil).instantiateVC(SC_MessageListController.self)!
        navigationController?.pushViewController(messageListVC, animated: true)
    }
    
    func getHomeImg()  {
        NetworkManager<BaseModel>().requestModel(API.homeGetHomeImg, completion: { [self] (response) in
            
            if let dic = response?.dataArr{
                self.slideshowList.removeAll()
                self.slideshowListPath.removeAll()
                for item in dic{
                    let model = FeatureListModel.init(fromDictionary: item as! [String : Any])
                    self.slideshowListPath.append(model.imgUrl)
                    self.slideshowList.append(model)
                }
            }
            self.collectionView.reloadSections([0])
        }) { (error) in
            self.endRefresh(refreshView: self.collectionView)
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
    func getHomeVideo(){
        NetworkManager<BaseModel>().requestModel(API.getHomeVideo(page: String(curPage), pageSize: "4"), completion: { [self] (response) in
            
            if self.curPage == 1 {
                self.teVideoSeList.removeAll()
            }
            
            if let dic = response?.dataArr{
                for item in dic{
                    let model = SC_VideoListModel.init(fromDictionary: item as! [String : Any])
                    self.teVideoSeList.append(model)
                }
            }
            getHomeActivityImg()
            self.collectionView.reloadData()
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
    
    func getHomePrice(){
        NetworkManager<BaseModel>().requestModel(API.getHomePrice, completion: { (response) in
            self.endRefresh(refreshView: self.collectionView)
            if self.curPage == 1 {
                self.teSeList.removeAll()
            }
            
            if let list = response?.dataArr {
                for item in list{
                    let model = HomePriceModel.init(fromDictionary: item as! [String : Any])
                    self.teSeList.append(model)
                }
                self.curPage += 1
                self.mjFooterData(refreshView: self.collectionView, listCount: list.count)
            }
            
//            self.collectionView.reloadData()
            self.collectionView.reloadSections([6])
        }) { (error) in
            self.endRefresh(refreshView: self.collectionView)
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
    func getHomeActivityImg(){
        NetworkManager<BaseModel>().requestModel(API.getHomeActivityImg, completion: { [self] (response) in
            if let dic = response?.dataDict {

                let homeActivityFlag = dic["homeActivityFlag"] ?? ""
                self.homeActivityFlag = homeActivityFlag as! String

                let homeActivityImg = dic["homeActivityImg"] ?? ""
                self.homeActivityImg = homeActivityImg as! String
            }
            self.collectionView.reloadSections([2])
//            self.collectionView.reloadData()
        }) { (error) in
            self.endRefresh(refreshView: self.collectionView)
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
    
    
    func  didSelectItemAtImag(_ model:FeatureListModel)  {
        let vc = WebViewController.init()
        vc.loadType = .HTML
        vc.urlStr = model.url
        self.navigationController?.pushViewController(vc, animated: true)
    }
}










extension SC_HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return collArr.count
        }else if section == 2{
            return 1
        }else if section == 3{
            return self.teVideoSeList.count
        }else if section == 4 || section == 5 || section == 0 {     //|| section == 2
            return 1
        }else{
            return self.teSeList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell:BannerViewCell = cellWithCollectionView(collectionView, indexPath: indexPath)
            cell.bannerView.imagePaths = slideshowListPath
            cell.slideshowList = self.slideshowList
            cell.bannerFinish = {[weak self] model in
                if model.imgType == 1 {
                    let vc = SC_MallDetailController.init()
                    vc.setgoodsId(String(model.goodsId))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }else if model.imgType == 2{
                    let vc = WebViewController.init()
                    vc.loadType = .web
                    vc.urlStr = model.url
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
            return cell
        }else if indexPath.section == 1 {
            let cell:MineCollectionCell = cellWithCollectionView(collectionView, indexPath: indexPath)
            cell.backgroundColor = .clear
            cell.icon_img.image = UIImage.init(named: "mine_" + collArr[indexPath.row])
            cell.iconName.text = collArr[indexPath.row]
            return cell
//        }else if indexPath.section == 2{
//            let cell:SC_ActivitiesRewardCell = cellWithCollectionView(collectionView, indexPath: indexPath)
//            return cell
        }else if indexPath.section == 2{
            let cell:SC_FunctionTipCell = cellWithCollectionView(collectionView, indexPath: indexPath)
            
            switch self.homeActivityFlag {
            case "1":
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction(_:)))
                cell.hbBannerView.addGestureRecognizer(tap)
                cell.hdBannerImageView.kf.setImage(with: URL.init(string: self.homeActivityImg), placeholder: nil, options:[.forceRefresh])
                cell.hbBannerView.isHidden = false
            case "0":
                cell.hbBannerView.isHidden = true
            default:
                cell.hbBannerView.isHidden = true
            }
            return cell
        }else if indexPath.section == 3{
            let cell:SC_FunctionClassCell = cellWithCollectionView(collectionView, indexPath: indexPath)
            let model = self.teVideoSeList[indexPath.row]
            cell.storeImageView.kf.setImage(with: URL.init(string: model.poster!), placeholder: nil, options:[.forceRefresh])
            cell.titleLabel.text = String(model.title ??  "-")
            return cell
        }else if indexPath.section == 4{
            let cell:SC_TextTipCell = cellWithCollectionView(collectionView, indexPath: indexPath)
            return cell
        }else if indexPath.section == 5{
            let cell:SC_HomeInfoCell = cellWithCollectionView(collectionView, indexPath: indexPath)
            return cell
        }else{
            let cell:SC_MarketInfoCell = cellWithCollectionView(collectionView, indexPath: indexPath)
            cell.setModel(teSeList[indexPath.row])
            return cell
        }
    }
    
    @objc private func tapGestureRecognizerAction(_ sender: UITapGestureRecognizer) {
        let activitiesVC = UIStoryboard(name: "Main", bundle: nil).instantiateVC(SC_ActivitiesController.self)!
        navigationController?.pushViewController(activitiesVC, animated: true)
    }
    
    //    MARK: - item 点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let cell: MineCollectionCell = collectionView.cellForItem(at: indexPath) as! MineCollectionCell
            
            switch cell.iconName.text {
            case "充币":
                let chargeMoneyVC = UIStoryboard(name: "Main", bundle: nil).instantiateVC(SC_ChargeMoneyController.self)!
                chargeMoneyVC.type = 1
                navigationController?.pushViewController(chargeMoneyVC, animated: true)
            case "提币":
                let mentionMoneyVC = UIStoryboard(name: "Main", bundle: nil).instantiateVC(SC_MentionMoneyController.self)!
                navigationController?.pushViewController(mentionMoneyVC, animated: true)
            case "我的资产":
                let assetsVC = UIStoryboard(name: "Main", bundle: nil).instantiateVC(SC_AssetsController.self)!
                navigationController?.pushViewController(assetsVC, animated: true)
            default:
                let inviteFriendsVC = UIStoryboard(name: "Main", bundle: nil).instantiateVC(SC_InviteFriendsController.self)!
                navigationController?.pushViewController(inviteFriendsVC, animated: true)
            }
//        }else if indexPath.section == 2{
//            //活动奖励页
//            let activitiesVC = UIStoryboard(name: "Main", bundle: nil).instantiateVC(SC_ActivitiesController.self)!
//            navigationController?.pushViewController(activitiesVC, animated: true)
        }else if indexPath.section == 2{
            navigationController?.pushViewController(SC_VideoMoreController.init(), animated: true)
        }else if indexPath.section == 3{
            let model = self.teVideoSeList[indexPath.row]
            let videoUrl = String(model.videoUrl!)
            
            let player = AVPlayer(url: NSURL(string: videoUrl)! as URL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true, completion: nil)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: kScreenWidth, height:(170.0/kScreenWidth)*kScreenWidth)
        }else if indexPath.section == 1 {
            return CGSize(width: (kScreenWidth - 30.0)/4, height:(130/kScreenWidth)*(kScreenWidth - 30.0))
//        }else if indexPath.section == 2{
//            return CGSize(width: (kScreenWidth), height:(104/345)*kScreenWidth)
        }else if indexPath.section == 2{
            switch self.homeActivityFlag {
            case "0":
                return CGSize(width: (kScreenWidth), height:((60)/kScreenWidth)*kScreenWidth)
            case "1":
                return CGSize(width: (kScreenWidth), height:((60+120)/kScreenWidth)*kScreenWidth)
            default:
                return CGSize(width: (kScreenWidth), height:(60/kScreenWidth)*kScreenWidth)
            }
        }else if indexPath.section == 3{
            return CGSize(width: (kScreenWidth - 30.0)/2-7.5, height:(110/kScreenWidth)*(kScreenWidth - 30.0))
        }else if indexPath.section == 4{
            return CGSize(width: kScreenWidth, height:(50/kScreenWidth)*(kScreenWidth - 30.0))
        }else if indexPath.section == 5{
            return CGSize(width: kScreenWidth, height:(40/kScreenWidth)*(kScreenWidth - 30.0))
        }else{
            return CGSize(width: kScreenWidth, height:(65/kScreenWidth)*(kScreenWidth - 30.0))
        }
    }
    
    
    
    //     MARK: - 边框距离
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 3 {
            return  UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15)
        }else{
            return  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
    
    //    MARK: - 行最小间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5.0
    }
    
    //      MARK: - 列最小间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}








class SC_TextTipCell: UICollectionViewCell {

    
}

class SC_HomeInfoCell: UICollectionViewCell {


}

class SC_MarketInfoCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    
    

    func setModel(_ model : HomePriceModel){

        nameLabel.text = model.name
        priceLabel.text = "￥" + model.price.substring(from: 1).pointNumbe(length: 4)
        percentageLabel.text = model.rose
        if model.type == 0 {    //跌
            percentageLabel.backgroundColor =  UIColor.init(0xD34D4D)
        }else if(model.type == 1){  //涨
            percentageLabel.backgroundColor =   baseTabTextColor
        }
    }
}

class SC_ActivitiesRewardCell: UICollectionViewCell {
    
    
}

