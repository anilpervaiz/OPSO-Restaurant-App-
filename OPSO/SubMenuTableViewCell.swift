//
//  SubMenuTableViewCell.swift
//  OPSO
//
//  Created by Anil Pervaiz on 7/16/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import UIKit

class SubMenuTableViewCell: UITableViewCell {

    @IBOutlet var menuImage: UIImageView!
    @IBOutlet var menuDescription: UITextView!
    @IBOutlet var menuTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
