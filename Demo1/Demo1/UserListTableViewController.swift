//
//  TableViewController.swift
//  Demo1
//
//  Created by Ashwini Prabhavalkar on 04/07/22.
//

import UIKit
import CoreData

class UserListTableViewController: UITableViewController {
    
    let dataModel = persistentDataADC()
    var users: [NSManagedObject] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        backItem.tintColor = UIColor(hexaRGB: "#2D69B1")
        navigationItem.backBarButtonItem = backItem
        
        navigationItem.title = "Users"
        
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
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }

        users = dataModel.fetchData(entityName: "Users")
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("UserTableViewCell", owner: self)?.first as! UserTableViewCell
        let person = users[indexPath.row]
        let fname = person.value(forKey: "firstName") as! String
        let lname = person.value(forKey: "lastName") as! String
        cell.userName.text = "\(fname) \(lname)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(indexPath.row, forKey: "selectedPosition")
        
        let userProfileVC = ProfileViewController()
        self.navigationController?.pushViewController(userProfileVC, animated: true)
        
    }
}
