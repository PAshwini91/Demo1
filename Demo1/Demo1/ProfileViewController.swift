//
//  ProfileViewController.swift
//  Demo1
//
//  Created by Ashwini Prabhavalkar on 22/06/22.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate, OnClickDelegate {
    var profile = Profile(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if UIDevice.current.orientation.isLandscape {
//            profile.sv_profile.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        } else {
//            profile.sv_profile.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 900)
//        }
        
        profile.txt_firstName.delegate = self
        profile.txt_firstName.tag = 1
        profile.txt_firstName.returnKeyType = .next
        
        profile.txt_lastName.delegate = self
        profile.txt_lastName.tag = 2
        profile.txt_lastName.returnKeyType = .next
        
        profile.txt_companyName.delegate = self
        profile.txt_companyName.tag = 3
        profile.txt_companyName.returnKeyType = .next
        
        profile.txt_mobileNumber.delegate = self
        profile.txt_mobileNumber.tag = 4
        profile.txt_mobileNumber.returnKeyType = .next
        
        profile.txt_address.delegate = self
        profile.txt_address.tag = 5
        profile.txt_address.returnKeyType = .next
        
        profile.txt_addressSec.delegate = self
        profile.txt_addressSec.tag = 6
        profile.txt_addressSec.returnKeyType = .next
        
        profile.txt_city.delegate = self
        profile.txt_city.tag = 7
        profile.txt_city.returnKeyType = .next
        
        profile.txt_state.delegate = self
        profile.txt_state.tag = 8
        profile.txt_state.returnKeyType = .next
        
        profile.txt_zipcode.delegate = self
        profile.txt_zipcode.tag = 9
        profile.txt_zipcode.returnKeyType = .next
        
        profile.txt_country.delegate = self
        profile.txt_country.tag = 10
        profile.txt_country.returnKeyType = .done
        
        profile.btn_resetPassword.tintColor = UIColor(hexaRGB: "#2D69B1")
        profile.btn_logOut.tintColor = UIColor(hexaRGB: "#2D69B1")
        profile.btn_deleteAccount.tintColor = UIColor(hexaRGB: "#2D69B1")
        
        view.addSubview(profile)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        profile.lbl_firstName.sizeToFit()
//        profile.lbl_lastName.sizeToFit()
//        profile.lbl_companyName.sizeToFit()
//        profile.lbl_mobileNumber.sizeToFit()
//        profile.lbl_address.sizeToFit()
//        profile.lbl_addressSec.sizeToFit()
//        profile.lbl_state.sizeToFit()
//        profile.lbl_city.sizeToFit()
//        profile.lbl_zipcode.sizeToFit()
//        profile.lbl_country.sizeToFit()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Check if there is any other text-field in the view whose tag is +1 greater than the current text-field on which the return key was pressed. If yes → then move the cursor to that next text-field. If No → Dismiss the keyboard
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
    
    func onClick() {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = Storyboard.instantiateViewController(withIdentifier: "Main") as! ViewController
        self.present(homeVC, animated: true)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profile.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }

}
