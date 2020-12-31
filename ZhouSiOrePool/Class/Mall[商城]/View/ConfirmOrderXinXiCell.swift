//
//  ConfirmOrderXinXiCell.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/21.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class ConfirmOrderXinXiCell: UITableViewCell {

    @IBOutlet weak var goodsName: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var specName: UILabel!
    @IBOutlet weak var givePower: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var numF: UITextField!
    

    typealias funBlock = (_ objc:Any)->Void
    var block : funBlock?

    var specModel : GoodsInfoByGoodsIdModel!
    
    var number = Int()
    
    var price = Double()
    
    var suanli = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    @IBAction func jianButtonAction(_ sender: Any) {
         let myNumberInt = Int(numF.text!)
         var num : Int = myNumberInt! - 1
         
         if num <= 1{
             num = 1
         }

        number = num
        updatePriceAndNum()
     }
     
     @IBAction func jiaButtonAction(_ sender: Any) {
         let myNumberInt = Int(numF.text!)
         let num = myNumberInt! + 1
        
        number = num
        updatePriceAndNum()
     }
    func setaGoodsInfoByGoodsIdModel(_ goodsInfoByGoodsIdModel: GoodsInfoByGoodsIdModel){
        self.goodsName.text =  goodsInfoByGoodsIdModel.goodsName
        self.imageV.kf.setImage(with: URL.init(string: goodsInfoByGoodsIdModel.image), placeholder: UIImage(named: "store_img"), options: [.forceRefresh])
        self.specName.text = String(format: "%d",goodsInfoByGoodsIdModel.givePower)  + " XPoc"
        self.priceLabel.text = String(goodsInfoByGoodsIdModel.price ?? 0.0) + " USDT"
        self.totalPriceLabel.text =  String(goodsInfoByGoodsIdModel.price ?? 0.0)  + " USDT"
        price = goodsInfoByGoodsIdModel.price ?? 0.0
        suanli = goodsInfoByGoodsIdModel.givePower
        self.givePower.text = "+ " + String(format: "%d",goodsInfoByGoodsIdModel.givePower)  + " XPoc"
    }
    
    
    func updatePriceAndNum(){
        self.numF.text = String(number)
        self.givePower.text = "+ " + String(suanli * number) + " XPoc"
        self.totalPriceLabel.text = String(Double(number)*price).reviseString() + " USDT"
        if block != nil {
            self.block!(number)
        }
    }
    
    
}
