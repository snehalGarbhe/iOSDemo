//
//  ImageCell.swift
//  DemoiOSTask
//
//  Created by Snehal Garbhe on 2/23/19.
//  Copyright © 2019 Snehal Garbhe. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
