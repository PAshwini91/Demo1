//
//  DataModel.swift
//  Demo1
//
//  Created by Ashwini Prabhavalkar on 08/07/22.
//

import Foundation
import CoreData

struct menu {
    let imageName: String
    let title: String
}

class persistentDataADC {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DemoModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchData(entityName: String) -> [NSManagedObject] {
        var dataArray = [NSManagedObject]()
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            dataArray = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return dataArray
    }
    
    func getEntityInstance(entityName: String) -> NSManagedObject {
        let managedContext = persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        
        return NSManagedObject(entity: entity, insertInto: managedContext)
    }
    
    func addData(data: NSManagedObject) {
        
        let managedContext = persistentContainer.viewContext
        var entity = [NSManagedObject]()
        do {
            try managedContext.save()
            entity.append(data)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func deleteData(entityName: String, position: Int) {
        
        let managedContext = persistentContainer.viewContext
        
        var dataArray = [NSManagedObject]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            dataArray = try managedContext.fetch(fetchRequest)
            managedContext.delete(dataArray[position] as NSManagedObject)
            dataArray.remove(at: position)
            try managedContext.save()
        } catch let error as NSError {
            print("Unsuccessful. \(error), \(error.userInfo)")
        }
        
    }
    
    func updateData() {
        
        let managedContext = persistentContainer.viewContext
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
        
    }
    
}
