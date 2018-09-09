//
//  Words+CoreDataProperties.swift
//  Learn Hebrew
//
//  Created by Anton Rubenchik on 22.08.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


extension Words {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Words> {
        return NSFetchRequest<Words>(entityName: "Words")
    }

    @NSManaged public var levelOfLearning: Int32
    @NSManaged public var mistake: Int32
    @NSManaged public var discription: String?
    @NSManaged public var foreign: String?
    @NSManaged public var image: String?
    @NSManaged public var original: String?
    @NSManaged public var simple: String?
    @NSManaged public var dontWantToLearn: Bool
    @NSManaged public var isLearned: Bool
    @NSManaged public var nextContact: NSDate?

}
