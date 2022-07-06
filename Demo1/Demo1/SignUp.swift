//
//  SignUp.swift
//  Demo1
//
//  Created by Ashwini Prabhavalkar on 21/06/22.
//

import UIKit

@objc protocol OnOffDelegate {
    func switchedOnOff()
}

class SignUp: UIView {
    
    @IBOutlet var txt_firstName: UITextField!
    @IBOutlet var txt_lastName: UITextField!
    @IBOutlet var txt_email: UITextField!
    @IBOutlet var txt_password: UITextField!
    @IBOutlet var txt_confirmPassword: UITextField!
    @IBOutlet var sw_termsConditions: UISwitch!
    @IBOutlet var lbl_termsConditions: UILabel!
    @IBOutlet var btn_signUp: UIButton!
    @IBOutlet var tv_errorMsg: UITextView!
    
//    var switchStatus = Bool()
    var onClickDelegate: OnClickDelegate?
    var OnOffDelegate: OnOffDelegate?
    
    @IBAction func didTurnOnOrOff(_ sender: UISwitch) {
        OnOffDelegate?.switchedOnOff()
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        onClickDelegate?.onClick()
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
