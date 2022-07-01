//
//  ViewController.swift
//  Demo1
//
//  Created by Ashwini Prabhavalkar on 15/06/22.
//

import UIKit

struct menu {
    let imageName: String
    let title: String
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var isSeen = false
    var homePage = HomePage(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    let menuItemDetails = [menu(imageName: "homekit", title: "Home"), menu(imageName: "clock", title: "Log History"), menu(imageName: "info.circle", title: "Information"), menu(imageName: "questionmark.circle", title: "Registration"), menu(imageName: "arrow.right.circle", title: "Log Out"), menu(imageName: "person.crop.circle", title: "Profile Page")]
    let backItem = UIBarButtonItem()
    
    override func viewWillAppear(_ animated: Bool) {
        let newSize = CGSize(width: 70, height: 30)
        let leftImage = resizeImage(image: UIImage(named: "menu")!, targetSize: newSize)
        self.navigationItem.leftBarButtonItem?.image = leftImage
        self.navigationItem.leftBarButtonItem?.action = #selector(onClick)
        self.navigationItem.leftBarButtonItem?.target = self
        
        let rightImage = resizeImage(image: UIImage(named: "bluetooth")!, targetSize: newSize)
        self.navigationItem.rightBarButtonItem?.image = rightImage

        homePage.tbl_menu.dataSource = self
        homePage.tbl_menu.delegate = self
        homePage.tbl_menu.isScrollEnabled = true
       
        self.view.addSubview(homePage)
        
        if UIDevice.current.orientation.isPortrait {

            self.homePage.vw_menu.frame = CGRect(x: -self.homePage.vw_menu.bounds.width, y: 60, width: self.homePage.vw_menu.bounds.width, height: self.homePage.vw_menu.bounds.height)
        } else {
            self.homePage.vw_menu.frame = CGRect(x: -self.homePage.vw_menu.bounds.width, y: 0, width: self.homePage.vw_menu.bounds.width, height: self.homePage.vw_menu.bounds.height)
        }
        self.homePage.vw_menu.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hanna Lab"

        let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizerDown.direction = .right
        self.view.addGestureRecognizer(swipeGestureRecognizerDown)
        
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return menuItemDetails.count
        } else {
            return 1
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var cell = homePage.tbl_menu.dequeueReusableCell(withIdentifier: "menuItem") as? menuItem
            if cell == nil {
                tableView.register(UINib(nibName: "menuItem", bundle: nil), forCellReuseIdentifier: "menuItem")
                cell = homePage.tbl_menu.dequeueReusableCell(withIdentifier: "menuItem") as? menuItem
            }
            cell!.iv_icon.image = UIImage(systemName: menuItemDetails[indexPath.row].imageName)
            cell!.lbl_menuItem.text = menuItemDetails[indexPath.row].title
            
            return cell!
        } else {
            var cell = homePage.tbl_menu.dequeueReusableCell(withIdentifier: "versionItem") as? versionItem
            if cell == nil {
                tableView.register(UINib(nibName: "versionItem", bundle: nil), forCellReuseIdentifier: "versionItem")
                cell = homePage.tbl_menu.dequeueReusableCell(withIdentifier: "versionItem") as? versionItem
            }
            
            let attributedString = NSMutableAttributedString.init(string: cell!.tv_hyperLink.text!)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
            attributedString.addAttribute(.link, value: "https://google.com", range: NSRange.init(location: 0, length: attributedString.length))
            cell!.tv_hyperLink.attributedText = attributedString
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showHide()
        
        switch menuItemDetails[indexPath.row].title {
        case "Registration" :
            backItem.title = "Back"
            backItem.tintColor = UIColor(hexaRGB: "#2D69B1")
            navigationItem.backBarButtonItem = backItem
            
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let signUpVC = Storyboard.instantiateViewController(withIdentifier: "SignUp") as! SignUpViewController
            self.navigationController?.pushViewController(signUpVC, animated: true)
            break
            
        case "Profile Page":
            backItem.title = "Hanna Lab"
            backItem.tintColor = UIColor(hexaRGB: "#2D69B1")
            navigationItem.backBarButtonItem = backItem
            
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let profileVC = Storyboard.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
            self.navigationController?.pushViewController(profileVC, animated: true)
            break
        default:
            print("not found")
        }
    }
    
    @objc func onClick() {
        showHide()
    }
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
       showHide()
    }
    
    func showHide() {
        if !isSeen {
            homePage.vw_menu.isHidden = false
            if UIDevice.current.orientation.isPortrait {
                homePage.vw_menu.frame = CGRect(x: -UIScreen.main.bounds.width, y: 0, width: homePage.vw_menu.bounds.width, height: UIScreen.main.bounds.height)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.homePage.vw_menu.frame = CGRect(x: 0, y: 0, width: self.homePage.vw_menu.bounds.width, height: self.homePage.vw_menu.bounds.height)
                }, completion: nil)
            } else {
                homePage.vw_menu.frame = CGRect(x: -UIScreen.main.bounds.width, y: 0, width: homePage.vw_menu.bounds.width, height: UIScreen.main.bounds.height)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.homePage.vw_menu.frame = CGRect(x: 0, y: 0, width: self.homePage.vw_menu.bounds.width, height: self.homePage.vw_menu.bounds.height)
                }, completion: nil)
            }
        } else {
            if UIDevice.current.orientation.isPortrait {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.homePage.vw_menu.frame = CGRect(x: -self.homePage.vw_menu.bounds.width, y: 0, width: self.homePage.vw_menu.bounds.width, height: self.homePage.vw_menu.bounds.height)
                }, completion: {_ in
                    self.homePage.vw_menu.isHidden = true
                })
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.homePage.vw_menu.frame = CGRect(x: -self.homePage.vw_menu.bounds.width, y: 30, width: self.homePage.vw_menu.bounds.width, height: self.homePage.vw_menu.bounds.height)
                }, completion: {_ in
                    self.homePage.vw_menu.isHidden = true
                })
            }
        }
        isSeen = !isSeen
    }
   
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        homePage.frame = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width, height: self.view.bounds.height)
    }
}
