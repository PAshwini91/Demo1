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
    
    override func viewWillAppear(_ animated: Bool) {
        
        signUp.txt_firstName.delegate = self
        signUp.txt_firstName.tag = 1
        signUp.txt_firstName.returnKeyType = .next
        
        signUp.txt_lastName.delegate = self
        signUp.txt_lastName.tag = 2
        signUp.txt_lastName.returnKeyType = .next
        
        signUp.txt_email.delegate = self
        signUp.txt_email.tag = 3
        signUp.txt_email.returnKeyType = .next
        
        signUp.txt_password.delegate = self
        signUp.txt_password.tag = 4
        signUp.txt_password.returnKeyType = .next
        
        signUp.txt_confirmPassword.delegate = self
        signUp.txt_confirmPassword.tag = 5
        signUp.txt_confirmPassword.returnKeyType = .done
        
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
        
//        guard let firstName = signUp.txt_firstName?.text else {
//              return
//          }
        
//        guard let lastName = signUp.txt_lastName?.text else {
//              return
//          }
        
//        guard let email = signUp.txt_email?.text else {
//              return
//          }
        
//        guard let password = signUp.txt_password?.text else {
//              return
//          }
        
        signUp.sw_termsConditions.setOn(false, animated: true)
        
//        self.save(fname: firstName, lname: lastName, email: email, password: password)
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        backItem.tintColor = UIColor(hexaRGB: "#2D69B1")
        navigationItem.backBarButtonItem = backItem
        
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

      let entity =
        NSEntityDescription.entity(forEntityName: "Users",
                                   in: managedContext)!
      
      let person = NSManagedObject(entity: entity,
                                   insertInto: managedContext)

      person.setValue(fname, forKeyPath: "firstName")
        person.setValue(lname, forKeyPath: "lastName")
        person.setValue(email, forKeyPath: "email")
        person.setValue(password, forKeyPath: "password")
      
      do {
          try managedContext.save()
          users.append(person)
          print("User details saved")
          
//          signUp.sw_termsConditions.isOn = false
          
          let backItem = UIBarButtonItem()
          backItem.title = "Back"
          backItem.tintColor = UIColor(hexaRGB: "#2D69B1")
          navigationItem.backBarButtonItem = backItem
          
          let userListVC = UserListTableViewController()
          self.navigationController?.pushViewController(userListVC, animated: true)
          
      } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
      }
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

