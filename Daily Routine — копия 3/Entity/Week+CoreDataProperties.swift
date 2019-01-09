//
//  Week+CoreDataProperties.swift
//  Daily Routine
//
//  Created by Anton Rubenchik on 15.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


extension Week {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Week> {
        return NSFetchRequest<Week>(entityName: "Week")
    }

    @NSManaged public var friday: Bool
    @NSManaged public var monday: Bool
    @NSManaged public var saturday: Bool
    @NSManaged public var sunday: Bool
    @NSManaged public var thursday: Bool
    @NSManaged public var tuesday: Bool
    @NSManaged public var wednesday: Bool
    @NSManaged public var thingToDo: ThingToDo?

}
