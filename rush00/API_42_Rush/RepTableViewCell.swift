//
//  RepTableViewCell.swift
//  API_42_Rush
//
//  Created by Quentin MOINAT on 1/14/18.
//  Copyright © 2018 Quentin MOINAT. All rights reserved.
//

import UIKit

class RepTableViewCell: UITableViewCell {

    @IBOutlet weak var repAuth: UILabel!
    @IBOutlet weak var repDate: UILabel!
    @IBOutlet weak var repText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
