//
//  Order+CoreDataClass.swift
//  Test Core Data
//
//  Created by Anton Rubenchik on 14.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


public class Order: NSManagedObject {
    convenience init() {
        // Описание сущности
        let entity = NSEntityDescription.entity(forEntityName: "Order", in: CoreDataManager.instance.persistentContainer.viewContext)
        // Создание нового объекта
        self.init(entity: entity!, insertInto: CoreDataManager.instance.persistentContainer.viewContext)
    }
    class func fetchedResults(forOrder order: Order) ->  NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RowOfOder")
        let sortDescription = NSSortDescriptor(key: "services.name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescription]
        
        let predicate = NSPredicate(format: "%K == %@", "order",order)
        fetchRequest.predicate = predicate
        
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
    
        return fetchedResultController
    }
}
