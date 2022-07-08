//
//  ResetPasswordViewController.swift
//  Demo1
//
//  Created by Ashwini Prabhavalkar on 07/07/22.
//

import UIKit
import CoreData

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var password: UITextField!
    @IBOutlet var newPassword: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var errorMessage: UITextView!
    @IBOutlet var resetPassword: UIButton!
    
    var users: [NSManagedObject] = []
    var person = NSManagedObject()
    let dataModel = persistentDataADC()
    let selectedUserPosition = UserDefaults.standard.integer(forKey: "selectedPosition")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Reset Password"
        
        password.tag = 1
        password.delegate = self
        password.returnKeyType = .next
        
        newPassword.tag = 2
        newPassword.delegate = self
        newPassword.returnKeyType = .next
        
        confirmPassword.tag = 3
        confirmPassword.delegate = self
        confirmPassword.returnKeyType = .done
        
        resetPassword.tintColor = UIColor(hexaRGB: "#2D69B1")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    @IBAction func resetPassword(_ sender: UIButton) {
        
        self.errorMessage.text = ""
        
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
//        let managedContext = persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
//        do {
//            users = try managedContext.fetch(fetchRequest)
//            person = users[selectedUserPosition]
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
        users = dataModel.fetchData(entityName: "Users")
        person = users[selectedUserPosition]
        
        guard let oldPassword = password.text, oldPassword != "" else {
            self.errorMessage.text = "Please enter your password."
            return
        }
        
        guard let newPassword = newPassword.text, newPassword != "" else {
            self.errorMessage.text = "Please enter a new password."
            return
        }
        
        guard let confirmPassword = confirmPassword.text, confirmPassword != "" else {
            self.errorMessage.text = "Please confirm your new password."
            return
        }
        
        let oldPass = person.value(forKey: "password") as! String
        if !(oldPass.elementsEqual(oldPassword)) {
            self.errorMessage.text = "\(oldPass) Invalid password. "
        }
        
        if oldPassword.elementsEqual(newPassword) {
            self.errorMessage.text = self.errorMessage.text + "Please enter a different password. "
        }
        
        if !newPassword.elementsEqual(confirmPassword) {
            self.errorMessage.text = self.errorMessage.text + "Doesn't match new password. "
        }
        
        if !self.errorMessage.hasText {
            
            let alert = UIAlertController(title: "", message: "Are you sure?", preferredStyle: .alert)
            
            let yes = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
                
                self.person.setValue(newPassword, forKey: "password")
                self.dataModel.updateData()
                
                self.password.text = ""
                self.newPassword.text = ""
                self.confirmPassword.text = ""
                
                let successAlert = UIAlertController(title: "", message: "Your password is reset successfully.", preferredStyle: .alert)
                
                let ok = UIAlertAction(title: "OK", style: .cancel) { (action) -> Void in
                    print("OK button tapped")
                }
                
                successAlert.addAction(ok)
                
                self.present(successAlert, animated: true, completion: nil)
                
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                print("Cancel button tapped")
            }
            
            alert.addAction(yes)
            alert.addAction(cancel)
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
