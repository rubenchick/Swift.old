//
//  Statistic+CoreDataProperties.swift
//  Learn Hebrew
//
//  Created by Anton Rubenchik on 22.08.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


extension Statistic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Statistic> {
        return NSFetchRequest<Statistic>(entityName: "Statistic")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var countWord: Int32
    @NSManaged public var countMistake: Int32
    @NSManaged public var changeLevel: Int32
    @NSManaged public var countIsLearned: Int32

}
