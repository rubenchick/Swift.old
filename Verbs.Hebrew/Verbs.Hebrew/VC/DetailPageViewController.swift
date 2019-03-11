//
//  DetailPageViewController.swift
//  Verbs.Hebrew
//
//  Created by Anton Rubenchik on 01/03/2019.
//  Copyright © 2019 Anton Rubenchik. All rights reserved.
//

import UIKit

class DetailPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currentWord = Word()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var infinitivLabel: UILabel!
    @IBOutlet weak var prononsationLabel: UILabel!
    
    @IBOutlet weak var translateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        startSetConfiguration()
    }
    func startSetConfiguration() -> () {
        self.navigationController?.navigationBar.topItem?.title = "Назад"
        self.title = currentWord.typeOfVerb.rawValue
        if returnTranslation(translation: currentWord.infinitiveP) != "" {
            prononsationLabel.text = "( " + returnTranslation(translation: currentWord.infinitiveP) + " )"
        }
        infinitivLabel.text = currentWord.infinitive
        if currentWord.preposition != "" {
            translateLabel.text = returnTranslation(translation: currentWord.translation) + " (" + currentWord.preposition + ")"
        } else {
            translateLabel.text = returnTranslation(translation: currentWord.translation) + currentWord.preposition
        }
        tableView.tableFooterView = UIView()
        
    }
    
    @IBAction func pressSegmentControl(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    //    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//    }
    // MARK: - CreateData
    func returnTranslation(translation: Translation?) -> (String) {
        if translation != nil {
            switch actualLanguage {
            case .russian:
                return translation?.russian ?? ""
            case .english:
                return translation?.english ?? ""
            case .spanish:
                return translation?.spanish ?? ""
            case .hebrew:
                return translation?.russian ?? ""
            }
        } else {
            return ""
        }
    }
    
    func lookForPresent(indexPath: Int) -> (WordInTense) {
        var currentTens = WordInTense()
        switch indexPath {
        case 0: currentTens.word = currentWord.presentTense?.masculineSingular ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.presentTense?.masculineSingularPr)
        case 1: currentTens.word = currentWord.presentTense?.feminineSingular ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.presentTense?.feminineSingularPr)
        case 2: currentTens.word = currentWord.presentTense?.masculinePlural ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.presentTense?.masculinePluralPr)
        case 3: currentTens.word = currentWord.presentTense?.femininePlural ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.presentTense?.femininePluralPr)            
        default:
        currentTens.word = ""
        currentTens.translation = ""
        }
        return currentTens
    }
    
    func lookForPast(indexPath: Int) -> (WordInTense) {
        var currentTens = WordInTense()
        switch indexPath {
        case 0: currentTens.word = currentWord.pastTense?.singular1st ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.pastTense?.singular1stPr)
        case 1: currentTens.word = currentWord.pastTense?.masculineSingular2nd ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.pastTense?.masculineSingular2ndPr)
        case 2: currentTens.word = currentWord.pastTense?.feminineSingular2nd ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.pastTense?.feminineSingular2ndPr)
        case 3: currentTens.word = currentWord.pastTense?.masculineSingular3nd ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.pastTense?.masculineSingular3ndPr)
        case 4: currentTens.word = currentWord.pastTense?.feminineSingular3nd ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.pastTense?.feminineSingular3ndPr)
        case 5: currentTens.word = currentWord.pastTense?.plural1st ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.pastTense?.plural1stPr)
        case 6: currentTens.word = currentWord.pastTense?.masculinePlural2nd ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.pastTense?.masculinePlural2ndPr)
        case 7: currentTens.word = currentWord.pastTense?.femininePlural2nd ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.pastTense?.femininePlural2ndPr)
        case 8,9: currentTens.word = currentWord.pastTense?.plural3nd ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.pastTense?.plural3ndPr)

        default:
            currentTens.word = ""
            currentTens.translation = ""
        }
        return currentTens
    }
    
    func lookForFuture(indexPath: Int) -> (WordInTense) {
        var currentTens = WordInTense()
        switch indexPath {
        case 0: currentTens.word = currentWord.futureTense?.singular1st ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.futureTense?.singular1stPr)
        case 1: currentTens.word = currentWord.futureTense?.masculineSingular2nd ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.futureTense?.masculineSingular2ndPr)
        case 2: currentTens.word = currentWord.futureTense?.feminineSingular2nd ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.futureTense?.feminineSingular2ndPr)
        case 3: currentTens.word = currentWord.futureTense?.masculineSingular3nd ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.futureTense?.masculineSingular3ndPr)
        case 4: currentTens.word = currentWord.futureTense?.feminineSingular3nd ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.futureTense?.feminineSingular3ndPr)
        case 5: currentTens.word = currentWord.futureTense?.plural1st ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.futureTense?.plural1stPr)
        case 6: currentTens.word = currentWord.futureTense?.masculinePlural2nd ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.futureTense?.masculinePlural2ndPr)
        case 7: currentTens.word = currentWord.futureTense?.femininePlural2nd ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.futureTense?.femininePlural2ndPr)
        case 8,9: currentTens.word = currentWord.futureTense?.plural3nd ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.futureTense?.plural3ndPr)
            
        default:
            currentTens.word = ""
            currentTens.translation = ""
        }
        return currentTens
    }
    func lookForImperative(indexPath: Int) -> (WordInTense) {
        var currentTens = WordInTense()
        switch indexPath {
        case 0: currentTens.word = currentWord.imperative?.masculineSingular ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.imperative?.masculineSingularPr)
        case 1: currentTens.word = currentWord.imperative?.feminineSingular ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.imperative?.feminineSingularPr)
        case 2,3: currentTens.word = currentWord.imperative?.plural ?? ""
        currentTens.translation = returnTranslation(translation: currentWord.imperative?.pluralPr)
        default:
            currentTens.word = ""
            currentTens.translation = ""
        }
        return currentTens
    }
    
    func lookForTensFor(indexPath: Int) -> (WordInTense) {
        var currentTens = WordInTense()
        switch segmentControl.selectedSegmentIndex {
        case 0: if indexPath < imperativeBody.count {
            currentTens = lookForImperative(indexPath: indexPath)
            currentTens.body = imperativeBody[indexPath]
            }
        case 1: if indexPath < pastBody.count { // true
            currentTens = lookForFuture(indexPath: indexPath)
            currentTens.body = pastBody[indexPath] // true
            }
        case 2: if indexPath < pastBody.count {
            currentTens = lookForPast(indexPath: indexPath)
            currentTens.body = pastBody[indexPath]
            }
        case 3: if indexPath < presentBody.count {
            currentTens = lookForPresent(indexPath: indexPath)
            currentTens.body = presentBody[indexPath]
            }
        default:
            if indexPath < presentBody.count {
                currentTens.body = presentBody[indexPath]
            }
        }
        return currentTens
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentControl.selectedSegmentIndex {
        case 0: return 4
        case 1,2: return 10
        case 3: return 4
        default: return 3
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath) as? DatailTableViewCell {
//            let tens = WordInTense(body: "ttt",word: currentWord.infinitive,translation: currentWord.infinitiveP?.russian ?? "") // set current language
            cell.getData(tens: lookForTensFor(indexPath: indexPath.row))
            cell.selectionStyle = .none
        return cell
        } else {
          return UITableViewCell()
        }        
    }
}

