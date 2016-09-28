//
//  ViewController.swift
//  core data
//
//  Created by Mark on 5/26/16.
//  Copyright © 2016 Mark. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        //
        //        let newStudent = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: context)
        //
        //        newStudent.setValue("Fadhel", forKey: "fname")
        //        newStudent.setValue("Moosuri", forKey: "lname")
        //
        //
        //        do {
        //            try context.save()
        //
        //        } catch {
        //            print("Error detected when saving data")
        //        }
        //
        
        let request = NSFetchRequest(entityName: "Student")
        
        request.returnsObjectsAsFaults = false
        
       // request.predicate = NSPredicate(format: "fname = %@", "Fadhel")
        
        do {
            
            let results = try context.executeFetchRequest(request)
            
            if (results.count > 0) {
                
                for result in results as! [NSManagedObject]{
                    
                    
                    if let fnameS = result.valueForKey("fname") as? String{ //use this to check the type of returned data
                        
                        print(fnameS)
                        
                    }
                }
                
                
            }else {
                print("Core data empty")
            }
            
            try context.save()
            
        } catch {
            print("Error detected for fetch query")
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

