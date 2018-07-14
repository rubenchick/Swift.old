//
//  RowOfOder+CoreDataProperties.swift
//  Test Core Data
//
//  Created by Anton Rubenchik on 14.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


extension RowOfOder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RowOfOder> {
        return NSFetchRequest<RowOfOder>(entityName: "RowOfOder")
    }

    @NSManaged public var sum: Float
    @NSManaged public var order: Order?
    @NSManaged public var services: Services?

}
