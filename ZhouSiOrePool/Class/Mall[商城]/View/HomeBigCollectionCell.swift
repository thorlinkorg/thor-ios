//
//  HomeBigCollectionCell.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/20.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class HomeBigCollectionCell: UICollectionViewCell {
    @IBOutlet weak var shangpinImage: UIImageView!
    @IBOutlet weak var suanliLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var goodsNameLabel: UILabel!
    
    
    
    func setModel(_ model : TeSeModel){
        goodsNameLabel.text = model.goodsName
        shangpinImage.kf.setImage(with: URL.init(string: model.image), placeholder: UIImage(named: "store_img"), options:[.forceRefresh])
//        suanliLabel.text = String(format: "%d",model.givePower)  + " XPoc"
        
        //计算行高
        let attributedString = NSMutableAttributedString(string: model.attributeStr!)
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 10 // Whatever line spacing you want in points
        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        suanliLabel.attributedText = attributedString
        bottomLabel.text =  String(model.price) + " USDT 起"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
