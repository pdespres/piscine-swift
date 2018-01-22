//
//  twitTableViewCell.swift
//  d04
//
//  Created by Paul DESPRES on 1/13/18.
//  Copyright © 2018 Paul Despres. All rights reserved.
//

import UIKit

class twitTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var desc: UILabel!
}
