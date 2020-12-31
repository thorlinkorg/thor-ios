//
//  HomeVCLayout.swift
//  ZhouSiOrePool
//
//  Created by odin on 2020/9/27.
//  Copyright © 2020 odin. All rights reserved.
//

import UIKit
import LLCycleScrollView


class HomeVCLayout: NSObject {
    static func layout(homeVC vc: SC_HomeViewController){
        let bgview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        bgview.backgroundColor = .white
        vc.view.addSubview(bgview)
        
        vc.view.addSubview(vc.tableView)
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth * (310/375.0) ))
        headerView.backgroundColor = vcBackLightGrayColor
        vc.tableView.tableHeaderView = headerView
        
        
        let topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: (170.0/375.0)*kScreenWidth))
        headerView.addSubview(topView)
        topView.backgroundColor = vcBackLightGrayColor
        
        let collbgView = UIView.init(frame: CGRect.init(x: 0, y:topView.bottom, width: kScreenWidth, height: (130/345)*(kScreenWidth - 30.0)))
        collbgView.backgroundColor = .white
        headerView.addSubview(collbgView)
        
        
        let collectionLayout = UICollectionViewFlowLayout.init()
        let rect = CGRect(x: 0, y: 0, width: collbgView.width, height: collbgView.height)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: collectionLayout)
        vc.collectionView = collectionView
        
        collectionView.register(UINib.init(nibName: "BannerViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerViewCell")
        collectionView.register(UINib.init(nibName: "MineCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MineCollectionCell")
        
        
        collbgView.addSubview(collectionView)
        collectionView.backgroundColor =  .clear
        collectionView.delegate = vc
        collectionView.dataSource = vc
        collectionView.tag = 10000
        
        //轮播图
        vc.bannerView = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect(x: 0 , y: 0, width: kScreenWidth, height: (kScreenWidth - 30.0) * (170.0/345.0)))
        vc.bannerView.delegate = vc
        vc.bannerView.imageViewContentMode = .scaleToFill
        vc.bannerView.pageControlBottom = 20
        vc.bannerView.backgroundColor = .clear
        topView.addSubview(vc.bannerView)
    }
    
}
