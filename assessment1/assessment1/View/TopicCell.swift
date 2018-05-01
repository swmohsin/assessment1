//
//  TopicCell.swift
//  assessment1
//
//  Created by Admin on 2018-04-30.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class TopicCell: UITableViewCell {

    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var imgView:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
