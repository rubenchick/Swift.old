//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Foundation

// 0. Взять грязные данные и разложить их
// 1. Положить данные на сервер // разработать механизм подгрузки данных на сервер
// 2. При загрузке программы, проверять наличие обноввления на сервере
// 3. Сохранять в Core Data
// 4. Реализовать интерфйс 2 стр //поиск и карточка слова
// 5. Реализовать поиск
// 6. Разместить в App Store

// 0.
extension String {
    subscript(value: CountableClosedRange<Int>) -> Substring {
        get {
            return self[index(at: value.lowerBound)...index(at: value.upperBound)]
        }
    }
    
    subscript(value: CountableRange<Int>) -> Substring {
        get {
            return self[index(at: value.lowerBound)..<index(at: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeUpTo<Int>) -> Substring {
        get {
            return self[..<index(at: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeThrough<Int>) -> Substring {
        get {
            return self[...index(at: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeFrom<Int>) -> Substring {
        get {
            return self[index(at: value.lowerBound)...]
        }
    }
    
    func index(at offset: Int) -> String.Index {
        return index(startIndex, offsetBy: offset)
    }
}

extension String {
    subscript(value: NSRange) -> Substring {
        return self[value.lowerBound..<value.upperBound]
    }
}
let text = """
גּוֹוְעוֹת
говъот
"""

enum TypeOfSearch {
    case min,max
}
enum TypeOfLanguage {
    case russian
    case hebrew
    case english
}

func lookForPosition(inWord: String, typeOfSearch:TypeOfSearch, typeOfLanguage: TypeOfLanguage) ->
    (Int) {
        // block know min and max
        let min : UTF16.CodeUnit = 1400
        let max : UTF16.CodeUnit = 1600
        
        var position : Int = 0
        var positionTemp : Int = 0
//        for i in inWord.utf16 {
////            print(i,i > min && i < max ? "Yes" : "No", position)
//            print(i,position)
//            position += 1
//        }
        switch typeOfSearch {
        case .min:
            for i in inWord.utf16 {
                //                    print(i)
                if i > min && i < max {
                    return position
                }
                position += 1
            }
        case .max:
            for i in inWord.utf16 {
                //                    print(i,min,max,positionTemp)
                if i > min && i < max {
                    position = positionTemp
                }
                if i > 1488 { positionTemp += 1 }
            }
            return position
        }

        
        return 0
}

func takeWordsFrom(commonWord: String) -> (hebrew: String, russian: String ) {
    var newHebrew:  String
    var newRussian: String
    // lookFor Russian Word
    
    newRussian = commonWord
//    newRussian.removeLast(lookForPosition(inWord: commonWord, typeOfSearch: .max, typeOfLanguage: .hebrew))
//    newRussian.removeFirst(lookForPosition(inWord: commonWord, typeOfSearch: .min, typeOfLanguage: .hebrew))
    print(lookForPosition(inWord: commonWord, typeOfSearch: .max, typeOfLanguage: .hebrew))
    print(lookForPosition(inWord: commonWord, typeOfSearch: .min, typeOfLanguage: .hebrew))
//    let text = "Hello world"
//    print(commonWord[...3]) // "Hell"
//    text[6..<text.count] // world
    let startPosition = lookForPosition(inWord: commonWord, typeOfSearch: .min, typeOfLanguage: .hebrew)
    let length = lookForPosition(inWord: commonWord, typeOfSearch: .max, typeOfLanguage: .hebrew) - startPosition + 1
    
    print(commonWord[NSRange(location: startPosition, length: length)]) // wor
//    print(commonWord[NSRange(location: 0, length: 5)])
    newHebrew = commonWord

    
    
    //        print("Начало слова \(lookForPosition(inWord: commonWord, typeOfSearch: .min, typeOfLanguage: .hebrew))")
    //        print("Конец слова \(lookForPosition(inWord: commonWord, typeOfSearch: .max, typeOfLanguage: .hebrew))")
    
    // lookFor Hebrew Word
    
//    for i in commonWord.utf16 {
//        print(i)
//    }
    
    
    //        print(" ")
    //        for i in commonWord.unicodeScalars{
    //            print(i)
    //        }
    //        print(" ")
    //        for i in commonWord
    //        {
    //            print(i)
    //        }
    
    
    //        newHebrew = "66"
    //        newRussian = "77"
    return (newHebrew,newRussian)
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
func deleteStar(fromText text: String) -> (String) {
    var cleanWord = ""
    for i in text.unicodeScalars {
        if i.value != 42 {
            cleanWord = cleanWord + String(i)
        }
    }
    
    return cleanWord
}

let translation  = "уст(לת-)роить (ddddd) засаду кому-л. (ת--)"
let txt2 = "לַלמד"
var text3 = "*)*("
print(deletePreposition(fromText: translation).0)
print(deletePreposition(fromText: translation).1)
print(deleteStar(fromText: text3))
//for i in txt2.unicodeScalars{
//    if (i.value < 1515 && i.value > 1487) || (i.value == 32) {
//        text3 = text3 + String(i)
//    }
//}
for i in text3.unicodeScalars {
    print(i,i.value)
}
//print(text3.unicodeScalars)
//print(txt1 == text3)



//var str : String  = "6"
//let sparklingHeart = "\u{05D1}"

//let unicodeScalarValueOfA = 1490
//let convertedA = "A".unicodeScalars

// Hexadecimal to decimal
//let h2 = "FB25"
//let d4 = Int(h2, radix: 16)!
//print(d4) // 163

//for i in 0...25
//{
//    let string = String(format: "%c", 1491) as String
//    print(string)
//}

//let sparklingHeart2 = "\u$h2"
//str = str + sparklingHeart + sparklingHeart2
//print(str)
//let x = takeWordsFrom(commonWord: text).russian

//print(text)
//print(" ---- ")
//print(takeDifferentWordsForm(commonWord: text).russia)

//let text2 = "גּוֹוְעוֹת"
//print(text2)
//print(text2.sc)
//
//var text3 = ""
////let text4 = "וּ‬אבֵא  טּוב"
//let text4 = """
//גּוֹוְעוֹת
//говъот
//"""
//for i in text4.utf8 {
//    print(i)
//}
//print(" ")
//for i in text4.utf16 {
//    print(i)
//}
//print(" ")
//for i in text4.unicodeScalars{
////    print(i.value)
//    if (i.value < 1515 && i.value > 1487) || (i.value == 32) {
//        text3 = text3 + String(i)
//    }
//}
////    print(i)
//print(text3)
//print(" ")
//for i in text4
//{
//    print(i)
//}
//for i in text2.utf16 {
//    if i > 1488 { print(i) }
//}
//
//print("   ----    ")
//for i in text2.utf16 {
//    print(i)
//}


//for j in text2.unicodeScalars{
//    print(j)
//    text3 = text3 + String(j)
//}
//print(text3)

