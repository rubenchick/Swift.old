//
//  ScrollViewController.swift
//  Test Help Info
//
//  Created by Anton Rubenchik on 21/01/2019.
//  Copyright © 2019 Anton Rubenchik. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
//    let text = "леэзок לֶאֱזוֹק"
    let text = "home антоя go to shopping"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        print(takeDifferentWordsForm(commonWord: text).hebrew)
        print(" ---- ")
        print(takeDifferentWordsForm(commonWord: text).russia)

    }
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
            let min : UTF16.CodeUnit = 1000
            let max : UTF16.CodeUnit = 1200
            
            var position : Int = 0
            var positionTemp : Int = 0
       
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
                    positionTemp += 1
                }
                return position
            }
            return 0
    }
    
    func takeDifferentWordsForm(commonWord: String) -> (hebrew: String, russian: String ) {
        var newHebrew:  String
        var newRussian: String
        // lookFor Russian Word
        
        newRussian = commonWord
        newRussian.removeLast(lookForPosition(inWord: commonWord, typeOfSearch: .max, typeOfLanguage: .hebrew))
        newRussian.removeFirst(lookForPosition(inWord: commonWord, typeOfSearch: .min, typeOfLanguage: .hebrew))
        
        newHebrew = commonWord
        
        
        
        
//        print("Начало слова \(lookForPosition(inWord: commonWord, typeOfSearch: .min, typeOfLanguage: .hebrew))")
//        print("Конец слова \(lookForPosition(inWord: commonWord, typeOfSearch: .max, typeOfLanguage: .hebrew))")
        
        // lookFor Hebrew Word
        
        for i in commonWord.utf16 {
            print(i)
        }
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
    

}
