//
//  ProfileViewController.swift
//  Demo1
//
//  Created by Ashwini Prabhavalkar on 22/06/22.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, UITextFieldDelegate, OnClickDelegate {
    
    var profile = Profile(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    var users: [NSManagedObject] = []
    var person = NSManagedObject()
    let selectedUserPosition = UserDefaults.standard.integer(forKey: "selectedPosition")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        profile.txt_firstName.delegate = self
        profile.txt_firstName.tag = 1
        profile.txt_firstName.returnKeyType = .next
        profile.txt_firstName.autocorrectionType = .no
        
        profile.txt_lastName.delegate = self
        profile.txt_lastName.tag = 2
        profile.txt_lastName.returnKeyType = .next
        profile.txt_lastName.autocorrectionType = .no
        
        profile.txt_companyName.delegate = self
        profile.txt_companyName.tag = 3
        profile.txt_companyName.returnKeyType = .next
        profile.txt_companyName.autocorrectionType = .no
        
        profile.txt_mobileNumber.delegate = self
        profile.txt_mobileNumber.tag = 4
        profile.txt_mobileNumber.returnKeyType = .next
        profile.txt_mobileNumber.autocorrectionType = .no
        
        profile.txt_address.delegate = self
        profile.txt_address.tag = 5
        profile.txt_address.returnKeyType = .next
        profile.txt_address.autocorrectionType = .no
        
        profile.txt_addressSec.delegate = self
        profile.txt_addressSec.tag = 6
        profile.txt_addressSec.returnKeyType = .next
        profile.txt_addressSec.autocorrectionType = .no
        
        profile.txt_state.delegate = self
        profile.txt_state.tag = 7
        profile.txt_state.returnKeyType = .next
        profile.txt_state.autocorrectionType = .no
        
        profile.txt_city.delegate = self
        profile.txt_city.tag = 8
        profile.txt_city.returnKeyType = .next
        profile.txt_city.autocorrectionType = .no
        
        profile.txt_zipcode.delegate = self
        profile.txt_zipcode.tag = 9
        profile.txt_zipcode.returnKeyType = .next
        profile.txt_zipcode.autocorrectionType = .no
        
        profile.txt_country.delegate = self
        profile.txt_country.tag = 10
        profile.txt_country.returnKeyType = .done
        profile.txt_country.autocorrectionType = .no
        
        view.addSubview(profile)
        
        navigationItem.title = "Profile"
        let settingsItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(settingsButtonTapped(_:)))
        navigationItem.rightBarButtonItem = settingsItem
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: "gear")
        navigationItem.rightBarButtonItem?.tintColor = UIColor(hexaRGB: "#2D69B1")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profile.onClickDelegate = self
        
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
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
        do {
            users = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        person = users[selectedUserPosition]
        
        profile.txt_firstName.text = person.value(forKey: "firstName") as? String
        profile.txt_lastName.text = person.value(forKey: "lastName") as? String
        profile.txt_companyName.text = person.value(forKey: "comapnyName") as? String
        profile.txt_mobileNumber.text = person.value(forKey: "mobileNumber") as? String
        profile.txt_address.text = person.value(forKey: "address") as? String
        profile.txt_addressSec.text = person.value(forKey: "addressSec") as? String
        profile.txt_state.text = person.value(forKey: "state") as? String
        profile.txt_city.text = person.value(forKey: "city") as? String
        profile.txt_zipcode.text = person.value(forKey: "zipcode") as? String
        profile.txt_country.text = person.value(forKey: "country") as? String
        
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
        
        profile.lbl_errorMessage.text = ""
        
        guard let firstName = profile.txt_firstName?.text, firstName != "" else {
            profile.lbl_errorMessage.text = "Please enter a name."
            return
        }
        
        guard let lastName = profile.txt_lastName?.text, lastName != "" else {
            profile.lbl_errorMessage.text = "Please enter a last name."
            return
        }
        guard let company = profile.txt_companyName?.text, company != "" else {
            profile.lbl_errorMessage.text = "Please enter company name."
            return
        }
        
        guard let mobile = profile.txt_lastName?.text, mobile != "" else {
            profile.lbl_errorMessage.text = "Please enter a mobile number."
            return
        }
        guard let address = profile.txt_address?.text, address != "" else {
            profile.lbl_errorMessage.text = "Please enter an address."
            return
        }
        
        guard let addressSec = profile.txt_addressSec?.text, addressSec != "" else {
            profile.lbl_errorMessage.text = "Please enter a second address."
            return
        }
        guard let state = profile.txt_state?.text, state != "" else {
            profile.lbl_errorMessage.text = "Please mention a state."
            return
        }
        
        guard let city = profile.txt_city?.text, city != "" else {
            profile.lbl_errorMessage.text = "Please mention a city."
            return
        }
        guard let zipcode = profile.txt_zipcode?.text, zipcode != "" else {
            profile.lbl_errorMessage.text = "Please mention a zipcode."
            return
        }
        
        guard let country = profile.txt_country?.text, country != "" else {
            profile.lbl_errorMessage.text = "Please mention a country."
            return
        }
        
        if !isValidMobileNumber(mobile) {
            profile.lbl_errorMessage.text = "Please enter a valid mobile number. "
        }
        
        if !isValidZipcode(zipcode) {
            profile.lbl_errorMessage.text = profile.lbl_errorMessage.text! + "Please enter a valid zipcode. "
        }
        
        if profile.lbl_errorMessage.text == "" {
            let confirmationAlert = UIAlertController(title: "Confirmation", message: "Are you sure you want to update details?" , preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                print("OK button tapped")
                self.saveChanges()
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                print("Cancel button tapped")
            }
            
            confirmationAlert.addAction(ok)
            confirmationAlert.addAction(cancel)
            
            self.present(confirmationAlert, animated: true, completion: nil)
        }
        
        //        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let homeVC = Storyboard.instantiateViewController(withIdentifier: "Main") as! ViewController
        //        self.present(homeVC, animated: true)
    }
    
    @objc func settingsButtonTapped(_ sender: UIBarButtonItem) {
        let dialogMessage = UIAlertController(title: "Account Settings", message: "" , preferredStyle: .actionSheet)
        
        let resetPassword = UIAlertAction(title: "Reset Password", style: .default) { (action) -> Void in
            print("Reset Password button tapped")
            
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            backItem.tintColor = UIColor(hexaRGB: "#2D69B1")
            self.navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(ResetPasswordViewController(), animated: true)
        }
        
        let logOut = UIAlertAction(title: "Logout", style: .default) { (action) -> Void in
            print("Logout button tapped")
            self.navigationController?.popToRootViewController(animated: false)
        }
        
        let delete = UIAlertAction(title: "Delete Account", style: .destructive) { (action) -> Void in
            print("Delete Account button tapped")
            let alert = UIAlertController(title: "", message: "Are you sure?", preferredStyle: .alert)
            
            let yes = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
                
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
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
                do {
                    self.users = try managedContext.fetch(fetchRequest)
                    managedContext.delete(self.users[self.selectedUserPosition] as NSManagedObject)
                    self.users.remove(at: self.selectedUserPosition)
                    try managedContext.save()
                    self.navigationController?.popViewController(animated: true)
                } catch let error as NSError {
                    print("Could not save changes. \(error), \(error.userInfo)")
                }
                
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            alert.addAction(yes)
            alert.addAction(cancel)
            
            self.present(alert, animated: true, completion: nil)
            
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
    
    func saveChanges() {
        
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
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
        do {
            users = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        self.person = users[selectedUserPosition]
        
        let firstName = self.profile.txt_firstName.text
        let lastName = self.profile.txt_lastName.text
        let company = self.profile.txt_companyName.text
        let mobile = self.profile.txt_mobileNumber.text
        let address = self.profile.txt_address.text
        let addressSec = self.profile.txt_addressSec.text
        let state = self.profile.txt_state.text
        let city = self.profile.txt_city.text
        let zipcode = self.profile.txt_zipcode.text
        let country = self.profile.txt_country.text
        
        self.person.setValue(firstName, forKey: "firstName")
        self.person.setValue(lastName, forKey: "lastName")
        self.person.setValue(company, forKey: "comapnyName")
        self.person.setValue(mobile, forKey: "mobileNumber")
        self.person.setValue(address, forKey: "address")
        self.person.setValue(addressSec, forKey: "addressSec")
        self.person.setValue(state, forKey: "state")
        self.person.setValue(city, forKey: "city")
        self.person.setValue(zipcode, forKey: "zipcode")
        self.person.setValue(country, forKey: "country")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func isValidMobileNumber(_ mobileNumber: String) -> Bool {
        let regEx = "^\\+(?:[0-9]?){6,14}[0-9]$"
        
        let mobileNumberCheck = NSPredicate(format: "SELF MATCHES[c] %@", regEx)
        return mobileNumberCheck.evaluate(with: mobileNumber)
    }
    
    func isValidZipcode(_ zipcode: String) -> Bool {
        let regEx = "^[0-9]{6}$" // for Indian postal codes
        
        let mobileNumberCheck = NSPredicate(format: "SELF MATCHES[c] %@", regEx)
        return mobileNumberCheck.evaluate(with: zipcode)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profile.frame = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width, height: self.view.bounds.height)
    }
    
}
