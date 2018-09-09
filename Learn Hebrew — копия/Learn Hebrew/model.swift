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
    var nextContact: Date? = nil
    var dontWantToLearn : Bool = false
    var image : String = ""
    var mistake : Int = 0
    var discription: String? = ""
    var simple: String? = ""
}
/*
levelOfLearning
 0 - none           // Group 0 - 2                  +V
 1 - first time     // Group 1 - 3  // 3 min
 2 - second time    // Group 2 - 4  // 1 hour
 3 - third time     // Group 2 - 4  // 1 day
 4 - four time      // Group 4 - 3  // 3 day
 5 - five time      // Group 4 - 3  // 1 week
 6 - six time       // Group 4 - 3  // 1 month
 7 - seven time     // Group 4 - 3  // 3 month
 8 - eight time     // Group 4 - 3  // 1 year

 
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
/*
 //////////
 levelOfLearning1
 
 1 - first time     // Group 1 - 3  // 3 min
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

 case pictureChooseWrite
 case pictureChooseTranslate
 case pictureAndTranslateChooseWrite
 case prononceChooseWrite
 case prononceChoosePicture
 case prononceAndWriteChooseTranslate
 case prononceChooseTranslate
 case writeChoosePicture
 
 //////////
 levelOfLearning2
 2 - second time    // Group 2 - 4  // 1 hour
 
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


 case prononceChooseWrite
 case prononceChoosePicture
 case prononceAndWriteChooseTranslate
 case prononceChooseTranslate
 case writeFromPrononce
 case writeFromTranslate
 case writeChoosePicture
 
 //////////
  levelOfLearning3
  4 - four time      // Group 4 - 3  // 3 day
 Group 3
 Составление слова из букв
 Произношение! + перевод? (выбор из 4-х слов)
 
 Group 4
 Написание слова по произношению
 Написание слова по переводу

 prononceChooseTranslate
 writeFromPrononce
 writeFromTranslate

*/
