//
//  ViewController.swift
//  Test Core Data for Learning Project
//
//  Created by Anton Rubenchik on 21.08.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
// 1.+ Создать модель данных
// 3.+ Загрузить массив word из CoreData
// 4.+ Изменить массив
// 5.+ Сохранить массив word в CoreData

//+ Записать одну запись
//+ Счиитать все записи


import UIKit
import CoreData

class ViewController: UIViewController {
    var wordArray : [WordForLearning] = []
    var wordsCoreDataArray : [Words] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        readRecords()    // Worked
        addNewWords() // добавляет в базу новые слова для изучения
//        readRecords()    // Worked
//        changeData()
//        createRecord()  // Worked
//         readRecords()    // Worked
//        deleteRecord() // Worked

//        createArray() // выбирает из базы нужные для изучения слова

    }
    func  changeData() {
        if !wordsCoreDataArray.isEmpty {
            wordsCoreDataArray[2].levelOfLearning = 2
            wordsCoreDataArray[1].levelOfLearning = 1
        }
        CoreDataManager.instance.saveContext()
    }
    func readRecords() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Words")
        let predicate = NSPredicate(format: "%K == %@", "isLearned", NSNumber(value: false))
        request.predicate = predicate
        do {
            let words = try CoreDataManager.instance.persistentContainer.viewContext.fetch(request) as! [Words]
            wordsCoreDataArray = words
            print(wordsCoreDataArray.count)
            if wordsCoreDataArray.count > 0 {
                for word in wordsCoreDataArray {
                    print("Слово -",word.foreign," ; Уровень -",word.levelOfLearning)
                }
            }
        } catch {
            print(error)
        }
    }
    //MARK:- Work with Array
    private func createArray() {


        wordArray.append(WordForLearning(foreign: "Sun", original: "Солнце", isLearned: false, levelOfLearning: 0, nextContact: nil, dontWantToLearn: false, image: "sun", mistake: 0, discription: nil, simple: nil))
    }
    
    func addNewWords() {
        // #доделать Подгружать данные из FireBase
        let wordsFromAddArray = AddNewWords()
        for wordFromAddArray in wordsFromAddArray.newWordsArray {
            // проверем слово на уникальность по названию картинки
            let filteredArray = wordsCoreDataArray.filter({ (word) -> Bool in
                return word.image != wordFromAddArray.image ? false : true
            })
            
            if filteredArray.count == 0 {
                let newWord = Words()
                newWord.foreign = wordFromAddArray.foreign
                newWord.original = wordFromAddArray.original
                newWord.isLearned = wordFromAddArray.isLearned
                newWord.levelOfLearning = Int32(wordFromAddArray.levelOfLearning)
                if wordFromAddArray.nextContact != nil {
                    newWord.nextContact = wordFromAddArray.nextContact as! NSDate
                }
                newWord.dontWantToLearn = wordFromAddArray.dontWantToLearn
                newWord.image = wordFromAddArray.image
                newWord.mistake = Int32(wordFromAddArray.mistake)
                newWord.discription = wordFromAddArray.discription
                newWord.simple = wordFromAddArray.simple
                CoreDataManager.instance.saveContext()
            } else {
                print(wordFromAddArray.foreign," в базе слов на изучение уже есть")
            }
        }
    }
    
    func createRecord() {
        let word = Words()
        word.foreign = "Sun"
        word.original = "Солнце"
        word.isLearned = false
        word.levelOfLearning = 0
        word.nextContact = nil
        word.dontWantToLearn = false
        word.image = "sun"
        word.mistake = 0
        word.discription = nil
        word.simple = nil
        CoreDataManager.instance.saveContext()
        
    }
    
    func deleteRecord() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Words")
        
        do {
            let words = try CoreDataManager.instance.persistentContainer.viewContext.fetch(request) as! [NSManagedObject]
            if words.count > 0 {
                for word in words {
                    CoreDataManager.instance.persistentContainer.viewContext.delete(word)
                }
                CoreDataManager.instance.saveContext()
                print("Delete complited")
            }
        } catch {
            print(error)
        }
        
    }
}

