//
//  Order+CoreDataProperties.swift
//  Test Core Data
//
//  Created by Anton Rubenchik on 14.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var made: Bool
    @NSManaged public var paid: Bool
    @NSManaged public var customer: Customer?
    @NSManaged public var rowOfOder: NSSet?

}

// MARK: Generated accessors for rowOfOder
extension Order {

    @objc(addRowOfOderObject:)
    @NSManaged public func addToRowOfOder(_ value: RowOfOder)

    @objc(removeRowOfOderObject:)
    @NSManaged public func removeFromRowOfOder(_ value: RowOfOder)

    @objc(addRowOfOder:)
    @NSManaged public func addToRowOfOder(_ values: NSSet)

    @objc(removeRowOfOder:)
    @NSManaged public func removeFromRowOfOder(_ values: NSSet)

}
