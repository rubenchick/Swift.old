//
//  Group+CoreDataClass.swift
//  Knowledge check
//
//  Created by Anton Rubenchik on 08/12/2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


public class Group: NSManagedObject {
    convenience init() {
        // Описание сущности
        let entity = NSEntityDescription.entity(forEntityName: "Group", in: CoreDataManager.instance.persistentContainer.viewContext)
        // Создание нового объекта
        self.init(entity: entity!, insertInto: CoreDataManager.instance.persistentContainer.viewContext)
    }
    
    class func fetchedResults() ->  NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Group")
        let sortDescription = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescription]
//        let predicate = NSPredicate(format: "%K != %@", "name","333")
//        fetchRequest.predicate = predicate
        
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultController
    }

}
