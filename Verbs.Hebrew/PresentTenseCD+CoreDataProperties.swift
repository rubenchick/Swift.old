//
//  PresentTenseCD+CoreDataProperties.swift
//  Verbs.Hebrew
//
//  Created by Anton Rubenchik on 03/03/2019.
//  Copyright © 2019 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


extension PresentTenseCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PresentTenseCD> {
        return NSFetchRequest<PresentTenseCD>(entityName: "PresentTenseCD")
    }

    @NSManaged public var masculineSingular: String?
    @NSManaged public var feminineSingular: String?
    @NSManaged public var masculinePlural: String?
    @NSManaged public var femininePlural: String?
    @NSManaged public var relationshipToWord: WordCD?
    @NSManaged public var relationshipToTranslation: NSSet?

}

// MARK: Generated accessors for relationshipToTranslation
extension PresentTenseCD {

    @objc(addRelationshipToTranslationObject:)
    @NSManaged public func addToRelationshipToTranslation(_ value: TranslationCD)

    @objc(removeRelationshipToTranslationObject:)
    @NSManaged public func removeFromRelationshipToTranslation(_ value: TranslationCD)

    @objc(addRelationshipToTranslation:)
    @NSManaged public func addToRelationshipToTranslation(_ values: NSSet)

    @objc(removeRelationshipToTranslation:)
    @NSManaged public func removeFromRelationshipToTranslation(_ values: NSSet)

}
