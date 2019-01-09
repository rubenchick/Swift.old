//
//  Words+CoreDataClass.swift
//  Learn Hebrew
//
//  Created by Anton Rubenchik on 22.08.2018.
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
//    
//    //    class func fetchedResults(forDate date: Date) ->  NSFetchedResultsController<NSFetchRequestResult> {
//    class func fetchedResultsToday() ->  NSFetchedResultsController<NSFetchRequestResult> {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
//        let sortDescription = NSSortDescriptor(key: "thingToDo.priority", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescription]
//        
//        // look for only today
//        var calendar = Calendar.current
//        calendar.timeZone = NSTimeZone.local
//        
//        // Get today's beginning & end
//        let dateFrom = calendar.startOfDay(for: Date()) // eg. 2016-10-10 00:00:00
//        //        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
//        
//        // Set predicate as date being today's date
//        let fromPredicate = NSPredicate(format: "%K >= %@", "date", dateFrom as NSDate)
//        //        let toPredicate = NSPredicate(format: "%@ < %@", "date", dateTo as! NSDate)
//        //        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
//        //        fetchRequest.predicate = datePredicate
//        //        let predicate = NSPredicate(format: "%K == %@", "date",dateToday as CVarArg)
//        fetchRequest.predicate = fromPredicate
//        
//        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//        
//        return fetchedResultController
//    }
}
