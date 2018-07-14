//
//  Services+CoreDataProperties.swift
//  Test Core Data
//
//  Created by Anton Rubenchik on 14.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


extension Services {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Services> {
        return NSFetchRequest<Services>(entityName: "Services")
    }

    @NSManaged public var info: String?
    @NSManaged public var name: String?
    @NSManaged public var rowsOfOder: NSSet?

}

// MARK: Generated accessors for rowsOfOder
extension Services {

    @objc(addRowsOfOderObject:)
    @NSManaged public func addToRowsOfOder(_ value: RowOfOder)

    @objc(removeRowsOfOderObject:)
    @NSManaged public func removeFromRowsOfOder(_ value: RowOfOder)

    @objc(addRowsOfOder:)
    @NSManaged public func addToRowsOfOder(_ values: NSSet)

    @objc(removeRowsOfOder:)
    @NSManaged public func removeFromRowsOfOder(_ values: NSSet)

}
