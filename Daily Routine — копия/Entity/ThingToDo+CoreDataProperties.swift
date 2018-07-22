//
//  ThingToDo+CoreDataProperties.swift
//  Daily Routine
//
//  Created by Anton Rubenchik on 15.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


extension ThingToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ThingToDo> {
        return NSFetchRequest<ThingToDo>(entityName: "ThingToDo")
    }

    @NSManaged public var daily: Bool
    @NSManaged public var isActual: Bool
    @NSManaged public var monthly: Bool
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var notification: Bool
    @NSManaged public var priority: NSDecimalNumber?
    @NSManaged public var time: NSDate?
    @NSManaged public var weekly: Bool
    @NSManaged public var dayOfMonth: NSSet?
    @NSManaged public var history: NSSet?
    @NSManaged public var week: Week?

}

// MARK: Generated accessors for dayOfMonth
extension ThingToDo {

    @objc(addDayOfMonthObject:)
    @NSManaged public func addToDayOfMonth(_ value: DayOfMonth)

    @objc(removeDayOfMonthObject:)
    @NSManaged public func removeFromDayOfMonth(_ value: DayOfMonth)

    @objc(addDayOfMonth:)
    @NSManaged public func addToDayOfMonth(_ values: NSSet)

    @objc(removeDayOfMonth:)
    @NSManaged public func removeFromDayOfMonth(_ values: NSSet)

}

// MARK: Generated accessors for history
extension ThingToDo {

    @objc(addHistoryObject:)
    @NSManaged public func addToHistory(_ value: History)

    @objc(removeHistoryObject:)
    @NSManaged public func removeFromHistory(_ value: History)

    @objc(addHistory:)
    @NSManaged public func addToHistory(_ values: NSSet)

    @objc(removeHistory:)
    @NSManaged public func removeFromHistory(_ values: NSSet)

}
