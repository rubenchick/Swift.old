//
//  CoreDataManager.swift
//  Verbs.Hebrew
//
//  Created by Anton Rubenchik on 01/03/2019.
//  Copyright © 2019 Anton Rubenchik. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    // Singleton
    static let instance = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Verbs_Hebrew")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchedResultsController(entityName: String, keyForSort: String) -> NSFetchedResultsController<NSFetchRequestResult> {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        // Add sort
        let sortDescriptor = NSSortDescriptor(key: keyForSort, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
//
//
//
//public class WordCD: NSManagedObject {
//    convenience init() {
//        // Описание сущности
//        let entity = NSEntityDescription.entity(forEntityName: "WordCD", in: CoreDataManager.instance.persistentContainer.viewContext)
//        // Создание нового объекта
//        self.init(entity: entity!, insertInto: CoreDataManager.instance.persistentContainer.viewContext)
//    }
//
//    //    class func fetchedResults() ->  NSFetchedResultsController<NSFetchRequestResult> {
//    //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordCD")
//    //        let sortDescription = NSSortDescriptor(key: "infinitive", ascending: true)
//    //        fetchRequest.sortDescriptors = [sortDescription]
//    //        let predicate = NSPredicate(format: "%K != %@", "infinitive", "")
//    //        fetchRequest.predicate = predicate
//    //
//    //        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//    //
//    //        return fetchedResultController
//    //    }
//}
