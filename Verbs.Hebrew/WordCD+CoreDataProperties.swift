//
//  WordCD+CoreDataProperties.swift
//  Verbs.Hebrew
//
//  Created by Anton Rubenchik on 03/03/2019.
//  Copyright © 2019 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


extension WordCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordCD> {
        return NSFetchRequest<WordCD>(entityName: "WordCD")
    }

    @NSManaged public var typeOfVerb: String?
    @NSManaged public var infinitive: String?
    @NSManaged public var preposition: String?
    @NSManaged public var reserve1: String?
    @NSManaged public var reserve2: String?
    @NSManaged public var relationshipToTranslation: NSSet?
    @NSManaged public var relationshipToPresentTense: PresentTenseCD?
    @NSManaged public var relationshipToPastTense: PastTenseCD?
    @NSManaged public var relationshipToFutureTense: FutureTenseCD?
    @NSManaged public var relationshipToImperative: ImperativeCD?

}

// MARK: Generated accessors for relationshipToTranslation
extension WordCD {

    @objc(addRelationshipToTranslationObject:)
    @NSManaged public func addToRelationshipToTranslation(_ value: TranslationCD)

    @objc(removeRelationshipToTranslationObject:)
    @NSManaged public func removeFromRelationshipToTranslation(_ value: TranslationCD)

    @objc(addRelationshipToTranslation:)
    @NSManaged public func addToRelationshipToTranslation(_ values: NSSet)

    @objc(removeRelationshipToTranslation:)
    @NSManaged public func removeFromRelationshipToTranslation(_ values: NSSet)

}
