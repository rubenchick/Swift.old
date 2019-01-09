//
//  DayOfMonth+CoreDataProperties.swift
//  Daily Routine
//
//  Created by Anton Rubenchik on 15.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


extension DayOfMonth {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayOfMonth> {
        return NSFetchRequest<DayOfMonth>(entityName: "DayOfMonth")
    }

    @NSManaged public var date: NSDecimalNumber?
    @NSManaged public var thingToDo: ThingToDo?

}
