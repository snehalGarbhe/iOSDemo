//
//  TextCell.swift
//  DemoiOSTask
//
//  Created by Snehal Garbhe on 2/23/19.
//  Copyright © 2019 Snehal Garbhe. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {

    @IBOutlet weak var textLbl: UILabel!
    
    @IBOutlet weak var cardVW: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cardVW.layer.cornerRadius = 8
        cardVW.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
