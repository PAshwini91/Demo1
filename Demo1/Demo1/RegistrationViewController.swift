//
//  RegistrationViewController.swift
//  Demo1
//
//  Created by Ashwini Prabhavalkar on 14/07/22.
//

import UIKit
import CoreData

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var switchTermsConditions: UISwitch!
    @IBOutlet var signUp: UIButton!
    @IBOutlet var errorMessage: UITextView!
    
    var users: [NSManagedObject] = []
    let dataModel = persistentDataADC()
    var ErrorMessage = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Registration"
        
        firstName.delegate = self
        firstName.tag = 1
        firstName.returnKeyType = .next
        firstName.autocorrectionType = .no
        
        lastName.delegate = self
        lastName.tag = 2
        lastName.returnKeyType = .next
        lastName.autocorrectionType = .no
        
        email.delegate = self
        email.tag = 3
        email.returnKeyType = .next
        email.autocorrectionType = .no
        
        password.delegate = self
        password.tag = 4
        password.returnKeyType = .next
        password.autocorrectionType = .no
        
        confirmPassword.delegate = self
        confirmPassword.tag = 5
        confirmPassword.returnKeyType = .done
        confirmPassword.autocorrectionType = .no
        
        signUp.tintColor = UIColor(hexaRGB: "#2D69B1")
        signUp.isEnabled = false
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        backItem.tintColor = UIColor(hexaRGB: "#2D69B1")
        navigationItem.backBarButtonItem = backItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backButtonTitle = "Back"
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }

    @IBAction func switchTurnedOnOff(_ sender: UISwitch) {
        switchedOnOff()
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        onClick()
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
    func switchedOnOff() {
        let switchStatus = switchTermsConditions.isOn
        if switchStatus {
            print("On")
            signUp.isEnabled = true
        } else {
            print("Off")
            signUp.isEnabled = false
        }

    }
    
    func onClick() {
        errorMessage.text = ""
        
        guard let firstName = firstName?.text, firstName != "" else {
            errorMessage.text = "Please enter a name."
              return
          }

        guard let lastName = lastName?.text, lastName != "" else {
            errorMessage.text = "Please enter a last name."
              return
          }

        guard let email = email?.text, email != "" else {
            errorMessage.text = "Please enter an email address."
              return
          }

        guard let password = password?.text, password != "" else {
            errorMessage.text = "Please enter a password."
              return
          }

        guard let confirm_password = confirmPassword?.text, confirm_password != "" else {
            errorMessage.text = "Please confirm your password."
              return
          }
        
        if String().isNotValidEntry(firstName) {
            errorMessage.text = "Please enter a valid name. "
        }
        
        if String().isNotValidEntry(lastName) {
            errorMessage.text = errorMessage.text + "Please enter a valid last name. "
        }

        if !String().isValidEmail(email) {
            errorMessage.text = errorMessage.text + "Please enter a valid email address. "
        }

        if !password.elementsEqual(confirm_password) {
            errorMessage.text = errorMessage.text + "Passwords don't match."
        }

        if !errorMessage.hasText {
            let alert = UIAlertController(title: "", message: "Are you sure?" , preferredStyle: .alert)

            let yes = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
                self.save(fname: firstName, lname: lastName, email: email, password: password)
                self.switchTermsConditions.setOn(false, animated: false)
                print("YES button tapped")
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(yes)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    func save(fname: String, lname: String, email: String, password: String) {

        let person = dataModel.getEntityInstance(entityName: "Users")
        
        person.setValue(fname, forKeyPath: "firstName")
        person.setValue(lname, forKeyPath: "lastName")
        person.setValue(email, forKeyPath: "email")
        person.setValue(password, forKeyPath: "password")
        
        dataModel.addData(data: person)
        
        let successAlert = UIAlertController(title: "", message: "User added.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            
            self.navigationController?.pushViewController(UserListTableViewController(), animated: true)
        }
        successAlert.addAction(ok)
        
        self.present(successAlert, animated: true, completion: nil)
    }
    
}

extension UIColor {
    convenience init?(hexaRGB: String, alpha: CGFloat = 1) {
        var chars = Array(hexaRGB.hasPrefix("#") ? hexaRGB.dropFirst() : hexaRGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }
        case 6: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                alpha: alpha)
    }
}

extension String {
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

