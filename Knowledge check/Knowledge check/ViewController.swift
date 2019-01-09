//
//  ViewController.swift
//  Knowledge check
//
//  Created by Anton Rubenchik on 15/11/2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, NSFetchedResultsControllerDelegate {

    var groupFetchRequest = Group.fetchedResults()
    
    @IBOutlet weak var arrayPicker: UIPickerView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var helpLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        arrayPicker.reloadAllComponents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupFetchRequest.delegate = self
        do {
            try groupFetchRequest.performFetch()
        } catch {
            print(error)
        }
        
        startProcess()

        
        arrayPicker.dataSource = self
        arrayPicker.delegate = self
        arrayPicker.selectRow(currentList, inComponent: 0, animated: false)
        
        let tapGestureForWordLabel = UITapGestureRecognizer(target: self, action: #selector(tapForWordLabel))
        wordLabel.isUserInteractionEnabled = true
        wordLabel.addGestureRecognizer(tapGestureForWordLabel)

        
        // NEED check for equil count globalArray and titleGlobalArray
    }
    @objc func tapForWordLabel(sender: UITapGestureRecognizer) {
        guard let _ = sender.view as? UILabel else { return }
        helpLabel.isHidden = false
    }
    func startProcess() {
        //create array Group
        groupsArray = groupFetchRequest.fetchedObjects as! [Group]
        if groupsArray.count > 0 {
            //create array words from first group
            let wordsArrayFetchRequest = Words.fetchedResults(forThisGroup: groupsArray[currentList])
            do {
                try wordsArrayFetchRequest.performFetch()
                wordsArrayFetchRequest.delegate = self
            } catch {
                print(error)
            }
            wordsArray = wordsArrayFetchRequest.fetchedObjects as! [Words]
        }
        if wordsArray.count > 0 {
            wordLabel.text = wordsArray[0].name
            helpLabel.text = wordsArray[0].check
        } else {
            wordLabel.text = "Empty"
        }
    }
    
    
    @IBAction func newButton(_ sender: UIButton) {
        newList = true
    }
    
    @IBAction func editButton(_ sender: UIButton) {
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        let word = wordsArray.randomElement()
        wordLabel.text = word?.name
        helpLabel.text = (word?.check != nil && word?.check != "") ?  word?.check : "---"
        helpLabel.isHidden = true
    }
    
    
}
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return groupsArray.count
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return groupsArray[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentList = row
        // create words this group
        let wordsArrayFetchRequest = Words.fetchedResults(forThisGroup: groupsArray[row])
        do {
            try wordsArrayFetchRequest.performFetch()
            wordsArrayFetchRequest.delegate = self
        } catch {
            print(error)
        }
        wordsArray = wordsArrayFetchRequest.fetchedObjects as! [Words]
        for item in wordsArray {
            print(item.name)
        }
        print("---------")
        
        if wordsArray.count > 0 {
            wordLabel.text = wordsArray[0].name
        } else {
            wordLabel.text = "Empty"
        }
    }
}


