//
//  menuItem.swift
//  Demo1
//
//  Created by Ashwini Prabhavalkar on 17/06/22.
//

import UIKit

class menuItem: UITableViewCell {
    
    @IBOutlet var iv_icon: UIImageView!
    @IBOutlet var lbl_menuItem: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
