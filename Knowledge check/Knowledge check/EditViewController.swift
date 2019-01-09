//
//  EditViewController.swift
//  Knowledge check
//
//  Created by Anton Rubenchik on 16/11/2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class EditViewController: UIViewController, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var newWordsTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startWork()
    }
    
    func startWork() {
        if !newList {
            self.newWordsTextView.becomeFirstResponder()
            titleTextField.text = groupsArray[currentList].name
            newWordsTextView.text = ""
            if wordsArray.count > 0 {
                for i in 0...wordsArray.count-1 {
                    if (wordsArray[i].check == nil || wordsArray[i].check == "") {
                        newWordsTextView.text += wordsArray[i].name! + "\n"
                    } else {
                        newWordsTextView.text += wordsArray[i].name! + "@" + wordsArray[i].check! + "\n"
                    }
                }
            }
        }
        newWordsTextView.keyboardType = .default
        newWordsTextView.autocorrectionType = .no
        newWordsTextView.autocapitalizationType = .none
        
    }
    @IBAction func backButton(_ sender: UIButton) {
        if newList {
            newList = false
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        let title = titleTextField.text?.filter { $0 != " "}
        let text = newWordsTextView.text.filter { $0 != " "}
        if  (title != "") && (text != "") {
            if !newList {
                // Edit group name
                if groupsArray[currentList].name != titleTextField.text {
                    groupsArray[currentList].name = titleTextField.text
                    CoreDataManager.instance.saveContext()
                }
                
                // delete old words in group
                let wordsArrayFetchRequest = Words.fetchedResults(forThisGroup: groupsArray[currentList])
                do {
                    try wordsArrayFetchRequest.performFetch()
                    wordsArrayFetchRequest.delegate = self
                } catch {
                    print(error)
                }
                let deleteWords = wordsArrayFetchRequest.fetchedObjects as! [NSManagedObject]
                for word in deleteWords {
                    CoreDataManager.instance.persistentContainer.viewContext.delete(word)
                }
                CoreDataManager.instance.saveContext()
                // append new words in group
                let newWordsArray = newWordsTextView.text?.components(separatedBy: "\n")
                wordsArray = []
                let tempArray = newWordsArray?.filter({ (line) -> Bool in
                    let newLine = line.filter { $0 != " " }
                    return newLine != "" ? true : false
                }) ?? []
                
                for i in 0...tempArray.count - 1 {
                    let newWords = Words()
                    newWords.group = groupsArray[currentList]
                    
                    let separators = NSCharacterSet(charactersIn: "@")
                    let result = tempArray[i].components(separatedBy: separators as CharacterSet)
                    if result.count > 1 {
                        newWords.name = result.first
                        newWords.check = result.last
                    } else {
                        newWords.name = tempArray[i]
                    }
                    CoreDataManager.instance.saveContext()
                    wordsArray.append(newWords)
                }

                self.dismiss(animated: true, completion: nil)
            } else {
                
                currentList = groupsArray.count
                let newGroup = Group()
                newGroup.name = titleTextField.text
                groupsArray.append(newGroup)
                CoreDataManager.instance.saveContext()
                
                let newWordsArray = newWordsTextView.text?.components(separatedBy: "\n")
                let tempArray = newWordsArray?.filter({ (line) -> Bool in
                    let newLine = line.filter { $0 != " " }
                    return newLine != "" ? true : false
                }) ?? []
                
                for i in 0...tempArray.count - 1 {
                    let newWords = Words()
                    newWords.group = groupsArray[currentList]
                    let separators = NSCharacterSet(charactersIn: "@")
                    let result = tempArray[i].components(separatedBy: separators as CharacterSet)
                    if result.count > 1 {
                        newWords.name = result.first
                        newWords.check = result.last
                    } else {
                        newWords.name = tempArray[i]
                    }
                    CoreDataManager.instance.saveContext()
                    wordsArray.append(newWords)
                }
                
                self.dismiss(animated: true, completion: nil)
                newList = false
                 
            }
        } else
        {
            let message = "List name not specified"
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(alertButton)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }

}

