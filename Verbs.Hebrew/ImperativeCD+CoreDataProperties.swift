//
//  ImperativeCD+CoreDataProperties.swift
//  Verbs.Hebrew
//
//  Created by Anton Rubenchik on 03/03/2019.
//  Copyright © 2019 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


extension ImperativeCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImperativeCD> {
        return NSFetchRequest<ImperativeCD>(entityName: "ImperativeCD")
    }

    @NSManaged public var masculineSingular: String?
    @NSManaged public var plural: String?
    @NSManaged public var feminineSingular: String?
    @NSManaged public var relationshipToWord: WordCD?
    @NSManaged public var relationshipToTranslation: NSSet?

}

// MARK: Generated accessors for relationshipToTranslation
extension ImperativeCD {

    @objc(addRelationshipToTranslationObject:)
    @NSManaged public func addToRelationshipToTranslation(_ value: TranslationCD)

    @objc(removeRelationshipToTranslationObject:)
    @NSManaged public func removeFromRelationshipToTranslation(_ value: TranslationCD)

    @objc(addRelationshipToTranslation:)
    @NSManaged public func addToRelationshipToTranslation(_ values: NSSet)

    @objc(removeRelationshipToTranslation:)
    @NSManaged public func removeFromRelationshipToTranslation(_ values: NSSet)

}
