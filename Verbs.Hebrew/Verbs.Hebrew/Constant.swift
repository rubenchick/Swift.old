//
//  Constant.swift
//  Verbs.Hebrew
//
//  Created by Anton Rubenchik on 01/03/2019.
//  Copyright © 2019 Anton Rubenchik. All rights reserved.
//

import Foundation

enum TypeOfSearch {
    case min,max
}

enum TypeOfLanguage {
    case russian
    case hebrew
    case english
    case spanish
}

let actualLanguage      = TypeOfLanguage.russian //!!!!!!!
let commonTranslation   = Translation()
let emptyTranslationCD  = TranslationCD() //
let emptyPresentTenseCD = PresentTenseCD()
let emptyPastTenseCD    = PastTenseCD()
let emptyFutureTenseCD  = FutureTenseCD()
let emptyImperativeCD   = ImperativeCD()
let identifierSegue     = "dictionaryToCard"
let identifierCell      = "identifierCell"
let presentBody = ["זכר","נקבה","רבים","רבות"]
let pastBody = ["אני","אתה","את","הוא","היא","אנחנו","אתם","אתן","הם","הן"]
let imperativeBody = ["זכר","נקבה","רבים","רבות"]


enum Utf16Parameter : UTF16.CodeUnit {
    case hebrewMin = 1400
    case hebrewMax = 1600
    case russianMin = 1040
    case russianMax = 1103
    case englishMin = 50
    case englishMax = 200
    case spanishMin = 300
    case spanishMax = 400
}
enum TypeOfVerb : String {
    case paal    = "פָּעַל"
    case piel    = "פִּיעֵל"
    case pial    = "פֻּיעַל"
    case hifil   = "הִפְעִיל"
    case hifal   = "הֻפְעַל"
    case nifal   = "נִפְעַל"
    case hitpael = "הִתְפַּעֵל"
}

//enum TypeOfTranslation {
//    case infinitive
//    case PTmasculineSingularPr
//    case PTfeminineSingularPr
//    case PTmasculinePluralPr
//    case PTfemininePluralPr
//}

enum TypeOfTranslation : String {
    case infinitiveP             = "infinitiveP"
    case translation             = "translation"
    case masculineSingularPr     = "masculineSingularPr"
    case feminineSingularPr      = "feminineSingularPr"
    case masculinePluralPr       = "masculinePluralPr"
    case femininePluralPr        = "femininePluralPr"
    case singular1stPr           = "singular1stPr"
    case masculineSingular2ndPr  = "masculineSingular2ndPr"
    case feminineSingular2ndPr   = "feminineSingular2ndPr"
    case masculineSingular3ndPr  = "masculineSingular3ndPr"
    case feminineSingular3ndPr   = "feminineSingular3ndPr"
    case plural1stPr             = "plural1stPr"
    case masculinePlural2ndPr    = "masculinePlural2ndPr"
    case femininePlural2ndPr     = "femininePlural2ndPr"
    case plural3ndPr             = "plural3ndPr"
    case pluralPr                = "pluralPr"
}

enum TypeOfTense {
    case presentTense
    case pastTense
    case futureTense
    case imperative
}

let namesFieldsArray = ["infinitive","infinitiveP","typeOfVerb","preposition","translation",
                        "presentTense","pastTense","futureTense","imperative"]

let namesFieldsTranslation = ["translationR","translationE","translationS"]

let namesFieldsPresentTense = ["masculineSingular","masculineSingularPr",
                               "feminineSingular","feminineSingularPr",
                               "masculinePlural","masculinePluralPr",
                               "femininePlural","femininePluralPr"]

let namesFieldsPastTense = ["singular1st","singular1stPr",
                            "masculineSingular2nd","masculineSingular2ndPr",
                            "feminineSingular2nd","feminineSingular2ndPr",
                            "masculineSingular3nd","masculineSingular3ndPr",
                            "feminineSingular3nd","feminineSingular3ndPr",
                            "plural1st","plural1stPr",
                            "masculinePlural2nd","masculinePlural2ndPr",
                            "femininePlural2nd","femininePlural2ndPr",
                            "plural3nd","plural3ndPr"]

let namesFieldsFutureTense = ["singular1st","singular1stPr",
                              "masculineSingular2nd","masculineSingular2ndPr",
                              "feminineSingular2nd","feminineSingular2ndPr",
                              "masculineSingular3nd","masculineSingular3ndPr",
                              "feminineSingular3nd","feminineSingular3ndPr",
                              "plural1st","plural1stPr",
                              "masculinePlural2nd","masculinePlural2ndPr",
                              "femininePlural2nd","femininePlural2ndPr",
                              "plural3nd","plural3ndPr"]

let namesFieldsImperative = ["masculineSingular","masculineSingularPr",
                             "feminineSingular","feminineSingularPr",
                             "plural","pluralPr"]

let nameTable = "hebrew"


