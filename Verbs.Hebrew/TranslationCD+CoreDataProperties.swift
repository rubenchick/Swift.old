//
//  TranslationCD+CoreDataProperties.swift
//  Verbs.Hebrew
//
//  Created by Anton Rubenchik on 03/03/2019.
//  Copyright © 2019 Anton Rubenchik. All rights reserved.
//
//

import Foundation
import CoreData


extension TranslationCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TranslationCD> {
        return NSFetchRequest<TranslationCD>(entityName: "TranslationCD")
    }

    @NSManaged public var typeOfTranslation: String?
    @NSManaged public var russian: String?
    @NSManaged public var spanish: String?
    @NSManaged public var english: String?
    @NSManaged public var relationshipToWord: WordCD?
    @NSManaged public var relationshipToPresentTense: PresentTenseCD?
    @NSManaged public var relationshipToPastTense: PastTenseCD?
    @NSManaged public var relationshipToFutureTense: FutureTenseCD?
    @NSManaged public var relationshipToImperative: ImperativeCD?

}
