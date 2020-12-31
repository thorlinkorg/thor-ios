//
//  SC_MallVCLayout.swift
//  ZhouSiOrePool
//
//  Created by odin on 2020/9/27.
//  Copyright © 2020 odin. All rights reserved.
//

import UIKit

class SC_MallVCLayout: NSObject {
    static func layout(mallVC vc:SC_MallMainController){
        
        
        let collectionLayout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-kTabBarHeight), collectionViewLayout: collectionLayout)
         collectionView.register(UINib.init(nibName: "HomeBigCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HomeBigCollectionCell")
        collectionView.backgroundColor = .white
        collectionView.delegate = vc
        collectionView.dataSource = vc
        vc.collectionView = collectionView
        vc.view.addSubview(vc.collectionView)
    }
}
