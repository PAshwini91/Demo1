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
        
        view.addSubview(profile)
        
        let settingsItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(saveButtonTapped(_:)))
        navigationItem.rightBarButtonItem = settingsItem
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: "gear")
        navigationItem.rightBarButtonItem?.tintColor = UIColor(hexaRGB: "#2D69B1")
      
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @objc func saveButtonTapped(_ sender: UIBarButtonItem) {
        let dialogMessage = UIAlertController(title: "Account Settings", message: "" , preferredStyle: .actionSheet)
        
        let resetPassword = UIAlertAction(title: "Reset Password", style: .default) { (action) -> Void in
            print("Reset Password button tapped")
        }
        
        let logOut = UIAlertAction(title: "Logout", style: .default) { (action) -> Void in
            print("Logout button tapped")
        }
        
        let delete = UIAlertAction(title: "Delete Account", style: .destructive) { (action) -> Void in
            print("Delete Account button tapped")
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        dialogMessage.addAction(resetPassword)
        dialogMessage.addAction(logOut)
        dialogMessage.addAction(delete)
        dialogMessage.addAction(cancel)
        
        if let popoverController = dialogMessage.popoverPresentationController {
            popoverController.barButtonItem = navigationItem.rightBarButtonItem//to set the source of your alert
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
//            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
        }
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profile.frame = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width, height: self.view.bounds.height)
    }

}
