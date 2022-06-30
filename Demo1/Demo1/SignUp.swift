//
//  SignUp.swift
//  Demo1
//
//  Created by Ashwini Prabhavalkar on 21/06/22.
//

import UIKit

class SignUp: UIView {
    
    @IBOutlet var txt_firstName: UITextField!
    @IBOutlet var txt_lastName: UITextField!
    @IBOutlet var txt_email: UITextField!
    @IBOutlet var txt_password: UITextField!
    @IBOutlet var txt_confirmPassword: UITextField!
    @IBOutlet var lbl_termsConditions: UILabel!
    @IBOutlet var btn_signUp: UIButton!
    
    var switchStatus = Bool()
    
    @IBAction func didTurnOnOrOff(_ sender: UISwitch) {
        switchStatus = sender.isOn
        if switchStatus {
            print("On")
        } else {
            print("Off")
        }
    }
    
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
        let viewFromXIB = Bundle.main.loadNibNamed("SignUp", owner: self, options: nil)![0] as! UIView
        viewFromXIB.frame = self.bounds
        addSubview(viewFromXIB)
    }

}
