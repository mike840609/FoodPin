//
//  KivaLoanTableViewCell.swift
//  FoodPin
//
//  Created by 蔡鈞 on 2016/2/14.
//  Copyright © 2016年 mike840609. All rights reserved.
//

import UIKit

class KivaLoanTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var countryLabel:UILabel!
    @IBOutlet weak var useLabel:UILabel!
    @IBOutlet weak var amountLabel:UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
