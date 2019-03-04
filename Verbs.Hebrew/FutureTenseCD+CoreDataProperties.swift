//
//  FutureTenseCD+CoreDataProperties.swift
//  Verbs.Hebrew
//
//  Created by Anton Rubenchik on 03/03/2019.
//  Copyright © 2019 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


extension FutureTenseCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FutureTenseCD> {
        return NSFetchRequest<FutureTenseCD>(entityName: "FutureTenseCD")
    }

    @NSManaged public var singular1st: String?
    @NSManaged public var masculineSingular2nd: String?
    @NSManaged public var feminineSingular2nd: String?
    @NSManaged public var masculineSingular3nd: String?
    @NSManaged public var feminineSingular3nd: String?
    @NSManaged public var plural1st: String?
    @NSManaged public var masculinePlural2nd: String?
    @NSManaged public var femininePlural2nd: String?
    @NSManaged public var plural3nd: String?
    @NSManaged public var relationshipToTranslation: NSSet?
    @NSManaged public var relationshipToWord: WordCD?

}

// MARK: Generated accessors for relationshipToTranslation
extension FutureTenseCD {

    @objc(addRelationshipToTranslationObject:)
    @NSManaged public func addToRelationshipToTranslation(_ value: TranslationCD)

    @objc(removeRelationshipToTranslationObject:)
    @NSManaged public func removeFromRelationshipToTranslation(_ value: TranslationCD)

    @objc(addRelationshipToTranslation:)
    @NSManaged public func addToRelationshipToTranslation(_ values: NSSet)

    @objc(removeRelationshipToTranslation:)
    @NSManaged public func removeFromRelationshipToTranslation(_ values: NSSet)

}
