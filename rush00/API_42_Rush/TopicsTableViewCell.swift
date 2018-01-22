//
//  TopicsTableViewCell.swift
//  API_42_Rush
//
//  Created by Quentin MOINAT on 1/13/18.
//  Copyright © 2018 Quentin MOINAT. All rights reserved.
//

import UIKit

class TopicsTableViewCell: UITableViewCell {

    @IBOutlet weak var topicAuth: UILabel!
    @IBOutlet weak var topicDate: UILabel!
    @IBOutlet weak var topicName: UILabel!
    @IBOutlet weak var bt_edit: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
}
