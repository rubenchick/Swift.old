//
//  CreateData.swift
//  Verbs.Hebrew
//
//  Created by Anton Rubenchik on 08/02/2019.
//  Copyright © 2019 Anton Rubenchik. All rights reserved.
//

// Парт1
// Создать модель выгрузки данных. Отдельный файл
// Создать массив данный из выгрузки
// Вывод информации
// Карточка слова

// Парт2
// Механизм выгрузки из Экселя в Firebase (в одтельную программу)
// Механизм выгрузки из Firebase нового контента в CoreData
// Поиск

import Foundation

//V 0. Взять грязные данные и разложить их
//V 1. Положить данные на сервер // разработать механизм подгрузки данных на сервер
// 2. При загрузке программы, проверять наличие обноввления на сервере
// 3. Сохранять в Core Data
//V 4. Реализовать интерфйс 2 стр //поиск и карточка слова
// 5. Реализовать поиск (по всем полям)
// 6. Разместить в App Store

// 0.

// take data from addModule and write to array
class CreateData {
    
    func lookForPosition(inWord: String, typeOfSearch:TypeOfSearch, typeOfLanguage: TypeOfLanguage) ->
        (Int) {
            // choose max and min uft
            let minUTF, maxUTF : UTF16.CodeUnit
            switch typeOfLanguage {
            case .english:
                minUTF = Utf16Parameter.englishMin.rawValue
                maxUTF = Utf16Parameter.englishMax.rawValue
            case .hebrew:
                minUTF = Utf16Parameter.hebrewMin.rawValue
                maxUTF = Utf16Parameter.hebrewMax.rawValue
            case .russian:
                minUTF = Utf16Parameter.russianMin.rawValue
                maxUTF = Utf16Parameter.russianMax.rawValue
            case .spanish:
                minUTF = Utf16Parameter.spanishMin.rawValue
                maxUTF = Utf16Parameter.spanishMax.rawValue
            }
            
            
            var position : Int = 0
            var positionTemp : Int = 0
            
            switch typeOfSearch {
            case .min:
                for i in inWord.unicodeScalars {
                    if i.value > minUTF && i.value < maxUTF {
                        return position
                    }
                    position += 1
                }
            case .max:
                for i in inWord.unicodeScalars {
                    if i.value > minUTF && i.value < maxUTF {
                        position = positionTemp
                    }
                    //                    if i > 1488 { positionTemp += 1 } //hebrew word without dagest
                    positionTemp += 1
                }
                return position
            }
            
            
            return 0
    }
    
    func takeWordsFrom(commonWord: String, toLanguage: TypeOfLanguage) -> (String) {
        var newWord: String = ""
        
        let startPosition, endPosition: Int
        // choose position word in String
        switch toLanguage {
        case .hebrew:
            startPosition = lookForPosition(inWord: commonWord, typeOfSearch: .max, typeOfLanguage: .hebrew)
            endPosition = lookForPosition(inWord: commonWord, typeOfSearch: .min, typeOfLanguage: .hebrew)
        case .russian:
            startPosition = lookForPosition(inWord: commonWord, typeOfSearch: .max, typeOfLanguage: .russian)
            endPosition = lookForPosition(inWord: commonWord, typeOfSearch: .min, typeOfLanguage: .russian)
        case .english:
            startPosition = lookForPosition(inWord: commonWord, typeOfSearch: .max, typeOfLanguage: .english)
            endPosition = lookForPosition(inWord: commonWord, typeOfSearch: .min, typeOfLanguage: .english)
        case .spanish:
            startPosition = lookForPosition(inWord: commonWord, typeOfSearch: .max, typeOfLanguage: .spanish)
            endPosition = lookForPosition(inWord: commonWord, typeOfSearch: .min, typeOfLanguage: .spanish)
        }
        
        var numberLetter = 0
        for i in commonWord.unicodeScalars{
            if numberLetter <= startPosition && numberLetter >= endPosition {
                newWord = newWord + String(i)
            }
            numberLetter += 1
        }
        return newWord
    }
    // For short code
    func createTranslation(typeOfLanguage: TypeOfLanguage, text: String) -> (Translation){
        var translation = Translation()
        switch typeOfLanguage {
        case .russian: translation.russian = text
        case .english: translation.english = text
        case .spanish: translation.spanish = text
        default:
            print("correct")
        }
        
        return translation
    }
    
    func deletePreposition(fromText text: String) -> (String,String) {
        var preposition = ""
        var tempText = ""
        var currentText = ""
        var isStart = false
        var isPreposition = false
        var isPrepositionClose = false
        
        for i in text.unicodeScalars {
            currentText = currentText + String(i)
            if i.value == 40 {
                isStart = true
            } else {
                if i.value == 41 {
                    isStart = false
                    if isPreposition {
                        currentText = tempText
                        isPrepositionClose = true
                    } else {
                        tempText = currentText
                    }
                    isPreposition = false
                    
                } else {
                    if i.value > 1400 && i.value < 1600 && isStart {
                        isPreposition = true
                    }
                    if isPreposition {
                        if !isPrepositionClose {
                            preposition = preposition + String(i)
                        }
                    }
                }
            }
            if !isStart && i.value != 41 {
                tempText = tempText + String(i)
            }
        }
        return (currentText,preposition)
    }
    
    func convertToCoreDataFormat(fromExcelFormatData excelArray: BlackWord) -> (Word) {
        var newWord = Word()
        var translation = Translation()
        
        newWord.infinitive = takeWordsFrom(commonWord: excelArray.infinitive , toLanguage: .hebrew)
        newWord.infinitiveP = createTranslation(typeOfLanguage: actualLanguage,
                                                text: takeWordsFrom(commonWord: excelArray.infinitive , toLanguage: actualLanguage))
        let (cleanTranslation,preposition) = deletePreposition(fromText: excelArray.translation)
        switch actualLanguage {
        case .russian: translation.russian = cleanTranslation
        case .english: translation.english = cleanTranslation
        case .spanish: translation.spanish = cleanTranslation
        default:
            print("correct")
        }
        newWord.translation = translation
        newWord.preposition = preposition
        //        newWord.translation = createTranslation(typeOfLanguage: actualLanguage, text: excelArray.translation)
        
        
        // PresentTens
        var presentTense = PresentTense()
        presentTense.masculineSingular      = takeWordsFrom(commonWord: excelArray.presentMS , toLanguage: .hebrew)
        presentTense.masculineSingularPr    = createTranslation(typeOfLanguage: actualLanguage,
                                                                text: takeWordsFrom(commonWord: excelArray.presentMS , toLanguage: actualLanguage))
        presentTense.feminineSingular       = takeWordsFrom(commonWord: excelArray.presentFS , toLanguage: .hebrew)
        presentTense.feminineSingularPr     = createTranslation(typeOfLanguage: actualLanguage,
                                                                text: takeWordsFrom(commonWord: excelArray.presentFS , toLanguage: actualLanguage))
        presentTense.masculinePlural        = takeWordsFrom(commonWord: excelArray.presentMP , toLanguage: .hebrew)
        presentTense.masculinePluralPr      = createTranslation(typeOfLanguage: actualLanguage,
                                                                text: takeWordsFrom(commonWord: excelArray.presentMP , toLanguage: actualLanguage))
        presentTense.femininePlural         = takeWordsFrom(commonWord: excelArray.presentFP , toLanguage: .hebrew)
        presentTense.femininePluralPr       = createTranslation(typeOfLanguage: actualLanguage,
                                                                text: takeWordsFrom(commonWord: excelArray.presentFP , toLanguage: actualLanguage))
        newWord.presentTense = presentTense
        
        // PresentTens
        var pastTense = PastTense()
        pastTense.singular1st            = takeWordsFrom(commonWord: excelArray.past1S, toLanguage: .hebrew)
        pastTense.singular1stPr          = createTranslation(typeOfLanguage: actualLanguage,
                                                             text: takeWordsFrom(commonWord: excelArray.past1S, toLanguage: actualLanguage))
        pastTense.masculineSingular2nd   = takeWordsFrom(commonWord: excelArray.past2MS, toLanguage: .hebrew)
        pastTense.masculineSingular2ndPr = createTranslation(typeOfLanguage: actualLanguage,
                                                             text: takeWordsFrom(commonWord: excelArray.past2MS, toLanguage: actualLanguage))
        pastTense.feminineSingular2nd    = takeWordsFrom(commonWord: excelArray.past2FS, toLanguage: .hebrew)
        pastTense.feminineSingular2ndPr  = createTranslation(typeOfLanguage: actualLanguage,
                                                             text: takeWordsFrom(commonWord: excelArray.past2FS, toLanguage: actualLanguage))
        pastTense.masculineSingular3nd   = takeWordsFrom(commonWord: excelArray.past3MS, toLanguage: .hebrew)
        pastTense.masculineSingular3ndPr = createTranslation(typeOfLanguage: actualLanguage,
                                                             text: takeWordsFrom(commonWord: excelArray.past3MS, toLanguage: actualLanguage))
        pastTense.feminineSingular3nd    = takeWordsFrom(commonWord: excelArray.past3FS, toLanguage: .hebrew)
        pastTense.feminineSingular3ndPr = createTranslation(typeOfLanguage: actualLanguage,
                                                            text: takeWordsFrom(commonWord: excelArray.past3FS, toLanguage: actualLanguage))
        pastTense.plural1st              = takeWordsFrom(commonWord: excelArray.past1P, toLanguage: .hebrew)
        pastTense.plural1stPr            = createTranslation(typeOfLanguage: actualLanguage,
                                                             text: takeWordsFrom(commonWord: excelArray.past1P, toLanguage: actualLanguage))
        pastTense.masculinePlural2nd     = takeWordsFrom(commonWord: excelArray.past2MP, toLanguage: .hebrew)
        pastTense.masculinePlural2ndPr   = createTranslation(typeOfLanguage: actualLanguage,
                                                             text: takeWordsFrom(commonWord: excelArray.past2MP, toLanguage: actualLanguage))
        pastTense.femininePlural2nd      = takeWordsFrom(commonWord: excelArray.past2FP, toLanguage: .hebrew)
        pastTense.femininePlural2ndPr    = createTranslation(typeOfLanguage: actualLanguage,
                                                             text: takeWordsFrom(commonWord: excelArray.past2FP, toLanguage: actualLanguage))
        pastTense.plural3nd              = takeWordsFrom(commonWord: excelArray.past3P, toLanguage: .hebrew)
        pastTense.plural3ndPr            = createTranslation(typeOfLanguage: actualLanguage,
                                                             text: takeWordsFrom(commonWord: excelArray.past3P, toLanguage: actualLanguage))
        newWord.pastTense = pastTense
        
        // FutureTense
        var futureTense = FutureTense()
        futureTense.singular1st            = takeWordsFrom(commonWord: excelArray.future1S, toLanguage: .hebrew)
        futureTense.singular1stPr          = createTranslation(typeOfLanguage: actualLanguage,
                                                               text: takeWordsFrom(commonWord: excelArray.future1S, toLanguage: actualLanguage))
        futureTense.masculineSingular2nd   = takeWordsFrom(commonWord: excelArray.future2MS, toLanguage: .hebrew)
        futureTense.masculineSingular2ndPr = createTranslation(typeOfLanguage: actualLanguage,
                                                               text: takeWordsFrom(commonWord: excelArray.future2MS, toLanguage: actualLanguage))
        futureTense.feminineSingular2nd    = takeWordsFrom(commonWord: excelArray.future2FS, toLanguage: .hebrew)
        futureTense.feminineSingular2ndPr  = createTranslation(typeOfLanguage: actualLanguage,
                                                               text: takeWordsFrom(commonWord: excelArray.future2FS, toLanguage: actualLanguage))
        futureTense.masculineSingular3nd   = takeWordsFrom(commonWord: excelArray.future3MS, toLanguage: .hebrew)
        futureTense.masculineSingular3ndPr = createTranslation(typeOfLanguage: actualLanguage,
                                                               text: takeWordsFrom(commonWord: excelArray.future3MS, toLanguage: actualLanguage))
        futureTense.feminineSingular3nd    = takeWordsFrom(commonWord: excelArray.future3FS, toLanguage: .hebrew)
        futureTense.feminineSingular3ndPr = createTranslation(typeOfLanguage: actualLanguage,
                                                              text: takeWordsFrom(commonWord: excelArray.future3FS, toLanguage: actualLanguage))
        futureTense.plural1st              = takeWordsFrom(commonWord: excelArray.future1P, toLanguage: .hebrew)
        futureTense.plural1stPr            = createTranslation(typeOfLanguage: actualLanguage,
                                                               text: takeWordsFrom(commonWord: excelArray.future1P, toLanguage: actualLanguage))
        futureTense.masculinePlural2nd     = takeWordsFrom(commonWord: excelArray.future2MP, toLanguage: .hebrew)
        futureTense.masculinePlural2ndPr   = createTranslation(typeOfLanguage: actualLanguage,
                                                               text: takeWordsFrom(commonWord: excelArray.future2MP, toLanguage: actualLanguage))
        futureTense.femininePlural2nd      = takeWordsFrom(commonWord: excelArray.future2FP, toLanguage: .hebrew)
        futureTense.femininePlural2ndPr    = createTranslation(typeOfLanguage: actualLanguage,
                                                               text: takeWordsFrom(commonWord: excelArray.future2FP, toLanguage: actualLanguage))
        futureTense.plural3nd              = takeWordsFrom(commonWord: excelArray.future3MP, toLanguage: .hebrew)
        futureTense.plural3ndPr            = createTranslation(typeOfLanguage: actualLanguage,
                                                               text: takeWordsFrom(commonWord: excelArray.future3MP, toLanguage: actualLanguage))
        newWord.futureTense = futureTense
        
        // Imperative
        var imperative = Imperative()
        imperative.masculineSingular      = takeWordsFrom(commonWord: excelArray.imperativeMS , toLanguage: .hebrew)
        imperative.masculineSingularPr    = createTranslation(typeOfLanguage: actualLanguage,
                                                              text: takeWordsFrom(commonWord: excelArray.imperativeMS , toLanguage: actualLanguage))
        imperative.feminineSingular       = takeWordsFrom(commonWord: excelArray.imperativeFS , toLanguage: .hebrew)
        imperative.feminineSingularPr     = createTranslation(typeOfLanguage: actualLanguage,
                                                              text: takeWordsFrom(commonWord: excelArray.imperativeFS , toLanguage: actualLanguage))
        imperative.plural                 = takeWordsFrom(commonWord: excelArray.imperativeMP , toLanguage: .hebrew)
        imperative.pluralPr               = createTranslation(typeOfLanguage: actualLanguage,
                                                              text: takeWordsFrom(commonWord: excelArray.imperativeMP , toLanguage: actualLanguage))
        newWord.imperative = imperative
        
        
        return newWord
    }
    
    func fillArray() -> () {
        let wordsFromAddArray = AddNewWords()
        
        // convert all new words
        for word in wordsFromAddArray.newWordsArray {
            wordsArray.append(convertToCoreDataFormat(fromExcelFormatData: word))
        }
    }
}
