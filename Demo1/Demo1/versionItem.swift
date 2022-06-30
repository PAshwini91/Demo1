//
//  versionItem.swift
//  Demo1
//
//  Created by Ashwini Prabhavalkar on 17/06/22.
//

import UIKit

class versionItem: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet var tv_hyperLink: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}
