//
//  Customer+CoreDataClass.swift
//  Test Core Data v2
//
//  Created by Anton Rubenchik on 13.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Customer)
public class Customer: NSManagedObject {
    class var entity: NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: "Customer", in: CoreDataManager.instance.persistentContainer.viewContext)!
    }
 
    convenience init() {
        // Создание нового объекта
        self.init(entity: Customer.entity, insertInto: CoreDataManager.instance.persistentContainer.viewContext)
    }
}
//
//convenience init() {
//    // Описание сущности
//    let entity = NSEntityDescription.entity(forEntityName: "Customer", in: CoreDataManager.instance.persistentContainer.viewContext)
//    // Создание нового объекта
//    self.init(entity: entity!, insertInto: CoreDataManager.instance.persistentContainer.viewContext)
//
//}
