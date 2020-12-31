//
//  SC_MarketInfoCell.swift
//  ZhouSiOrePool
//
//  Created by odin on 2020/9/27.
//  Copyright © 2020 odin. All rights reserved.
//

import UIKit

class SC_MarketInfoCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var percentageLabel: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setModel(_ model : HomePriceModel){
        
        nameLabel.text = model.name
        priceLabel.text =  model.price
        percentageLabel.text = model.rose
        if model.type == 0 {    //跌
            percentageLabel.backgroundColor =  UIColor.init(0xD34D4D) 
        }else if(model.type == 1){  //涨
            percentageLabel.backgroundColor =   baseTabTextColor
        }
    }
    
    
    
}
