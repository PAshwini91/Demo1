//
//  Profile.swift
//  Demo1
//
//  Created by Ashwini Prabhavalkar on 22/06/22.
//

import UIKit

@objc protocol OnClickDelegate {
    func onClick()
}

class Profile: UIView {
    
    @IBOutlet var lbl_firstName: UILabel!
    @IBOutlet var txt_firstName: UITextField!
    @IBOutlet var lbl_lastName: UILabel!
    @IBOutlet var txt_lastName: UITextField!
    @IBOutlet var lbl_companyName: UILabel!
    @IBOutlet var txt_companyName: UITextField!
    @IBOutlet var lbl_mobileNumber: UILabel!
    @IBOutlet var txt_mobileNumber: UITextField!
    @IBOutlet var lbl_address: UILabel!
    @IBOutlet var txt_address: UITextField!
    @IBOutlet var lbl_addressSec: UILabel!
    @IBOutlet var txt_addressSec: UITextField!
    @IBOutlet var lbl_city: UILabel!
    @IBOutlet var txt_city: UITextField!
    @IBOutlet var lbl_state: UILabel!
    @IBOutlet var txt_state: UITextField!
    @IBOutlet var lbl_zipcode: UILabel!
    @IBOutlet var txt_zipcode: UITextField!
    @IBOutlet var lbl_country: UILabel!
    @IBOutlet var txt_country: UITextField!
    @IBOutlet var btn_save: UIButton!
    @IBOutlet var lbl_errorMessage: UILabel!
    
    var onClickDelegate: OnClickDelegate?
    
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
        let viewFromXIB = Bundle.main.loadNibNamed("Profile", owner: self, options: nil)![0] as! UIView
        viewFromXIB.frame = self.bounds
        addSubview(viewFromXIB)
    }
   
    @IBAction func saveDetails(_ sender: UIButton) {
        onClickDelegate?.onClick()
    }
}
