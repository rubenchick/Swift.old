//
//  Words+CoreDataClass.swift
//  Knowledge check
//
//  Created by Anton Rubenchik on 08/12/2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


public class Words: NSManagedObject {
    convenience init() {
        // Описание сущности
        let entity = NSEntityDescription.entity(forEntityName: "Words", in: CoreDataManager.instance.persistentContainer.viewContext)
        // Создание нового объекта
        self.init(entity: entity!, insertInto: CoreDataManager.instance.persistentContainer.viewContext)
    }
    
    class func fetchedResults(forThisGroup group: Group) ->  NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Words")
        let sortDescription = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescription]
        let predicate = NSPredicate(format: "%K == %@", "group",group)
        fetchRequest.predicate = predicate
        
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultController
    }
    
    class func fetchedResults() ->  NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Words")
        let sortDescription = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescription]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
}
