//
//  UserProfileViewController.swift
//  Demo1
//
//  Created by Ashwini Prabhavalkar on 15/07/22.
//

import UIKit
import CoreData

class UserProfileViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastNameLabel: UILabel!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var companyNameLabel: UILabel!
    @IBOutlet var companyName: UITextField!
    @IBOutlet var mobileNumberLabel: UILabel!
    @IBOutlet var mobileNumber: UITextField!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var address: UITextField!
    @IBOutlet var addressSecLabel: UILabel!
    @IBOutlet var addressSec: UITextField!
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var state: UITextField!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var city: UITextField!
    @IBOutlet var zipcodeLabel: UILabel!
    @IBOutlet var zipcode: UITextField!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var country: UITextField!
    @IBOutlet var save: UIButton!
    @IBOutlet var errorMessageLabel: UILabel!
    
    var users: [NSManagedObject] = []
    var person = NSManagedObject()
    var selectedFromMenu = UserDefaults.standard.string(forKey: "selectedFromMenu")
    var selectedUserPosition = Int()
    let dataModel = persistentDataADC()
    var errorCounter = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if selectedFromMenu == "No" {
            selectedUserPosition = UserDefaults.standard.integer(forKey: "selectedPosition")
        }
        
        firstName.delegate = self
        firstName.tag = 1
        firstName.returnKeyType = .next
        firstName.autocorrectionType = .no
        
        lastName.delegate = self
        lastName.tag = 2
        lastName.returnKeyType = .next
        lastName.autocorrectionType = .no
        
        companyName.delegate = self
        companyName.tag = 3
        companyName.returnKeyType = .next
        companyName.autocorrectionType = .no
        
        mobileNumber.delegate = self
        mobileNumber.tag = 4
        mobileNumber.returnKeyType = .next
        mobileNumber.autocorrectionType = .no
        
        address.delegate = self
        address.tag = 5
        address.returnKeyType = .next
        address.autocorrectionType = .no
        
        addressSec.delegate = self
        addressSec.tag = 6
        addressSec.returnKeyType = .next
        addressSec.autocorrectionType = .no
        
        state.delegate = self
        state.tag = 7
        state.returnKeyType = .next
        state.autocorrectionType = .no
        
        city.delegate = self
        city.tag = 8
        city.returnKeyType = .next
        city.autocorrectionType = .no
        
        zipcode.delegate = self
        zipcode.tag = 9
        zipcode.returnKeyType = .next
        zipcode.autocorrectionType = .no
        
        country.delegate = self
        country.tag = 10
        country.returnKeyType = .done
        country.autocorrectionType = .no
        
        errorMessageLabel.isHidden = true
        
        navigationItem.title = "Profile"
        let settingsItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(settingsButtonTapped(_:)))
        navigationItem.rightBarButtonItem = settingsItem
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: "gear")
        navigationItem.rightBarButtonItem?.tintColor = UIColor(hexaRGB: "#2D69B1")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedFromMenu == "No" {
            users = dataModel.fetchData(entityName: "Users")
            person = users[selectedUserPosition]
            
            firstName.text = person.value(forKey: "firstName") as? String
            lastName.text = person.value(forKey: "lastName") as? String
            companyName.text = person.value(forKey: "comapnyName") as? String
            mobileNumber.text = person.value(forKey: "mobileNumber") as? String
            address.text = person.value(forKey: "address") as? String
            addressSec.text = person.value(forKey: "addressSec") as? String
            state.text = person.value(forKey: "state") as? String
            city.text = person.value(forKey: "city") as? String
            zipcode.text = person.value(forKey: "zipcode") as? String
            country.text = person.value(forKey: "country") as? String
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }

    @IBAction func save(_ sender: UIButton) {
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
    
    func onClick() {
        
//        errorMessageLabel.text = ""
        errorCounter = 0
        
        guard let firstName = firstName?.text, firstName != "" else {
//            errorMessageLabel.text = "Please enter a name."
            firstNameLabel.text = "Please enter a name."
            firstNameLabel.textColor = .red
            
            errorCounter += 1
            return
        }
        
        guard let lastName = lastName?.text, lastName != "" else {
//            errorMessageLabel.text = "Please enter a last name."
            lastNameLabel.text = "Please enter a last name."
            lastNameLabel.textColor = .red
            
            errorCounter += 1
            return
        }
        guard let company = companyName?.text, company != "" else {
//            errorMessageLabel.text = "Please enter company name."
            companyNameLabel.text = "Please enter company name."
            companyNameLabel.textColor = .red
            
            errorCounter += 1
            return
        }
        
        guard let mobile = mobileNumber?.text, mobile != "" else {
//            errorMessageLabel.text = "Please enter a mobile number."
            mobileNumberLabel.text = "Please enter a mobile number."
            mobileNumberLabel.textColor = .red
            
            errorCounter += 1
            return
        }
        guard let address = address?.text, address != "" else {
//            errorMessageLabel.text = "Please enter an address."
            addressLabel.text = "Please enter an address."
            addressLabel.textColor = .red
            
            errorCounter += 1
            return
        }
        
        guard let addressSec = addressSec?.text, addressSec != "" else {
//            errorMessageLabel.text = "Please enter a second address."
            addressSecLabel.text = "Please enter a second address."
            addressSecLabel.textColor = .red
            
            errorCounter += 1
            return
        }
        guard let state = state?.text, state != "" else {
//            errorMessageLabel.text = "Please mention a state."
            stateLabel.text = "Please mention a state."
            stateLabel.textColor = .red
            
            errorCounter += 1
            return
        }
        
        guard let city = city?.text, city != "" else {
//            errorMessageLabel.text = "Please mention a city."
            cityLabel.text = "Please mention a city."
            cityLabel.textColor = .red
            
            errorCounter += 1
            return
        }
        guard let zipcode = zipcode?.text, zipcode != "" else {
//            errorMessageLabel.text = "Please mention a zipcode."
            zipcodeLabel.text = "Please mention a zipcode."
            zipcodeLabel.textColor = .red
            
            errorCounter += 1
            return
        }
        
        guard let country = country?.text, country != "" else {
//            errorMessageLabel.text = "Please mention a country."
            countryLabel.text = "Please mention a country."
            countryLabel.textColor = .red
            
            errorCounter += 1
            return
        }
        
        if String().isNotValidEntry(firstName) {
//            errorMessageLabel.text = "Please enter a valid name. "
            firstNameLabel.text = "Please enter a valid name. "
            firstNameLabel.textColor = .red
            
            errorCounter += 1
        } else {
            if String().isNotValidName(firstName) {
//                errorMessageLabel.text = "Please enter a valid name. "
                firstNameLabel.text = "Please enter a valid name. "
                firstNameLabel.textColor = .red
                
                errorCounter += 1
            }
        }
        
        if String().isNotValidEntry(lastName) {
//            errorMessageLabel.text = errorMessageLabel.text! + "Please enter a valid last name. "
            lastNameLabel.text = "Please enter a valid last name. "
            lastNameLabel.textColor = .red
            
            errorCounter += 1
        } else {
            if String().isNotValidName(lastName) {
//                errorMessageLabel.text = errorMessageLabel.text! + "Please enter a valid last name. "
                lastNameLabel.text = "Please enter a valid last name. "
                lastNameLabel.textColor = .red
                
                errorCounter += 1
            }
        }
        
        if String().isNotValidEntry(company) {
//            errorMessageLabel.text = errorMessageLabel.text! + "Please enter a valid company name. "
            companyNameLabel.text = "Please enter a valid company name. "
            companyNameLabel.textColor = .red
            
            errorCounter += 1
        }
        
        if !String().isValidMobileNumber(mobile) {
//            errorMessageLabel.text = errorMessageLabel.text! + "Please enter a valid mobile number. "
            mobileNumberLabel.text =  "Please enter a valid mobile number. "
            mobileNumberLabel.textColor = .red
            
            errorCounter += 1
        }
        
        if String().isNotValidEntry(address) {
//            errorMessageLabel.text = errorMessageLabel.text! + "Please enter a valid address. "
            addressLabel.text = "Please enter a valid address. "
            addressLabel.textColor = .red
            
            errorCounter += 1
        }
        
        if String().isNotValidEntry(addressSec) {
//            errorMessageLabel.text = errorMessageLabel.text! + "Please enter a valid second address. "
            addressSecLabel.text = "Please enter a valid second address. "
            addressSecLabel.textColor = .red
            
            errorCounter += 1
        }
        
        if String().isNotValidEntry(state) {
//            errorMessageLabel.text = errorMessageLabel.text! + "Please enter a valid state. "
            stateLabel.text = "Please enter a valid state. "
            stateLabel.textColor = .red
            
            errorCounter += 1
        } else {
            if String().isNotValidName(state) {
//                errorMessageLabel.text = errorMessageLabel.text! + "Please enter a valid state. "
                stateLabel.text = "Please enter a valid state. "
                stateLabel.textColor = .red
                
                errorCounter += 1
            }
        }
        
        if String().isNotValidEntry(city) {
//            errorMessageLabel.text = errorMessageLabel.text! + "Please enter a valid city. "
            cityLabel.text = "Please enter a valid city. "
            cityLabel.textColor = .red
            
            errorCounter += 1
        } else {
            if String().isNotValidName(city) {
//                errorMessageLabel.text = errorMessageLabel.text! + "Please enter a valid city. "
                cityLabel.text = "Please enter a valid city. "
                cityLabel.textColor = .red
                
                errorCounter += 1
            }
        }
        
        if !String().isValidZipcode(zipcode) {
//            errorMessageLabel.text = errorMessageLabel.text! + "Please enter a valid zipcode. "
            zipcodeLabel.text = "Please enter a valid zipcode. "
            zipcodeLabel.textColor = .red
            
            errorCounter += 1
        }
        
        if String().isNotValidEntry(country) {
//            errorMessageLabel.text = errorMessageLabel.text! + "Please enter a valid country. "
            countryLabel.text = "Please enter a valid country. "
            countryLabel.textColor = .red
            
            errorCounter += 1
        } else {
            if String().isNotValidName(country) {
//                errorMessageLabel.text = errorMessageLabel.text! + "Please enter a valid country. "
                countryLabel.text = "Please enter a valid country. "
                countryLabel.textColor = .red
                
                errorCounter += 1
            }
        }
        
//        if errorMessageLabel.text == "" {
        if errorCounter > 0 {
            let confirmationAlert = UIAlertController(title: "Confirmation", message: "Are you sure you want to update details?" , preferredStyle: .alert)
            
            let yes = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
                print("Yes button tapped")
                if self.selectedFromMenu == "No" {
                    self.updateDetails()
                } else {
                    self.saveDetails()
                }
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                print("Cancel button tapped")
            }
            
            confirmationAlert.addAction(yes)
            confirmationAlert.addAction(cancel)
            
            self.present(confirmationAlert, animated: true, completion: nil)
        } else {
        }
        
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
            self.users = self.dataModel.fetchData(entityName: "Users")
            if self.selectedFromMenu == "No" {
                let alert = UIAlertController(title: "", message: "Are you sure?", preferredStyle: .alert)
                
                let yes = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
                    
                    self.dataModel.deleteData(entityName: "Users", position: self.selectedUserPosition)
                    UserDefaults.standard.removeObject(forKey: "selectedPosition")
                    
                    let successAlert = UIAlertController(title: "", message: "User deleted.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                    successAlert.addAction(ok)
                    
                    self.present(successAlert, animated: true, completion: nil)
                }
                
                let cancel = UIAlertAction(title: "Cancel", style: .cancel)
                
                alert.addAction(yes)
                alert.addAction(cancel)
                
                self.present(alert, animated: true, completion: nil)
            }
            
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
    
    func saveDetails() {
        let person = dataModel.getEntityInstance(entityName: "Users")
        
        let firstName = self.firstName.text
        let lastName = self.lastName.text
        let company = self.companyName.text
        let mobile = self.mobileNumber.text
        let address = self.address.text
        let addressSec = self.addressSec.text
        let state = self.state.text
        let city = self.city.text
        let zipcode = self.zipcode.text
        let country = self.country.text
        
        person.setValue(firstName, forKey: "firstName")
        person.setValue(lastName, forKey: "lastName")
        person.setValue(company, forKey: "comapnyName")
        person.setValue(mobile, forKey: "mobileNumber")
        person.setValue(address, forKey: "address")
        person.setValue(addressSec, forKey: "addressSec")
        person.setValue(state, forKey: "state")
        person.setValue(city, forKey: "city")
        person.setValue(zipcode, forKey: "zipcode")
        person.setValue(country, forKey: "country")
        
        dataModel.addData(data: person)
        
        let successAlert = UIAlertController(title: "", message: "User added.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            self.selectedFromMenu = "No"
            UserDefaults.standard.set("No", forKey: "selectedFromMenu")
            self.users = self.dataModel.fetchData(entityName: "Users")
            var i = 0
            while i < self.users.count {
                let person = self.users[i]
                let fname = self.firstName.text
                let lname = self.lastName.text
                let u_fname = person.value(forKey: "firstName") as! String
                let u_lname = person.value(forKey: "lastName") as! String
                if fname ==  u_fname && lname == u_lname {
                    self.selectedUserPosition = i
                    UserDefaults.standard.set(i, forKey: "selectedPosition")
                    break
                }
                i += 1
            }
            
            self.resetFields()
            
        }
        successAlert.addAction(ok)
        
        self.present(successAlert, animated: true, completion: nil)
    }
    
    func updateDetails() {
        
        users = dataModel.fetchData(entityName: "Users")
        
        self.person = users[selectedUserPosition]
        
        let firstName = self.firstName.text
        let lastName = self.lastName.text
        let company = self.companyName.text
        let mobile = self.mobileNumber.text
        let address = self.address.text
        let addressSec = self.addressSec.text
        let state = self.state.text
        let city = self.city.text
        let zipcode = self.zipcode.text
        let country = self.country.text
        
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
        
        dataModel.updateData()
        
        let successAlert = UIAlertController(title: "", message: "User details updated", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            self.resetFields()
        }
        successAlert.addAction(ok)
        
        self.present(successAlert, animated: true, completion: nil)
    }
    
    func resetFields() {
        self.errorCounter = 0
        
        self.firstNameLabel.text = "First Name"
        self.lastNameLabel.text = "Last Name"
        self.companyNameLabel.text = "Company Name"
        self.mobileNumberLabel.text = "Mobile Number"
        self.addressLabel.text = "Address"
        self.addressSecLabel.text = "Address Sec"
        self.stateLabel.text = "State"
        self.cityLabel.text = "City"
        self.zipcodeLabel.text = "Zipcode"
        self.countryLabel.text = "Country"
        
        self.firstNameLabel.textColor = .black
        self.lastNameLabel.textColor = .black
        self.companyNameLabel.textColor = .black
        self.mobileNumberLabel.textColor = .black
        self.addressLabel.textColor = .black
        self.addressSecLabel.textColor = .black
        self.stateLabel.textColor = .black
        self.cityLabel.textColor = .black
        self.zipcodeLabel.textColor = .black
        self.countryLabel.textColor = .black
    }
    
}

extension String {
    func isNotValidEntry(_ text: String) -> Bool {
        let regEx = "[^A-Za-z0-9]"
        let firstChar = text.prefix(1)
        
        let textEntryCheck = NSPredicate(format: "SELF MATCHES[c] %@", regEx)
        return textEntryCheck.evaluate(with: firstChar)
    }
    
    func isNotValidName(_ name: String) -> Bool {
        let regEx = ".*[^A-Za-z].*"
        
        let nameCheck = NSPredicate(format: "SELF MATCHES[c] %@", regEx)
        print(nameCheck.evaluate(with: name))
        return nameCheck.evaluate(with: name)
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
}
