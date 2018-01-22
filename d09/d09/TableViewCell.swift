//
//  TableViewCell.swift
//  d09
//
//  Created by Paul DESPRES on 1/19/18.
//  Copyright © 2018 42. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var imageArt: UIImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var dateCreation: UILabel!
    @IBOutlet weak var dateMod: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
