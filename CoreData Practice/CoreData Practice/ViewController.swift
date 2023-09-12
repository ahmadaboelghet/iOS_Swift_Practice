//
//  ViewController.swift
//  CoreData Practice
//
//  Created by aBoelghet  on 12/09/2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    // Define context instance
    var context = NSManagedObjectContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define appDelegate instance and add new user
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue("Shashikant", forKey: "username")
        newUser.setValue("1234", forKey: "password")
        newUser.setValue(28, forKey: "age")
        
    }
    
    
    // save Data
    func saveData(){
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    // Retive Data
    func retriveData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "username") as! String)
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
}

