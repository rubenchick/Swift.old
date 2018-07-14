//
//  TestViewController.swift
//  Test Core Data
//
//  Created by Anton Rubenchik on 13.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData

class TestViewController: UIViewController {
    let fetchResult = CoreDataManager.instance.fetchedResultsController(entityName: "Customer", keyForSort: "name")

    override func viewDidLoad() {
        super.viewDidLoad()
        let customer = Customer()
        customer.name = "First"
        customer.info = "Second"
        CoreDataManager.instance.saveContext()
        print("Good job")

        do {
            try fetchResult.performFetch()
        }
        catch {
            print(error.localizedDescription)
        }
        let x = fetchResult.fetchedObjects?.count

        print(x)

    }


}
