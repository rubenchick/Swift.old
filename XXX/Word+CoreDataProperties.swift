//
//  Word+CoreDataProperties.swift
//  XXX
//
//  Created by Anton Rubenchik on 27/02/2019.
//  Copyright © 2019 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var text: String?
    @NSManaged public var light: String?

}
