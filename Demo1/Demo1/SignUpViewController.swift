//
//  SignUpViewController.swift
//  Demo1
//
//  Created by Ashwini Prabhavalkar on 20/06/22.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController, UITextFieldDelegate, OnClickDelegate, OnOffDelegate {

    var signUp = SignUp(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    var users: [NSManagedObject] = []
    let dataModel = persistentDataADC()
    var errorMessage = ""
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationItem.title = "Registration"
        
        signUp.txt_firstName.delegate = self
        signUp.txt_firstName.tag = 1
        signUp.txt_firstName.returnKeyType = .next
        signUp.txt_firstName.autocorrectionType = .no
        
        signUp.txt_lastName.delegate = self
        signUp.txt_lastName.tag = 2
        signUp.txt_lastName.returnKeyType = .next
        signUp.txt_lastName.autocorrectionType = .no
        
        signUp.txt_email.delegate = self
        signUp.txt_email.tag = 3
        signUp.txt_email.returnKeyType = .next
        signUp.txt_email.autocorrectionType = .no
        
        signUp.txt_password.delegate = self
        signUp.txt_password.tag = 4
        signUp.txt_password.returnKeyType = .next
        signUp.txt_password.autocorrectionType = .no
        
        signUp.txt_confirmPassword.delegate = self
        signUp.txt_confirmPassword.tag = 5
        signUp.txt_confirmPassword.returnKeyType = .done
        signUp.txt_confirmPassword.autocorrectionType = .no
        
        signUp.btn_signUp.tintColor = UIColor(hexaRGB: "#2D69B1")
        signUp.btn_signUp.isEnabled = false
        
        signUp.onClickDelegate = self
        signUp.OnOffDelegate = self
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        backItem.tintColor = UIColor(hexaRGB: "#2D69B1")
        navigationItem.backBarButtonItem = backItem
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(signUp)
        
        self.navigationItem.backButtonTitle = "Back"
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
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
        let switchStatus = signUp.sw_termsConditions.isOn
        if switchStatus {
            print("On")
            signUp.btn_signUp.isEnabled = true
        } else {
            print("Off")
            signUp.btn_signUp.isEnabled = false
        }

    }
    
    func onClick() {
        signUp.tv_errorMsg.text = ""
        
        guard let firstName = signUp.txt_firstName?.text, firstName != "" else {
            signUp.tv_errorMsg.text = "Please enter a name."
              return
          }

        guard let lastName = signUp.txt_lastName?.text, lastName != "" else {
            signUp.tv_errorMsg.text = "Please enter a last name."
              return
          }

        guard let email = signUp.txt_email?.text, email != "" else {
            signUp.tv_errorMsg.text = "Please enter an email address."
              return
          }

        guard let password = signUp.txt_password?.text, password != "" else {
            signUp.tv_errorMsg.text = "Please enter a password."
              return
          }

        guard let confirm_password = signUp.txt_confirmPassword?.text, confirm_password != "" else {
            signUp.tv_errorMsg.text = "Please confirm your password."
              return
          }

        if !isValidEmail(email) {
            signUp.tv_errorMsg.text = "Please enter a valid email address. "
        }

        if !password.elementsEqual(confirm_password) {
            signUp.tv_errorMsg.text = signUp.tv_errorMsg.text + "Passwords don't match."
        }

        if !signUp.tv_errorMsg.hasText {
            let alert = UIAlertController(title: "", message: "Are you sure?" , preferredStyle: .alert)

            let yes = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
                self.save(fname: firstName, lname: lastName, email: email, password: password)
                self.signUp.sw_termsConditions.setOn(false, animated: false)
                print("YES button tapped")
            }
            alert.addAction(yes)
            self.present(alert, animated: true, completion: nil)
        }
      
//        self.navigationController?.pushViewController(UserListTableViewController(), animated: true)
    }
    
    func save(fname: String, lname: String, email: String, password: String) {
      
//      guard let appDelegate =
//        UIApplication.shared.delegate as? AppDelegate else {
//        return
//      }

//      let managedContext =
//        appDelegate.persistentContainer.viewContext

//        lazy var persistentContainer: NSPersistentContainer = {
//            let container = NSPersistentContainer(name: "DemoModel")
//            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//                if let error = error as NSError? {
//                    fatalError("Unresolved error \(error), \(error.userInfo)")
//                }
//            })
//            return container
//        }()
//
//      let managedContext = persistentContainer.viewContext
//
//      let entity = NSEntityDescription.entity(forEntityName: "Users", in: managedContext)!
      
        let person = dataModel.getEntityInstance(entityName: "Users")
        
        person.setValue(fname, forKeyPath: "firstName")
        person.setValue(lname, forKeyPath: "lastName")
        person.setValue(email, forKeyPath: "email")
        person.setValue(password, forKeyPath: "password")
        
        dataModel.addData(data: person)
        
        self.navigationController?.pushViewController(UserListTableViewController(), animated: true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        signUp.frame = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width, height: self.view.bounds.height)
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

