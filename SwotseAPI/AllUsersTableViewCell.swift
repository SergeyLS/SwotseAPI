//
//  AllUsersTableViewCell.swift
//  SwotseAPI
//
//  Created by Sergey Leskov on 6/1/17.
//  Copyright © 2017 Sergey Leskov. All rights reserved.
//

import UIKit

class AllUsersTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameUI: UILabel!
    @IBOutlet weak var lastLogin: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
