//
//  CustomCell.swift
//  AutoSizedTable
//
//  Created by Xiangjian Meng on 14-8-15.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
