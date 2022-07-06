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
    var errorMessage = ""
    
    override func viewWillAppear(_ animated: Bool) {
        
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
        switch textField.tag {
        case 1:
            if !textField.hasText {
                signUp.tv_errorMsg.text = "Please enter a name."
            } else {
                signUp.tv_errorMsg.text = ""
                if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
                    nextField.becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                }
            }
        case 2:
            if !textField.hasText {
                signUp.tv_errorMsg.text = "Please enter a last name."
            } else {
                signUp.tv_errorMsg.text = ""
                if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
                    nextField.becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                }
            }
        case 3:
            if !textField.hasText {
                signUp.tv_errorMsg.text = "Please enter an email address."
            } else {
                if isValidEmail(textField.text!) {
                    signUp.tv_errorMsg.text = ""
                    if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
                        nextField.becomeFirstResponder()
                    } else {
                        textField.resignFirstResponder()
                    }
                } else {
                    signUp.tv_errorMsg.text = "Please enter a valid email address."
                }
            }
        case 4:
            if !textField.hasText {
                signUp.tv_errorMsg.text = "Please enter a password."
            } else {
                signUp.tv_errorMsg.text = ""
                if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
                    nextField.becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                }
            }
        case 5:
            if !textField.hasText {
                signUp.tv_errorMsg.text = "Please confirm password."
            } else {
                if textField.text != signUp.txt_password.text {
                    signUp.tv_errorMsg.text = "Passwords don't match."
                } else {
                    signUp.tv_errorMsg.text = ""
                    if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
                        nextField.becomeFirstResponder()
                    } else {
                        textField.resignFirstResponder()
                    }
                }
            }
        default:
            signUp.tv_errorMsg.text = ""
            if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
                nextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
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
        
//        guard let firstName = signUp.txt_firstName?.text, firstName != "" else {
//              return
//          }
//
//        guard let lastName = signUp.txt_lastName?.text, lastName != "" else {
//              return
//          }
//
//        guard let email = signUp.txt_email?.text, email != "" else {
//              return
//          }
//
//        guard let password = signUp.txt_password?.text, password != "" else {
//              return
//          }
//
//        guard let confirm_password = signUp.txt_confirmPassword?.text, confirm_password != "" else {
//              return
//          }
//
//        let alert = UIAlertController(title: "", message: "Are you sure?" , preferredStyle: .alert)
//
//        let yes = UIAlertAction(title: "YES", style: .default) { (action) -> Void in
//            self.save(fname: firstName, lname: lastName, email: email, password: password)
//            print("YES button tapped")
//        }
//        alert.addAction(yes)
//        self.present(alert, animated: true, completion: nil)
//
        signUp.sw_termsConditions.setOn(false, animated: false)
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        backItem.tintColor = UIColor(hexaRGB: "#2D69B1")
        navigationItem.backBarButtonItem = backItem
//
        let userListVC = UserListTableViewController()
        self.navigationController?.pushViewController(userListVC, animated: true)
    }
    
    func save(fname: String, lname: String, email: String, password: String) {
      
//      guard let appDelegate =
//        UIApplication.shared.delegate as? AppDelegate else {
//        return
//      }

//      let managedContext =
//        appDelegate.persistentContainer.viewContext

        lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "DemoModel")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
        
      let managedContext = persistentContainer.viewContext

      let entity = NSEntityDescription.entity(forEntityName: "Users", in: managedContext)!
      
      let person = NSManagedObject(entity: entity, insertInto: managedContext)

      person.setValue(fname, forKeyPath: "firstName")
        person.setValue(lname, forKeyPath: "lastName")
        person.setValue(email, forKeyPath: "email")
        person.setValue(password, forKeyPath: "password")
      
      do {
          try managedContext.save()
          users.append(person)
          print("User details saved")
          signUp.tv_errorMsg.text = ""
          
//          let backItem = UIBarButtonItem()
//          backItem.title = "Back"
//          backItem.tintColor = UIColor(hexaRGB: "#2D69B1")
//          navigationItem.backBarButtonItem = backItem
          
          let userListVC = UserListTableViewController()
          self.navigationController?.pushViewController(userListVC, animated: true)
          
      } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
      }
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

