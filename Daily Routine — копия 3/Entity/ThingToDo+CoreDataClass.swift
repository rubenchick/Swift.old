//
//  ThingToDo+CoreDataClass.swift
//  Daily Routine
//
//  Created by Anton Rubenchik on 15.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


public class ThingToDo: NSManagedObject {
    convenience init() {
        // Описание сущности
        let entity = NSEntityDescription.entity(forEntityName: "ThingToDo", in: CoreDataManager.instance.persistentContainer.viewContext)
        // Создание нового объекта
        self.init(entity: entity!, insertInto: CoreDataManager.instance.persistentContainer.viewContext)        
    }
    
    class func fetchedResultsIsActual() ->  NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ThingToDo")
        let sortDescription = NSSortDescriptor(key: "priority", ascending: true)
        fetchRequest.sortDescriptors = [sortDescription]
        let predicate = NSPredicate(format: "%K == %@", "isActual", NSNumber(value: true)) 
        //#needAdd
        // need add full predicate with weekDay and monthDay
        fetchRequest.predicate = predicate
        
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultController
    }
    
    class func fetchedResultsHistoryToday(forThingToDo thingToDo: ThingToDo) ->  NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        let sortDescription = NSSortDescriptor(key: "thingToDo.priority", ascending: true)
        fetchRequest.sortDescriptors = [sortDescription]
        // look for only today
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        let dateFrom = calendar.startOfDay(for: Date()) // eg. 2016-10-10 00:00:00
        let predicateDate = NSPredicate(format: "%K >= %@", "date", dateFrom as NSDate)
        let predicateThingToDo = NSPredicate(format: "%K == %@", "thingToDo",thingToDo)
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateDate,predicateThingToDo])
        fetchRequest.predicate = compound
        
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultController
    }
}

