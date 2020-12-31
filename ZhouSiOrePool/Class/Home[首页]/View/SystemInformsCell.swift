//
//  SystemInformsCell.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/30.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class SystemInformsCell: UITableViewCell {
    @IBOutlet weak var atitleLabel: UILabel!
    @IBOutlet weak var informValue: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
