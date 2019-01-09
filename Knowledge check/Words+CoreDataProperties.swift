//
//  Words+CoreDataProperties.swift
//  Knowledge check
//
//  Created by Anton Rubenchik on 08/12/2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


extension Words {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Words> {
        return NSFetchRequest<Words>(entityName: "Words")
    }

    @NSManaged public var name: String?
    @NSManaged public var check: String?
    @NSManaged public var group: Group?

}
