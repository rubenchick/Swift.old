//
//  ViewController.swift
//  Test Core Data v2
//
//  Created by Anton Rubenchik on 13.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var customer: Customer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        customer = Customer()
        if customer == nil {
            print("Nill")
        } else {
            print("no Nill")
            customer?.name = "Flag"
        }
        print("Good")
        
//        /        do {
            //             let results = try context.fetch(request)
            //            print("Count : \(results.count)")
            //            for result in results as! [NSManagedObject] {
            //                print("name - \(result.value(forKey: "name")!)  info - \(result.value(forKey: "info")!)")
            //            }
            //        } catch {
            //            print(error)
            //        }
        
        
        
//        if let x = customer as? Customer {
////            x.name = "First"
//        }
//        customer?.name = "Ivan"
//        customer?.info = "Grozny"
        
//        let entity = NSEntityDescription.entity(forEntityName: "Customer", in: CoreDataManager.instance.persistentContainer.viewContext)
//        let newCustomer = NSManagedObject(entity: entity!, insertInto: CoreDataManager.instance.persistentContainer.viewContext) as! Customer
//        newCustomer.name = "Ivan"
//        newCustomer.info = "Grozny"
        
        
        
        
        
//        CoreDataManager.instance.saveContext()
        print(customer)
        
    }


    @IBAction func pressButton(_ sender: UIButton) {
    }
    
}

