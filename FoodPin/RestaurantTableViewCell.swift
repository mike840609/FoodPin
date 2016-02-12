//
//  RestaurantTableViewCell.swift
//  FoodPin
//
//  Created by 蔡鈞 on 2016/1/29.
//  Copyright © 2016年 mike840609. All rights reserved.

//此類別用來連接客製化 cell 用

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel :UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
