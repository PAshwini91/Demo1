//
//  HomePage.swift
//  Demo1
//
//  Created by Ashwini Prabhavalkar on 16/06/22.
//

import UIKit

class HomePage: UIView {
    
    @IBOutlet var vw_menu: UIView!
    @IBOutlet var tbl_menu: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        let viewFromXIB = Bundle.main.loadNibNamed("HomePage", owner: self, options: nil)![0] as! UIView
        viewFromXIB.frame = self.bounds
        addSubview(viewFromXIB)
    }

}
