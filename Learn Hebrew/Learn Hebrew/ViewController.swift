//
//  ViewController.swift
//  Learn Hebrew
//
//  Created by Anton Rubenchik on 09.08.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
/* Доделать #доделать
 1. Загружать данные из CoreData
 2. Сохранять данные в CoreData
 3. Подгружать данные из FireBase // в последнюю очередь
 4. Мигание при парсинге. Новое значение для кнопок
 5. При неправильном выборе, указывать что означает выбранное слово
 6. Добавить картинку к карточке type 6. Написать по переводу

 TAG
 1-4 for button choose group typeOfCard = 3
*/

import UIKit
import AVFoundation
import Foundation
import CoreData


class ViewController: UIViewController {
    //MARK: VAR && LET
    // array words for learning this iteration
    var wordArray : [WordForLearning] = []
    // Full array words for learning
    var wordsCoreDataArray : [Words] = []
    // array cards for learning this iteration
    var wordForLearningInThisIteration : [(Int,TypeOfCard,Bool)] = []
    var informationAboutSituation = "" // Information about progress of learning
    var countIterationToday = 0 // Information about count interation today
    var meetCardView = UIView()
    var type2CardView = UIView()
    var type3CardView = UIView()
    var type4CardView = UIView()
    var type5CardView = UIView()
    var type6CardView = UIView()
    var type7CardView = UIView()
    var startPage = UIView()
    var progressLine = UIProgressView()
    var prononceLabel = UILabel()
    
    let textField = UITextField()
    
    let backgroundForWord = UIColor(red: 51/255, green: 153/255, blue: 255/255, alpha: 1)
    let colorHolderForWord = UIColor(red: 102/255, green: 204/255, blue: 255/255, alpha: 1)
    let backgroundDoneButton = UIColor(red: 51/255, green: 204/255, blue: 102/255, alpha: 1)
    
    let cardForMeeting : [TypeOfCard] = [.meeting,
                                         .trueOrFalse,
                                         .pictureAndTranslateChooseWrite,
                                         .pictureChooseWrite]
    let cardForLevel0 : [TypeOfCard] = [.pictureChooseWrite,
                                        .writeChoosePicture,
                                        .pictureAndTranslateChooseWrite,
                                        .prononceChooseWrite,
                                        .prononceChoosePicture,
                                        .prononceAndWriteChooseTranslate]
    let cardForLevel1 : [TypeOfCard] = [.pictureChooseWrite,
                                        .pictureChooseTranslate,
                                        .pictureAndTranslateChooseWrite,
                                        .prononceChooseWrite,
                                        .prononceChoosePicture,
                                        .prononceAndWriteChooseTranslate,
                                        .prononceChooseTranslate,
                                        .writeChoosePicture]
    let cardForLevel2 : [TypeOfCard] = [.prononceChooseWrite,
                                        .prononceChoosePicture,
                                        .prononceAndWriteChooseTranslate,
                                        .prononceChooseTranslate,
                                        .writeFromPrononce,
                                        .writeFromTranslate,
                                        .writeChoosePicture]
    
    let cardForLevel3 : [TypeOfCard] = [.prononceChooseTranslate,
                                        .writeFromPrononce,
                                        .writeFromTranslate]
    
    var numberCard = 0
    var correctAnswer = ""
    var countWordInOneIteration = 10
    let testWord = WordForLearning(foreign: "test", original: "тест", isLearned: false, levelOfLearning: 0, nextContact: nil, dontWantToLearn: false, image: "sun", mistake: 0, discription: nil, simple: nil)
    
    let requestWordArray : [String] = ["חֶ","חֲ","חָ","קֶ","קֲ","קָ","רֶ","רֲ","רָ","אֶ","אֲ","אָ","טֶ","טֲ","טָ",
                                       "וֲ","וָ","וֶ","וֲֹ","וָֹ","וֶֹ","פֶ","פֲ","פָ","פֲּ","פָּ","פֶּ","שֲ","שָ","שֶ",
                                       "דֶ","דֲ","דָ","גֶ","גֲ","גָ","כֶ","כֲ","כָ","כֲּ","כָּ","כֶּ","עֶ","עֲ","עָ",
                                       "וֲּ","וָּ","וֶּ","יֲ","יָ","יֶ","לֶ","לֲ","לָ","זֶ","זֲ","זָ","סֶ","סֲ","סָ",
                                       "בֶ","בֲ","בָ","בֲּ","בָּ","בֶּ","הֶ","הֲ","הָ","נֲ","נָ","נֶ","מֶ","מֲ","מָ",
                                      "תֶּ","תָּ","תֲּ","הֶּ","הָּ","הֲּ","צֶ","צֲ","צָ","תֶ","תָ","תֲ"]
    let answerWordArray : [String]  = ["חֵ","חַ","חַ","קֵ","קַ","קַ","רֵ","רַ","רַ","אֵ","אַ","אַ","טֵ","טַ","טַ",
                                       "וַ","וַ","וֵ","וַֹ","וַֹ","וֵֹ","פֵ","פַ","פַ","פַּ","פַּ","פֵּ","שַ","שַ","שֵ",
                                       "דֵ","דַ","דַ","גֵ","גַ","גַ","כֵ","כַ","כַ","כַּ","כַּ","כֵּ","עֵ","עַ","עַ",
                                       "וַּ","וַּ","וֵּ","יַ","יַ","יֵ","לֵ","לַ","לַ","זֵ","זַ","זַ","סֵ","סַ","סַ",
                                       "בֵ","בַ","בַ","בַּ","בַּ","בֵּ","הֵ","הַ","הַ","נַ","נַ","נֵ","מֵ","מַ","מַ",
    "תֵּ","תַּ","תַּ","הֵּ","הַּ","הַּ","צֵ","צַ","צַ","תֵ","תַ","תַ"]
    
    // MARK: -
    // MARK: - viewDidLoad()
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //--- Delete block
// // // // // //       deletRecord() // Worked
        //---
        
        //--- Work block
        
        readRecords(typeOfRequest: .all)    // Загружаем все записи из CoreData
        addNewWords()        // Добавляем новые слова
        createMaketOfCards() // Создаем макеты карточке
        showStartPage()
        
        //---
        
        
        //--- Correct block
//        correctCoreData() // if need
        //---
//
//        let speakTalk   = AVSpeechSynthesizer()
//        let speakMsg    = AVSpeechUtterance(string: "אַחַת עֵשׂרֶא")
//        speakMsg.voice  = AVSpeechSynthesisVoice(language: "he-IL")
//        speakMsg.pitchMultiplier = 1.2
//        speakMsg.rate   = 0.5
//        speakTalk.speak(speakMsg)
//        print("End")
    }
    
    // MARK: - Test CoreData
    
    fileprivate func correctCoreData() {
        // запускаем цикл изучения + прогресс
        
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Words")
        let predicate = NSPredicate(format: "%K == %@", "image", "bed")
        request.predicate = predicate
        do {
            let wordsForChange = try CoreDataManager.instance.persistentContainer.viewContext.fetch(request) as! [Words]
            print(wordsForChange.count)
            for word in wordsForChange {
//                word.foreign =  "אַנַחנוּ"
//                word.original = "мы"
//                word.isLearned = false
//                word.levelOfLearning = 0
//                word.nextContact = Date() as NSDate
//                word.dontWantToLearn = false
//                word.isLearned = false
                word.image = "bad"
//                word.mistake = 0
//                word.discription = ""
//                word.simple = "шиур"
                print("The correction is finished")
            }
            CoreDataManager.instance.saveContext()
        } catch {
            print(error)
        }
    }
    func readRecords(typeOfRequest: TypeOfRequest) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Words")
//        let predicate = NSPredicate(format: "%K == %@", "isLearned", NSNumber(value: false))
        
        
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        // Get today's beginning & end
        let dateFrom = calendar.startOfDay(for: Date()) // eg. 2016-10-10 00:00:00
        let newDate = calendar.date(byAdding: .day, value: 1, to: dateFrom)!
        print(newDate)
        
//        let fromPredicate = NSPredicate(format: "%K <= %@", "nextContact", newDate as NSDate)
        var fromPredicate = NSPredicate(format: "%K == %@", "isLearned", NSNumber(value: false))
        if typeOfRequest == .actual {
            fromPredicate = NSPredicate(format: "%K <= %@", "nextContact", newDate as NSDate)
        }
        request.predicate = fromPredicate
        do {
            let words = try CoreDataManager.instance.persistentContainer.viewContext.fetch(request) as! [Words]
            wordsCoreDataArray = words
            print(wordsCoreDataArray.count)
            if wordsCoreDataArray.count > 0 {
                for word in wordsCoreDataArray {
                    print(" Слово -",word.foreign," ; Уровень -",word.levelOfLearning," ; Дата -",word.nextContact)
                    // create data to txt file
//                    let dateDiff = Calendar.current.dateComponents([.day], from: dateFrom, to: word.nextContact! as Date).day
//                    var prononce = ""
//                    if word.simple != nil {
//                        prononce = (word.simple as? String)!
//                    }
//                    print("\(word.foreign!)\n\(word.original!)\n\(word.levelOfLearning)\n\(dateDiff!)\n\(word.image!)\n\(word.mistake)\n\(prononce)\n")
                }
            }
        } catch {
            print(error)
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

    // MARK:- Create elements
    private func createLabel(posX: Int, posY: Int, text: String, size: Int)-> UILabel {
        let newLabel = UILabel()
        
        newLabel.text = text
        newLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(size))
        newLabel.sizeToFit()
        newLabel.frame = CGRect(x: CGFloat(posX), y: CGFloat(posY), width: newLabel.frame.width, height: newLabel.frame.height)
        
//        newLabel.textColor =
        //            (text == "Remember the word") || (text == "Remember the translation") ? colorHolderForWord : .white
        switch text {
        case "Remember the word", "Remember the translation": newLabel.textColor = colorHolderForWord
        case "Don't remember": newLabel.textColor = .red
        case "Remember": newLabel.textColor = backgroundDoneButton
        case "Information":
            newLabel.textColor = .black
            newLabel.frame = CGRect(x: CGFloat(posX), y: CGFloat(posY), width: CGFloat(view.frame.width - CGFloat(posX*2)) , height: newLabel.frame.height)
            newLabel.textAlignment = .center
        case "BlackAndLeft":
            newLabel.textColor = .black
            newLabel.frame = CGRect(x: CGFloat(posX), y: CGFloat(posY), width: CGFloat(view.frame.width - CGFloat(posX*2)) , height: newLabel.frame.height)
        case "test":
            newLabel.textColor = .black
        default: newLabel.textColor = .white
        }
        return newLabel
    }
    
    private func createButton(type: TypeOfButton, posX: Int, posY: Int, text: String?, size: Int?, color: UIColor?)-> UIButton {
        let newButton = UIButton(type: .roundedRect)
        switch type {
        case .next:
            newButton.frame = CGRect(x: CGFloat(posX), y: CGFloat(posY), width: view.frame.width, height: CGFloat(view.frame.height/10))
            newButton.setTitle(text, for: .normal)
            newButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
            newButton.setTitleColor(.white, for: .normal)
            newButton.backgroundColor = color
        case .pronunciationNormal:
            newButton.frame = CGRect(x: CGFloat(posX - posY/2), y: CGFloat(posY/4), width: CGFloat(posY/3), height: CGFloat(posY/3))
            newButton.tintColor = .white
            if let newImage = UIImage(named: "speaker") {
             newButton.setImage(newImage, for: .normal)
            }
            newButton.backgroundColor = backgroundForWord
            newButton.addTarget(self, action: #selector(pronunciationWord), for: .touchDown)
        case .pronunciationBig:
            let diameter = posY/2
            newButton.frame = CGRect(x: CGFloat(posX/2 - diameter/2), y: CGFloat(posY/2-diameter/2), width: CGFloat(diameter), height: CGFloat(diameter))
            newButton.tintColor = backgroundForWord
            newButton.backgroundColor = .white
            newButton.layer.cornerRadius = CGFloat(diameter/2)
            if let newImage = UIImage(named: "speaker_big") {
                newButton.setImage(newImage, for: .normal)
            }
            newButton.addTarget(self, action: #selector(pronunciationWord), for: .touchDown)
        case .forget:
            let diameter = posY/7
            newButton.frame = CGRect(x: CGFloat(posX/8), y: CGFloat(posY-diameter*2), width: CGFloat(diameter), height: CGFloat(diameter))
            newButton.tintColor = .white
            newButton.backgroundColor = .red
            newButton.layer.cornerRadius = CGFloat(diameter/2)
            if let newImage = UIImage(named: "forget" ) {
                newButton.setImage(newImage, for: .normal)
            }
        case .remember:
            let diameter = posY/7
            newButton.frame = CGRect(x: CGFloat(posX - posX/8 - diameter), y: CGFloat(posY-diameter*2), width: CGFloat(diameter), height: CGFloat(diameter))
            newButton.tintColor = .white
            newButton.backgroundColor = backgroundDoneButton
            newButton.layer.cornerRadius = CGFloat(diameter/2)
            if let newImage = UIImage(named: "done" ) {
                newButton.setImage(newImage, for: .normal)
            }
        case .choose:
            newButton.frame = CGRect(x: CGFloat(posX), y: CGFloat(posY), width: view.frame.width-CGFloat(posX)*2, height: view.frame.height / 15)
            newButton.setTitle(text, for: .normal)
            newButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
            newButton.setTitleColor(.black, for: .normal)
            newButton.backgroundColor = color
            newButton.layer.borderWidth = 1
            newButton.layer.borderColor = UIColor.gray.cgColor
            newButton.layer.shadowOpacity = 0.6
            newButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        case .choosePicture:
            newButton.frame = CGRect(x: CGFloat(posX), y: CGFloat(posY),
                                     width: view.frame.width/2-10,
                                     height: view.frame.height / 7)
            if let newImage = UIImage(named: "flag" ) {
                newButton.setBackgroundImage(newImage, for: .normal)
                newButton.layoutIfNeeded()
                newButton.subviews.first?.contentMode = .scaleAspectFill
            }
            newButton.layer.borderWidth = 1
            newButton.layer.borderColor = UIColor.gray.cgColor
        }

        return newButton
    }
    
    private func createPicture(type: TypeOfPicture, name: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 20, width: Int(view.frame.width), height: Int(view.frame.height/100*43))
        if let newImage = UIImage(named: name) {
            imageView.image = newImage
        }
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func createFourButton(view: UIView)-> UIView {
        let newView = view
        
        for i in 1..<5 {
            let button = createButton(type: TypeOfButton.choose,
                                      posX: Int(newView.frame.width/10),
                                      posY: Int(newView.frame.height/30*18) + ((i - 1) * Int(newView.frame.height/10)),//
                text: "",// wordArray[i].foreign,
                size: 20,
                color: .white)
            button.tag = i
            newView.addSubview(button)
        }
        return newView
    }
    
    private func createFourPicture(view: UIView)-> UIView {
        let newView = view
        var posX = 0
        var posY = 0
        
        for i in 1..<5 {
            switch i {
            case 1:
                posX = 5
                posY = Int(newView.frame.height/30*18)
            case 2:
                posX = 5
                posY = Int(newView.frame.height/30*24)
            case 3:
                posX = Int(newView.frame.width/2+5)
                posY = Int(newView.frame.height/30*18)
            case 4:
                posX = Int(newView.frame.width/2+5)
                posY = Int(newView.frame.height/30*24)
            default: break
            }
            let button = createButton(type: TypeOfButton.choosePicture,
                                      posX: posX,
                                      posY: posY,
                text: "",
                size: nil,
                color: nil)
            button.tag = i
            newView.addSubview(button)
        }
        return newView
    }
    
    func createProgressLine() {
        progressLine.frame = CGRect(x: 5, y: 20, width: view.frame.width-10, height: 20)
        view.addSubview(progressLine)
    }
    
    // MARK: - @OBJC
    
    @objc func pronunciationWord(){
        let speakTalk   = AVSpeechSynthesizer()
        let speakMsg    = AVSpeechUtterance(string: (wordArray[wordForLearningInThisIteration[numberCard].0].foreign))
        speakMsg.voice  = AVSpeechSynthesisVoice(language: "he-IL")
//        speakMsg.voice  = AVSpeechSynthesisVoice(language: "en-US")
        speakMsg.pitchMultiplier = 1.2
        speakMsg.rate   = 0.5
        speakTalk.speak(speakMsg)
    }
    
    @objc func pressedNext(){
        if wordForLearningInThisIteration[numberCard].1 == .meeting {
            meetCardView.isHidden = true
        } else {
            if wordForLearningInThisIteration[numberCard].1 == .trueOrFalse {
                type2CardView.isHidden = true
            }
        }
        meetCardView.isHidden = true
        if numberCard < wordForLearningInThisIteration.count {
            numberCard += 1
            runLearning(numberCard: numberCard)
        } else {
            print("Обучение закончено")
            
            // Add form
        }
    }
    @objc func pressedStart(){
        if wordArray.count > 3 {
            startPage.isHidden = true
            numberCard = 0
            runLearning(numberCard: numberCard)
        } else {
            print(wordArray.count,"На сегодня слов на изучение больше нет")
        }
    }
    
    @objc func pressedForget(){
        type2CardView.isHidden = true
        if numberCard > 0 {
            numberCard -= 1
            showMeetingCard(word: wordArray[wordForLearningInThisIteration[numberCard+1].0])
        } else {
            showMeetingCard(word: wordArray[wordForLearningInThisIteration[numberCard].0])
        }
    }
    
    func closeCard() {
        // Tag только для очистки
        for i in 1...4 {
            if let button = self.view.viewWithTag(i) as? UIButton {
                button.setTitle("", for: .normal)
            }
        }
        textField.text = ""
//        showMeetingCard(word: wordArray[wordForLearningInThisIteration[numberCard].0])
//        numberCard += 1
        if numberCard + 1 < wordForLearningInThisIteration.count {
            showMeetingCard(word: wordArray[wordForLearningInThisIteration[numberCard].0])
//            runLearning(numberCard: numberCard)
        } else {
            print("Обучение закончено")
            finishIteration()
            // Add form
        }
    }
    
    @objc func chooseButton(button :UIButton){
        
        if let chooseWord = button.titleLabel?.text {
            if chooseWord == correctAnswer {
                print("Answer is correct")
                self.type3CardView.isHidden = true
                self.type4CardView.isHidden = true
                closeCard()
            } else {
                // create new card for repeat mistake card
                let addCard = wordForLearningInThisIteration[numberCard]
                if wordForLearningInThisIteration.count-2 > numberCard {
                wordForLearningInThisIteration.insert(addCard, at: numberCard+2)
                } else {
                    wordForLearningInThisIteration.append(addCard)
                }
                wordForLearningInThisIteration[numberCard].2 = false
                // show alert because mistake
                let text = "'\(wordArray[wordForLearningInThisIteration[numberCard].0].foreign)' переводится как '\(wordArray[wordForLearningInThisIteration[numberCard].0].original)'"
                let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
                let alertButton = UIAlertAction(title: "Ok", style: .cancel) { (_) in
                    self.type3CardView.isHidden = true
                    self.type4CardView.isHidden = true
                    self.closeCard()
                }

                alert.addAction(alertButton)
                self.present(alert, animated: false, completion: nil)
            }
        }
    }
    
    @objc func choosePicture(button :UIButton){
        let chooseWord = String(button.tag)
        if chooseWord == correctAnswer {
            print("Answer is correct")
            self.type7CardView.isHidden = true
            closeCard()
        } else {
            // create new card for repeat mistake card
            
            let addCard = wordForLearningInThisIteration[numberCard]
            if wordForLearningInThisIteration.count-2 > numberCard {
                wordForLearningInThisIteration.insert(addCard, at: numberCard+2)
            } else {
                wordForLearningInThisIteration.append(addCard)
            }
            wordForLearningInThisIteration[numberCard].2 = false
            // show alert because mistake
            let text = "'\(wordArray[wordForLearningInThisIteration[numberCard].0].foreign)' переводится как '\(wordArray[wordForLearningInThisIteration[numberCard].0].original)'"
            let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "Ok", style: .cancel) { (_) in
                self.type7CardView.isHidden = true
                self.closeCard()
            }
            
            alert.addAction(alertButton)
            self.present(alert, animated: false, completion: nil)
        }
    }
    
    func convertHebrewString(word: String) -> String{
        var new = ""
        for letter in word {
            if let number = requestWordArray.index(of: String(letter)) {
                new = new + answerWordArray[number]
            } else {
                new = new + String(letter)
            }
        }
        return new
    }
    
    @objc func pressedCheck(){
        if let chooseWord = textField.text {
            
            if convertHebrewString(word: chooseWord.lowercased()) == convertHebrewString(word: correctAnswer.lowercased()) {
                print("Answer is correct")
                self.type6CardView.isHidden = true
                self.textField.resignFirstResponder()
                closeCard()
            } else {
                // create new card for repeat mistake card
                let addCard = wordForLearningInThisIteration[numberCard]
                if wordForLearningInThisIteration.count-2 > numberCard {
                    wordForLearningInThisIteration.insert(addCard, at: numberCard+2)
                } else {
                    wordForLearningInThisIteration.append(addCard)
                }
                wordForLearningInThisIteration[numberCard].2 = false
                
                // show alert because mistake
                let text = "'\(wordArray[wordForLearningInThisIteration[numberCard].0].foreign)' переводится как '\(wordArray[wordForLearningInThisIteration[numberCard].0].original)'"
                let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
                let alertButton = UIAlertAction(title: "Ok", style: .cancel) { (_) in
                    self.type6CardView.isHidden = true
                    self.textField.resignFirstResponder()
                    self.closeCard()
                }
                
                alert.addAction(alertButton)
                self.present(alert, animated: false, completion: nil)
            }
        }
    }
    
    // MARK:- Create some cards
    private func createMeetingCard(word: WordForLearning) {
        // create Card View
        meetCardView.isHidden = true
        meetCardView.bounds.size = view.bounds.size
        meetCardView.center = view.center
        
        
        // create Image
        let imageView = createPicture(type: .main, name: word.image)
        
        // create subView for Word
        let fieldForWord = UIView()
        fieldForWord.frame = CGRect(x: 0,
                                    y: Int(meetCardView.frame.height/100*43),
                                    width: Int(meetCardView.frame.width),
                                    height: Int(meetCardView.frame.height/7))
        fieldForWord.backgroundColor = backgroundForWord
        
        let foreignLabel = createLabel(posX: 20, posY: 7, text: word.foreign, size: 35)
        let russianLabel = createLabel(posX: 20,
                                       posY: Int(fieldForWord.frame.height/2+5),
                                       text: "",//word.original,
                                       size: 25)
        let pronunciationButton = createButton(type: .pronunciationNormal, posX: Int(fieldForWord.frame.width), posY: Int(fieldForWord.frame.height), text: nil, size: nil, color: nil)
        
        
        fieldForWord.addSubview(russianLabel)
        fieldForWord.addSubview(foreignLabel)
        fieldForWord.addSubview(pronunciationButton)

        let nextButton = createButton(type: TypeOfButton.next,
                                      posX: 0,
                                      posY: Int(meetCardView.frame.height/10*9),
                                      text: "Далее",
                                      size: 20,
                                      color: UIColor(red: 153/255, green: 204/255, blue: 102/255, alpha: 1))
        nextButton.addTarget(self, action: #selector(pressedNext), for: .touchDown)
        prononceLabel = createLabel(posX: 20, posY: Int(meetCardView.frame.height/100*63), text: "test", size: 25)
        // create meetCard
        meetCardView.addSubview(nextButton)
        meetCardView.addSubview(fieldForWord)
        meetCardView.addSubview(imageView)
        meetCardView.addSubview(prononceLabel)
        
        self.view.addSubview(meetCardView)
    }
    private func createType2Card(word: WordForLearning) {
        // create Card View
        type2CardView.isHidden = true
        type2CardView.bounds.size = view.bounds.size
        type2CardView.center = view.center
        
        
        // create Image
        let imageView = createPicture(type: .main, name: word.image)
        
        // create subView for Word
        let fieldForWord = UIView()
        fieldForWord.frame = CGRect(x: 0,
                                    y: Int(type2CardView.frame.height/100*43),
                                    width: Int(type2CardView.frame.width),
                                    height: Int(type2CardView.frame.height/7))
        fieldForWord.backgroundColor = backgroundForWord
        
        
        let originalLabel = createLabel(posX: 20,
                                       posY: Int(fieldForWord.frame.height/2+5),
                                       text: "",//word.original,
                                       size: 25)

        fieldForWord.addSubview(originalLabel)
        let forgetButton = createButton(type: TypeOfButton.forget,
                                        posX: Int(type2CardView.frame.width),
                                        posY: Int(type2CardView.frame.height),
                                        text: nil,
                                        size: nil,
                                        color: nil)
        let rememberButton = createButton(type: TypeOfButton.remember,
                                      posX: Int(type2CardView.frame.width),
                                      posY: Int(type2CardView.frame.height),
                                      text: nil,
                                      size: nil,
                                      color: nil)
        
        forgetButton.addTarget(self, action: #selector(pressedForget), for: .touchDown)
        rememberButton.addTarget(self, action: #selector(pressedNext), for: .touchDown)
        let forgetLabel = createLabel(posX: Int(type2CardView.frame.width/10),
                                      posY: Int(type2CardView.frame.height/28*25),
                                      text: "Don't remember",
                                      size: 18)
        let rememberLabel = createLabel(posX: Int(type2CardView.frame.width/10*6),
                                      posY: Int(type2CardView.frame.height/28*25),
                                      text: "Remember",
                                      size: 18)
        
        // create meetCard
        type2CardView.addSubview(imageView)
        type2CardView.addSubview(fieldForWord)
        type2CardView.addSubview(rememberButton)
        type2CardView.addSubview(forgetButton)
        type2CardView.addSubview(forgetLabel)
        type2CardView.addSubview(rememberLabel)
        
        
        
        self.view.addSubview(type2CardView)
    }
    
    // Картинка! + перевод! написание? (выбор из 4-х слов) -> Знакомство
    // Type 3
    private func createType3Card(word: WordForLearning) {
        // create Card View
        type3CardView.isHidden = true
        type3CardView.bounds.size = view.bounds.size
        type3CardView.center = view.center
        
        
        // create Image
        let imageView = createPicture(type: .main, name: word.image)
        
        // create subView for Word
        let fieldForWord = UIView()
        fieldForWord.frame = CGRect(x: 0,
                                    y: Int(type3CardView.frame.height/100*43),
                                    width: Int(type3CardView.frame.width),
                                    height: Int(type3CardView.frame.height/7))
        fieldForWord.backgroundColor = backgroundForWord
        
        let foreignLabel = createLabel(posX: 20, posY: 10, text: "Remember the word", size: 35)
        let russianLabel = createLabel(posX: 20,
                                       posY: Int(fieldForWord.frame.height/2+5),
                                       text: "",//word.original,
                                       size: 25)
        
        fieldForWord.addSubview(foreignLabel)
        fieldForWord.addSubview(russianLabel)
        
        
        // create meetCard
        type3CardView = createFourButton(view: type3CardView)
        type3CardView.addSubview(fieldForWord)
        type3CardView.addSubview(imageView)
        
        self.view.addSubview(type3CardView)
    }
    
    // Type 4
    private func createType4Card(word: WordForLearning) {

        // create Card View
        type4CardView.isHidden = true
        type4CardView.bounds.size = view.bounds.size
        type4CardView.center = view.center
        
        let fieldTop = UIView()
        fieldTop.frame = CGRect(x: 0,
                                y: 0,
                                width: Int(type4CardView.frame.width),
                                height: Int(type4CardView.frame.height/100*43))
        fieldTop.backgroundColor = backgroundForWord
        
        let pronunciationButton = createButton(type: .pronunciationBig, posX: Int(fieldTop.frame.width), posY: Int(fieldTop.frame.height), text: nil, size: nil, color: nil)
        fieldTop.addSubview(pronunciationButton)
        
        // create subView for Word
        let fieldForWord = UIView()
        fieldForWord.frame = CGRect(x: 0,
                                    y: Int(type4CardView.frame.height/100*43),
                                    width: Int(type4CardView.frame.width),
                                    height: Int(type4CardView.frame.height/7))
        fieldForWord.backgroundColor = backgroundForWord
        
        
        let foreignLabel = createLabel(posX: 20, posY: 10, text: word.foreign, size: 35)
        let originalLabel = createLabel(posX: 20,
                                       posY: Int(fieldForWord.frame.height/2+5),
                                       text: "Remember the translation",
                                       size: 25)
        
        fieldForWord.addSubview(foreignLabel)
        fieldForWord.addSubview(originalLabel)
        
        // create meetCard
        type4CardView = createFourButton(view: type4CardView)
        type4CardView.addSubview(fieldTop)
        type4CardView.addSubview(fieldForWord)
        
        self.view.addSubview(type4CardView)
    }
    // Type 6
    private func createType6Card(word: WordForLearning) {
        
        // create Card View
        type6CardView.isHidden = true
        type6CardView.bounds.size = view.bounds.size
        type6CardView.center = view.center
        
        let fieldTop = UIView()
        fieldTop.frame = CGRect(x: 0,
                                y: 0,
                                width: Int(type6CardView.frame.width),
                                height: Int(type6CardView.frame.height/100*43))
        fieldTop.backgroundColor = backgroundForWord
        
        let pronunciationButton = createButton(type: .pronunciationBig, posX: Int(fieldTop.frame.width), posY: Int(fieldTop.frame.height), text: nil, size: nil, color: nil)
        fieldTop.addSubview(pronunciationButton)
        
        // create subView for Word
        let fieldForWord = UIView()
        fieldForWord.frame = CGRect(x: 0,
                                    y: Int(type6CardView.frame.height/100*43),
                                    width: Int(type6CardView.frame.width),
                                    height: Int(type6CardView.frame.height/7))
        fieldForWord.backgroundColor = backgroundForWord

        textField.frame = CGRect(x: 20, y: 5, width: type6CardView.frame.width - 20, height: 44)
        textField.placeholder = "Write the word"
        textField.borderStyle = .none
        textField.keyboardType = .default
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.font = UIFont.boldSystemFont(ofSize: 30)
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 10
        textField.tintColor = .white
        textField.textColor = .white
        
        let originalLabel = createLabel(posX: 20,
                                        posY: Int(fieldForWord.frame.height/2),
                                        text: "",//word.original,
                                        size: 25)
        fieldForWord.addSubview(textField)
        fieldForWord.addSubview(originalLabel)
        let checkButton = createButton(type: TypeOfButton.next,
                                      posX: 0,
                                      posY: Int(type6CardView.frame.height/100*43) + Int(type6CardView.frame.height/7),
                                      text: "Проверить",
                                      size: 20,
                                      color: UIColor(red: 153/255, green: 204/255, blue: 102/255, alpha: 1))
        checkButton.addTarget(self, action: #selector(pressedCheck), for: .touchDown)
        
        // create meetCard
        type6CardView.addSubview(fieldTop)
        type6CardView.addSubview(fieldForWord)
        type6CardView.addSubview(checkButton)
        
        self.view.addSubview(type6CardView)
    }
    // Type 7
    private func createType7Card(word: WordForLearning) {

        // create Card View
        type7CardView.isHidden = true
        type7CardView.bounds.size = view.bounds.size
        type7CardView.center = view.center
        
        let fieldTop = UIView()
        fieldTop.frame = CGRect(x: 0,
                                y: 0,
                                width: Int(type7CardView.frame.width),
                                height: Int(type7CardView.frame.height/100*43))
        fieldTop.backgroundColor = backgroundForWord
        
        let pronunciationButton = createButton(type: .pronunciationBig, posX: Int(fieldTop.frame.width), posY: Int(fieldTop.frame.height), text: nil, size: nil, color: nil)
        fieldTop.addSubview(pronunciationButton)
        
        // create subView for Word
        let fieldForWord = UIView()
        fieldForWord.frame = CGRect(x: 0,
                                    y: Int(type7CardView.frame.height/100*43),
                                    width: Int(type7CardView.frame.width),
                                    height: Int(type7CardView.frame.height/7))
        fieldForWord.backgroundColor = backgroundForWord
        
        let foreignLabel = createLabel(posX: 20, posY: 10, text: word.foreign, size: 35)
        let originalLabel = createLabel(posX: 20,
                                        posY: Int(fieldForWord.frame.height/2+5),
                                        text: "Remember the translation",
                                        size: 25)
        
        fieldForWord.addSubview(foreignLabel)
        fieldForWord.addSubview(originalLabel)
        
        // create meetCard
        type7CardView.addSubview(fieldTop)
        type7CardView = createFourPicture(view: type7CardView)
        type7CardView.addSubview(fieldForWord)
        
        self.view.addSubview(type7CardView)
    }
    
    private func createStartPage() {
        
        // create Card View
        startPage.isHidden = true
        startPage.bounds.size = view.bounds.size
        startPage.center = view.center
        
        let informationLabel = createLabel(posX: 20, posY: Int(startPage.frame.height/3), text: "Information", size: 22)
        let progressInformation = createLabel(posX: 20, posY: 40, text: "BlackAndLeft", size: 18)
        progressInformation.numberOfLines = 6
        let nextButton = createButton(type: TypeOfButton.next,
                                      posX: 0,
                                      posY: Int(startPage.frame.height/2),
                                      text: "Поехали",
                                      size: 20,
                                      color: UIColor(red: 153/255, green: 204/255, blue: 102/255, alpha: 1))
        nextButton.addTarget(self, action: #selector(pressedStart), for: .touchDown)
        
        startPage.addSubview(nextButton)
        startPage.addSubview(informationLabel)
        startPage.addSubview(progressInformation)
        self.view.addSubview(startPage)
    }
    
    func createMaketOfCards() {
        createStartPage()
        createProgressLine()
        createMeetingCard(word: testWord)
        createType2Card(word: testWord)
        createType3Card(word: testWord)
        createType4Card(word: testWord)
        createType6Card(word: testWord)
        createType7Card(word: testWord)
    }
    
    //MARK: - Show Cards
    func showStartPage() {
        readRecords(typeOfRequest: .actual) // Загружаем актуальные записи из CoreData
        // формируем массив wordsArray -  слова для текущей итерации
        createWordsArray()
        // Создаем список карточек для изучения
        createListOfCards() // Создаем список карточек для изучения
        // Узнаем информацию на сегодня
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Statistic")
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        let dateToday = calendar.startOfDay(for: Date()) // eg. 2016-10-10 00:00:00
        print(dateToday)
        let fromPredicate = NSPredicate(format: "%K > %@", "date", dateToday as NSDate)
        request.predicate = fromPredicate
        do {
            let iterations = try CoreDataManager.instance.persistentContainer.viewContext.fetch(request) as! [Statistic]
            print(iterations.count)
            if iterations.count > 0 {
                countIterationToday = iterations.count
            }
        } catch {
            print(error)
        }
        
        
        
        // создаем макеты
        var firstLabel = true
        let labels = startPage.subviews
        for label in labels {
            if let newlabel = label as? UILabel {
                if firstLabel {
                    if wordsCoreDataArray.count < 4 {
                        newlabel.text = "На сегодня слов не осталось"
                        newlabel.sizeToFit()
                    } else {
                        newlabel.text = "Осталось \(wordsCoreDataArray.count) слов на сегодня"
                        newlabel.sizeToFit()
                    }
                    firstLabel = false
                } else {
                    newlabel.text = "Итерация \(countIterationToday)\n" + informationAboutSituation
                    newlabel.sizeToFit()
                }
                
            }
        }
        startPage.isHidden = false
        
    }
    
    func showMeetingCard(word: WordForLearning) {
        // create Card View
        pronunciationWord()
        let subViews = meetCardView.subviews
        for i in subViews {
            if let imageView = i as? UIImageView {
                imageView.image = UIImage(named: word.image)
            }
            var firstLabel = true
            if let textField = i as? UIView {
                let labels = textField.subviews
                for j in labels {
                    if let label = j as? UILabel {
                        if firstLabel {
                            label.text = word.original
                            label.sizeToFit()
                            firstLabel = false
                        } else {
                            label.text = word.foreign
                            label.sizeToFit()
                        }
                    }
                }
            }
        }
        prononceLabel.text = word.simple
        prononceLabel.sizeToFit()
//        prononceLabel.isHidden = false
        meetCardView.isHidden = false
    }
    
    
    func showType2Card(word: WordForLearning) {
        // Произношение! + Написание Да/Нет -> if no -> Знакомство        type 2

        let subViews = type2CardView.subviews
        var firstLabel = true
        for i in subViews {
            if let imageView = i as? UIImageView {
                imageView.image = UIImage(named: word.image)
            }

            if let textField = i as? UIView {
                let labels = textField.subviews
                for j in labels {
                    if let label = j as? UILabel {
                        if firstLabel {
                            label.text = word.original
                            label.sizeToFit()
                            firstLabel = false
                        }
                    }
                }
            }
        }
        type2CardView.isHidden = false
    }

    func createArrayWithFourWord(word: WordForLearning) -> [WordForLearning] {
        var tempArray = wordArray
        tempArray.shuffle()
        for i in 0...2 {
            if tempArray[i].foreign == word.foreign {
                tempArray.remove(at: i)
            }
        }
        tempArray.removeLast(tempArray.count - 3)
        tempArray.append(word)
        tempArray.shuffle()
        return tempArray
    }
    
    private func showType3Card(word: WordForLearning, typeCard: TypeOfCard) {
//        Данный тиип имеем следующие разновидности карточек
//   V    Картинка! написание? (выбор из 4-х слов)
//   V    Картинка! перевод? (выбор из 4-х слов)
//   V    Картинка! + перевод! написание? (выбор из 4-х слов)
        // create randome array for three uncorrect words
        let fourWordArray = createArrayWithFourWord(word: word)
        for k in fourWordArray {
            print(k.foreign)
        }
        var numberButton = 0 // which button is from fourth
        var firstLabel = true
        // Parse any view
        let subViews = type3CardView.subviews
        for i in subViews {
            // set actual image
            if let imageView = i as? UIImageView {
                imageView.image = UIImage(named: word.image)
                print("picture is finded")
            }
            
            // set actual text in button
            if let button = i as? UIButton {
                if typeCard == .pictureChooseTranslate {
                    button.setTitle(fourWordArray[numberButton].original, for: .normal)
                    correctAnswer = wordArray[wordForLearningInThisIteration[numberCard].0].original
                } else {
                    button.setTitle(fourWordArray[numberButton].foreign, for: .normal)
                    correctAnswer = wordArray[wordForLearningInThisIteration[numberCard].0].foreign
                }
                numberButton += 1
                button.addTarget(self, action: #selector(chooseButton(button:)), for: .touchDown)
            }
            
            // set actual russian word

            if let textField = i as? UIView {
                let labels = textField.subviews
                for j in labels {
                    if let label = j as? UILabel {
                        if firstLabel {
                            label.text = ""
                            firstLabel = false
                        } else {
                            switch typeCard {
                            case .pictureAndTranslateChooseWrite: label.text = word.original
                            case .pictureChooseWrite, .pictureChooseTranslate: label.text = ""
                            default:
                                break
                            }
                            label.sizeToFit()
                            firstLabel = false
                        }
                    }
                }
            }
        }
        
        
        type3CardView.isHidden = false
    }
    private func showType4Card(word: WordForLearning, typeCard: TypeOfCard) {
    //        Данный тиип имеем следующие разновидности карточек
    //        Произношение! написание? (выбор из 4-х слов)                   type 4
    //        Произношение! + Написание! перевод? (выбор из 4-х слов)        type 4
    //        Произношение! + перевод? (выбор из 4-х слов)                   type 4
        // create randome array for three uncorrect words
        pronunciationWord()
        let fourWordArray = createArrayWithFourWord(word: word)
        for k in fourWordArray {
            print(k.foreign)
        }
        var numberButton = 0 // which button is from fourth
        var firstLabel = true
        
        // Parse any view
        let subViews = type4CardView.subviews
        for i in subViews {
            
            // set actual text in button
            if let button = i as? UIButton {
                if (typeCard == .prononceAndWriteChooseTranslate) || (typeCard == .prononceChooseTranslate) {
                    button.setTitle(fourWordArray[numberButton].original, for: .normal)
                    correctAnswer = wordArray[wordForLearningInThisIteration[numberCard].0].original
                } else {
                    button.setTitle(fourWordArray[numberButton].foreign, for: .normal)
                    correctAnswer = wordArray[wordForLearningInThisIteration[numberCard].0].foreign
                }
                numberButton += 1
                button.addTarget(self, action: #selector(chooseButton(button:)), for: .touchDown)
            }
            
            // set actual russian word
            
            if let textField = i as? UIView {
                let labels = textField.subviews
                for j in labels {
                    if let label = j as? UILabel {
                        if firstLabel {
                            label.text = ""
                            firstLabel = false
                        } else {
                            switch typeCard {
                            case .prononceAndWriteChooseTranslate: label.text = word.foreign
                            case .prononceChooseWrite, .prononceChooseTranslate: label.text = ""
                            default:
                                break
                            }
                            label.sizeToFit()
                            firstLabel = false
                        }
                    }
                }
            }
        }
        type4CardView.isHidden = false
    }
    
    private func showType6Card(word: WordForLearning, typeCard: TypeOfCard) {
//        Данный тиип имеем следующие разновидности карточек
//        Написание слова по произношению                                type 6
//        Написание слова по переводу                                    type 6
        // create randome array for three uncorrect words
//        var numberButton = 0 // which button is from fourth
        textField.becomeFirstResponder()
        var numberView = 0
        if typeCard == .writeFromPrononce {
            pronunciationWord()
        }
        
        // Parse any view
        let subViews = type6CardView.subviews
        for i in subViews {

            correctAnswer = wordArray[wordForLearningInThisIteration[numberCard].0].foreign
            // set actual foreign word
            if let textField = i as? UIView {
                if numberView == 0 {
                    let buttons = textField.subviews
                    for button in buttons {
                        if let newButton = button as? UIButton {
                            newButton.isHidden = typeCard == .writeFromPrononce ? false : true
                        }
                    }
                }
                numberView += 1
                let labels = textField.subviews
                var firstLabel = true
                for j in labels {
                    if let label = j as? UILabel {
                        if firstLabel {
                            if typeCard == .writeFromPrononce {
                                label.text = ""
                            } else {
                                label.text = word.original
                            }
                            firstLabel = false
                        } else {
                            label.text = "Remember the word"
                        }
                        label.sizeToFit()
                    }
                }
            }
        }
        type6CardView.isHidden = false
    }
    
    private func showType7Card(word: WordForLearning, typeCard: TypeOfCard) {
//        Данный тиип имеем следующие разновидности карточек
//    Произношение! картинка? (выбор из 4-х картинок)                    type 7
//    Написание! картинка?   (выбор из 4-х картинок)                     type 7
        // create randome array for three uncorrect words
        var numberButton = 0 // which button is from fourth
        var numberView = 0
        if typeCard == .prononceChoosePicture {
            pronunciationWord()
        }
        let fourWordArray = createArrayWithFourWord(word: word)
        for k in fourWordArray {
            print(k.foreign)
        }
        
        // Parse any view
        let subViews = type7CardView.subviews
        for i in subViews {

            // set actual text in button
            if let button = i as? UIButton {
                if let newImage = UIImage(named: fourWordArray[numberButton].image ) {
                    button.setBackgroundImage(newImage, for: .normal)
                    button.tag = 100 + numberButton
                }
                if fourWordArray[numberButton].foreign == wordArray[wordForLearningInThisIteration[numberCard].0].foreign {
                    correctAnswer = String(button.tag)
                }
                button.addTarget(self, action: #selector(choosePicture(button:)), for: .touchDown)
                numberButton += 1
            }
            
            // set actual foreign word
            if let textField = i as? UIView {
                if numberView == 0 {
                    let buttons = textField.subviews
                    for button in buttons {
                        if let newButton = button as? UIButton {
                            newButton.isHidden = typeCard == .prononceChoosePicture ? false : true
                        }
                    }
                }
                numberView += 1
                let labels = textField.subviews
                var firstLabel = true
                for j in labels {
                    if let label = j as? UILabel {
                        if firstLabel {
                            if typeCard == .prononceChoosePicture {
                                label.text = ""
                            } else {
                                label.text = word.foreign
                            }
                            firstLabel = false
                        } else {
                            label.text = "Remember the word"
                        }
                        label.sizeToFit()
                    }
                }
            }
        }
        type7CardView.isHidden = false
    }
    
    //MARK:- Work with Array
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
//                if wordFromAddArray.nextContact != nil {
//                    newWord.nextContact = wordFromAddArray.nextContact as! NSDate
//                }
                newWord.nextContact = Date() as NSDate
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
        //Information Alert
        let zeroLevel = wordsCoreDataArray.filter({ (word) -> Bool in
        return word.levelOfLearning == 0 ? true : false
        })
        let learndLevel = wordsCoreDataArray.filter({ (word) -> Bool in
            return (word.levelOfLearning == 1) || (word.levelOfLearning == 2) || (word.levelOfLearning == 3) ? true : false
        })

        let fourthLevel = wordsCoreDataArray.filter({ (word) -> Bool in
            return word.levelOfLearning > 3 ? true : false
        })
        
        informationAboutSituation = "Всего слов \(wordsCoreDataArray.count) \nНовых слов \(zeroLevel.count)\nВыучено слов \(fourthLevel.count)\nСлов на изучении \(learndLevel.count)\n "
    }
    
    private func createWordsArray() {

        // Определяем сколько новых слов в базе
        var newWordsArray = wordsCoreDataArray.filter({ (word) -> Bool in
            return word.levelOfLearning != 0 ? false : true
        })
        var oldWordsArray = wordsCoreDataArray.filter({ (word) -> Bool in
            return word.levelOfLearning != 0 ? true : false
        })
        
        // Определяем пропорцию слов в итерации
        var new = 0
        var old = 0
        

        if newWordsArray.count > Int(Double(countWordInOneIteration) * 0.4) {
            if (oldWordsArray.count) > Int(Double(countWordInOneIteration) * 0.6) {
                new = Int(Double(countWordInOneIteration) * 0.4)
                old = Int(Double(countWordInOneIteration) * 0.6)
            } else {
                old = oldWordsArray.count
                new = (newWordsArray.count > countWordInOneIteration - old ) ? ( countWordInOneIteration - old) : newWordsArray.count
            }
        } else {
            new = newWordsArray.count
            old = (oldWordsArray.count > countWordInOneIteration - new ) ? ( countWordInOneIteration - new) : oldWordsArray.count
        }
        print("new -\(new) ; old - \(old)")
        newWordsArray.shuffle()
        oldWordsArray.shuffle()
        wordArray = []
        for i in 0..<new {

            var newWord = WordForLearning()
            newWord.foreign = newWordsArray[i].foreign!
            newWord.original = newWordsArray[i].original!
            newWord.isLearned = newWordsArray[i].isLearned
            newWord.levelOfLearning = Int(newWordsArray[i].levelOfLearning)
            if newWordsArray[i].nextContact != nil {
                newWord.nextContact = newWordsArray[i].nextContact as! Date
            }
            newWord.dontWantToLearn = newWordsArray[i].dontWantToLearn
            newWord.image = newWordsArray[i].image!
            newWord.mistake = Int(newWordsArray[i].mistake)
            newWord.discription = newWordsArray[i].discription
            newWord.simple = newWordsArray[i].simple

            wordArray.append(newWord)
        }
        for i in 0..<old {
            var newWord = WordForLearning()
            newWord.foreign = oldWordsArray[i].foreign!
            newWord.original = oldWordsArray[i].original!
            newWord.isLearned = oldWordsArray[i].isLearned
            newWord.levelOfLearning = Int(oldWordsArray[i].levelOfLearning)
            if oldWordsArray[i].nextContact != nil {
                newWord.nextContact = oldWordsArray[i].nextContact as! Date
            }
            newWord.dontWantToLearn = oldWordsArray[i].dontWantToLearn
            newWord.image = oldWordsArray[i].image!
            newWord.mistake = Int(oldWordsArray[i].mistake)
            newWord.discription = oldWordsArray[i].discription
            newWord.simple = oldWordsArray[i].simple
            
            wordArray.append(newWord)
        }
        print(wordArray.count)
    }
    
//    func addNewWords() {
//        // #доделать Подгружать данные из FireBase
//        let newWordsArray = AddNewWords()
//        wordArray.append(contentsOf: newWordsArray.newWordsArray)
//    }

    
    func creatCardForLevel(numberWordInArray:Int, fromNumber: Int, typeCardArray: [TypeOfCard]) {
        for typeOfCard in typeCardArray {
            var randomPosition = Int(arc4random_uniform(UInt32(wordForLearningInThisIteration.count - fromNumber)))
            randomPosition += fromNumber
            wordForLearningInThisIteration.insert((numberWordInArray,typeOfCard,true), at: randomPosition)
        }
    }
    
    func createListOfCards() {
        // для всех новых слов, создаем первую карточку meeting
        wordForLearningInThisIteration = []
        var countNewWords = 0
        // знакомство с новыми словами
        for (i,word) in zip(wordArray.indices, wordArray) {
            if word.levelOfLearning == 0 {
                for j in 0..<cardForMeeting.count {
                    wordForLearningInThisIteration.append((i, cardForMeeting[j], true))
                }
                countNewWords += 1
            }
        }
        // добавлем карточки на повторение Хаотично
        var typeCardArray: [TypeOfCard] = []
        for (i,word) in zip(wordArray.indices, wordArray) {
            switch word.levelOfLearning {
            case 0: typeCardArray = cardForLevel0
            case 1: typeCardArray = cardForLevel1
            case 2,3: typeCardArray = cardForLevel2
            case 4...8: typeCardArray = cardForLevel3
            default:
                break
            }
            creatCardForLevel(numberWordInArray: i, fromNumber: countNewWords*cardForMeeting.count, typeCardArray: typeCardArray)
        }
    }
    func finishIteration() {
        var numberWordsChangeLevel = 0
        for numberWordArrayRoot in wordArray.indices {
            let filteredArray = wordForLearningInThisIteration.filter({ (numberWord,typeCard,correct) -> Bool in
                if numberWordArrayRoot == numberWord {
                    return correct ? false : true
                } else {
                    return false
                }
            })
            
            if (filteredArray.count < 2) && (wordArray[numberWordArrayRoot].levelOfLearning < 3) {
                wordArray[numberWordArrayRoot].levelOfLearning += 1
                numberWordsChangeLevel += 1
            } else {
                if filteredArray.count > 2 {
                    wordArray[numberWordArrayRoot].levelOfLearning = 0
                } else {
                    if filteredArray.count < 2 {
                        wordArray[numberWordArrayRoot].levelOfLearning += 1
                        numberWordsChangeLevel += 1
                    } else {
                        wordArray[numberWordArrayRoot].levelOfLearning = 2
                    }
                }
            }
            
            wordArray[numberWordArrayRoot].mistake += filteredArray.count
            switch wordArray[numberWordArrayRoot].levelOfLearning {
            case 0,1: wordArray[numberWordArrayRoot].nextContact = Date()
            case 2: wordArray[numberWordArrayRoot].nextContact = Calendar.current.date(byAdding: .day, value: 1, to: Date())
            case 3: wordArray[numberWordArrayRoot].nextContact = Calendar.current.date(byAdding: .day, value: 3, to: Date())
            case 4: wordArray[numberWordArrayRoot].nextContact = Calendar.current.date(byAdding: .day, value: 7, to: Date())
            case 5: wordArray[numberWordArrayRoot].nextContact = Calendar.current.date(byAdding: .day, value: 30, to: Date())
            case 6: wordArray[numberWordArrayRoot].nextContact = Calendar.current.date(byAdding: .day, value: 90, to: Date())
            case 7: wordArray[numberWordArrayRoot].nextContact = Calendar.current.date(byAdding: .day, value: 365, to: Date())
            case 8: wordArray[numberWordArrayRoot].nextContact = Calendar.current.date(byAdding: .day, value: 365, to: Date())
            default: Calendar.current.date(byAdding: .day, value:3650, to: Date())
            }
        }
        // Подсчет количества слов, поднявшихся в изучении
//        let numberWordsChangeLevel = 5
        let staticInformation = Statistic()
        staticInformation.date = Date() as NSDate
        staticInformation.changeLevel = Int32(numberWordsChangeLevel)
//        staticInformation.countIsLearned =
//        staticInformation.countMistake =
//        staticInformation.countWord =
        CoreDataManager.instance.saveContext()
        
        
        // save to CoreData
        for wordFromArray in wordArray {
            print(wordFromArray.foreign,wordFromArray.levelOfLearning)
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Words")
            let predicate = NSPredicate(format: "%K == %@", "image", wordFromArray.image)
            request.predicate = predicate
            do {
                let wordsFromCoreData = try CoreDataManager.instance.persistentContainer.viewContext.fetch(request) as! [Words]
                if wordsFromCoreData.count > 0 {
                    for wordFromCoreData in wordsFromCoreData {
                        wordFromCoreData.levelOfLearning = Int32(wordFromArray.levelOfLearning)
                        wordFromCoreData.mistake = Int32(wordFromArray.mistake)
                        wordFromCoreData.nextContact = wordFromArray.nextContact as! NSDate
                        wordFromCoreData.dontWantToLearn = wordFromArray.dontWantToLearn
                        wordFromCoreData.isLearned = wordFromArray.isLearned
                        CoreDataManager.instance.saveContext()
                    }
                }
            } catch {
                print(error)
            }
        }
        showStartPage()
    }
    //MARK:- Learning
    func runLearning(numberCard: Int) {
        guard wordForLearningInThisIteration.count > numberCard else {
            print("Не допустимое значение индекса")
            return
        }
        progressLine.setProgress(Float(numberCard)/Float(wordForLearningInThisIteration.count) , animated: true)
        let card = wordForLearningInThisIteration[numberCard]
        print("Запущена карточка ",card.1," слово \(card.0); №\(numberCard) from \(wordForLearningInThisIteration.count)")
        switch card.1 {
        case.meeting:
            showMeetingCard(word: wordArray[card.0])
        case .trueOrFalse:
            showType2Card(word: wordArray[card.0])
        case .pictureChooseWrite:
            showType3Card(word: wordArray[card.0], typeCard: .pictureChooseWrite)
        case .pictureChooseTranslate:
            showType3Card(word: wordArray[card.0], typeCard: .pictureChooseTranslate)
        case .pictureAndTranslateChooseWrite:
            showType3Card(word: wordArray[card.0], typeCard: .pictureAndTranslateChooseWrite)
        case .prononceChooseWrite:
            showType4Card(word: wordArray[card.0], typeCard: .prononceChooseWrite)
        case .prononceChoosePicture:
            showType7Card(word: wordArray[card.0], typeCard: .prononceChoosePicture)
        case .prononceAndWriteChooseTranslate:
            showType4Card(word: wordArray[card.0], typeCard: .prononceAndWriteChooseTranslate)
        case .createFromLetter:
            //
            showType4Card(word: wordArray[card.0], typeCard: .prononceChooseWrite)
        case .prononceChooseTranslate:
            showType4Card(word: wordArray[card.0], typeCard: .prononceChooseTranslate)
        case .writeFromPrononce:
            showType6Card(word: wordArray[card.0], typeCard: .writeFromPrononce)
        case .writeFromTranslate:
            showType6Card(word: wordArray[card.0], typeCard: .writeFromTranslate)
        case .writeChoosePicture:
            showType7Card(word: wordArray[card.0], typeCard: .writeChoosePicture)
        }
    }
}
// MARK:- Extantion
extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
/* Этапы доработки
 1. Механизм внесения данных в CoreData
 2. Определения слов для изучения в текущей сессиии.
 3. Отображение результата обучения в CoreData
 4.+ Сделать карточки type 2, type 4, type 6 и type 7
 5. Доделать остальные карточки type 5
 6.+ case 1: //Добавление других level Формирование List of Card

 Этапы работы программы
 0.+ Добавление новых слов в базу
 1. Определения списка слов на изучение
    Если не хватает слов, то система берет данные из базы не изученных Слов.
 2. Фильтрация слов на текущую итерацию
 3.+ Составлениие списка заданий (слово + тип карточки)
 4.+ Запуск процесса изучения
 5. Отображение прогресса
 6. Завершениие
 7. Запись статистики за сегодня. Сколько слов новых, повторено, ошибок, карточек изучено/с ошибкой

 
 Этапы до запуска
 1.+ Подведение итогов, итерации
 2. Запись итогов в CoreData
 3. Загрузка данных их CoreData
 4. Формирование массива word
 5. Наполнение словаря
 
 



Group 0
Знакомство (Произношение! + картинка! + написание! + перевод!) type 1 - V
Произношение! + Написание Да/Нет -> if no -> Знакомство        type 2 - V

Group 1
Картинка! написание? (выбор из 4-х слов) -> Знакомство         type 3 - V
Картинка! перевод? (выбор из 4-х слов) -> Знакомство                  - V
Картинка! + перевод! написание? (выбор из 4-х слов) -> Знакомство     - V

Group 2
Произношение! написание? (выбор из 4-х слов)                   type 4 - V
Произношение! картинка? (выбор из 4-х слов)                    type 7 - V
Написание! картинка?   (выбор из 4-х слов)                     type 7 - V
Произношение! + Написание! перевод? (выбор из 4-х слов)        type 4 - V

Group 3
Составление слова из букв                                      type 5
Произношение! + перевод? (выбор из 4-х слов)                   type 4 - V

Group 4
Написание слова по произношению                                type 6 - V
Написание слова по переводу                                    type 6 - V
*/

