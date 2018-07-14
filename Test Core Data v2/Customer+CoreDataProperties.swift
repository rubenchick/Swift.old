//
//  Customer+CoreDataProperties.swift
//  Test Core Data v2
//
//  Created by Anton Rubenchik on 13.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var info: String?
    @NSManaged public var name: String?

}
