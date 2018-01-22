//
//  DTableViewCell.swift
//  d02
//
//  Created by Paul DESPRES on 1/10/18.
//  Copyright © 2018 Paul Despres. All rights reserved.
//

import UIKit

class DTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var lab_date: UILabel!
    
    @IBOutlet weak var lab_name: UILabel!
    
    @IBOutlet weak var lab_desc: UILabel!
    
    var death : (String, String, String)? {
        didSet {
            if let d = death {
                lab_date?.text = d.2
                lab_name?.text = d.0
                lab_desc?.text = d.1
            }
        }
    }
}
