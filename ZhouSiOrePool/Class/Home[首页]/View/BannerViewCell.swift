//
//  BannerViewCell.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/20.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit
import LLCycleScrollView
class BannerViewCell: UICollectionViewCell, LLCycleScrollViewDelegate {
    
    @objc var bannerFinish: ((FeatureListModel ) -> Void)?

    var bannerView: LLCycleScrollView!
    //首页轮播
    var slideshowList = Array<FeatureListModel>.init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        bannerView = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect(x: 0 , y: 0, width: kScreenWidth, height: (kScreenWidth - 30.0) * (170.0/345.0)))
        bannerView.delegate = self
        bannerView.imageViewContentMode = .scaleToFill
        bannerView.pageControlBottom = 20
        bannerView.backgroundColor = .clear
        self.addSubview(bannerView)
        
        
    }
    
    func cycleScrollView(_ cycleScrollView: LLCycleScrollView, didSelectItemIndex index: NSInteger) {
        self.bannerFinish?(self.slideshowList[index])
    }

}
