//
//  model.swift
//  Learn Hebrew
//
//  Created by Anton Rubenchik on 09.08.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import Foundation

struct WordForLearning {
    var foreign : String = ""
    var original: String = ""
    var isLearned: Bool = false
    var levelOfLearning: Int = 0
    var thisLevelFromDate: Date? = nil
    var dontWantToLearn : Bool = false
    var image : String = ""
    var mistake : Int = 0
    var discription: String? = ""
    var simple: String? = ""
}
/*
levelOfLearning
 0 - none
 1 - first time  // Group 0 - 2
 2 - second time // Group 1 - 3  // 3 min
 3 - third time  // Group 2 - 4  // 1 hour
 4 - four time  // Group 2 - 4  // 1 day
 5 - five time   // Group 4 - 3  // 3 day
 6 - six time   // Group 4 - 3  // 1 week
 7 - seven time   // Group 4 - 3  // 1 month
 8 - eight time   // Group 4 - 3  // 3 month
 9 - nine time   // Group 4 - 3  // 1 year
 
 If 1 mistake = 2 times this level
 If > 2 mistake => Level = 1
 
Group 0
Знакомство (Произношение! + картинка! + написание! + перевод!)
Произношение! + Написание Да/Нет -> if no -> Знакомство

Group 1
Картинка! написание? (выбор из 4-х слов) -> Знакомство
Картинка! перевод? (выбор из 4-х слов) -> Знакомство
Картинка! + перевод! написание? (выбор из 4-х слов) -> Знакомство
 
Group 2
Произношение! написание? (выбор из 4-х слов)
Произношение! картинка? (выбор из 4-х слов)
Произношение! + Написание! перевод? (выбор из 4-х слов)

Group 3
Составление слова из букв
Произношение! + перевод? (выбор из 4-х слов)
 
Group 4
Написание слова по произношению
Написание слова по переводу
 
 */


