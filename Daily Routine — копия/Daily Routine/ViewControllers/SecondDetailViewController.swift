//
//  SecondDetailViewController.swift
//  Daily Routine
//
//  Created by Anton Rubenchik on 21.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class SecondDetailViewController: UIViewController {
    var thingToDo: ThingToDo?
    var count: Int?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var noteTExtField: UITextField!
    @IBOutlet weak var addInfoToNoteLabel: UILabel!
    @IBOutlet weak var countTimesTextField: UITextField!
    @IBOutlet weak var infoToNoteSegmentControl: UISegmentedControl!
    @IBOutlet weak var countTimesStepperOutlet: UIStepper!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        UIApplication.shared.statusBarView?.backgroundColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let thingToDo = thingToDo {
            nameTextField.text = thingToDo.name
            noteTExtField.text = thingToDo.note
        }

    }

    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if saveThingToDo() {
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Внимание", message: "Не введено название ", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    func addInfoToNote(atIndex index: Int) -> String{
        let timeForDayDictionary = [2: ["утром","вечером"],
                                    3: ["утром","днем","вечером"],
                                    4: ["утром","до обеда","после обеда","вечером"],
                                    5: ["утром","до обеда","после обеда","вечером","ночью"]]
        let endOfNumbersArray = ["-ой","-ый","-ой","-ий","-ый","-ый","-ой","-ой","-ой","-ой","-ой"]
        var addInfo = ""
        if let times = Int(countTimesTextField.text!) {
            if times > 1 {
                if infoToNoteSegmentControl.selectedSegmentIndex != 0 {
                    if infoToNoteSegmentControl.selectedSegmentIndex == 1 {
                        addInfo = "(\(index)\(endOfNumbersArray[index]) раз) "
                    } else {
                        let timeForDayArray = timeForDayDictionary[times]
                        addInfo = "( " + timeForDayArray![index-1] + " ) "
                    }
                }
            }
        }
        return addInfo
    }
    
    func saveThingToDo() -> Bool {
        if nameTextField.text != "" {
            if thingToDo == nil {
                thingToDo = ThingToDo()
                let history = History()
                history.date = Date() as NSDate
                history.isDone = false
                history.thingToDo = thingToDo
                if let count = count {
                    thingToDo?.priority = NSDecimalNumber(value: count)
                } else {
                    thingToDo?.priority = NSDecimalNumber(value: 100)
                }
                thingToDo?.isActual = true
            }
            
            thingToDo?.name = nameTextField.text
            thingToDo?.note = addInfoToNote(atIndex: 1) + noteTExtField.text!
            CoreDataManager.instance.saveContext()
            
            if let times = Int(countTimesTextField.text!) {
                if times > 1 {
                    for i in 2...times {
                        let newThingToDo = ThingToDo()
                        let newHistory = History()
                        newHistory.date = Date() as NSDate
                        newHistory.isDone = false
                        newHistory.thingToDo = newThingToDo
                        if let count = count {
                            newThingToDo.priority = NSDecimalNumber(value: count + i)
                        } else {
                            newThingToDo.priority = NSDecimalNumber(value: 100)
                        }
                        newThingToDo.isActual = true
                        newThingToDo.name = nameTextField.text
                        newThingToDo.note = addInfoToNote(atIndex: i) + noteTExtField.text!
                    }
                    CoreDataManager.instance.saveContext()
                }
            }
            return true
        } else {
            return false
        }
    }
    @IBAction func countTimesStepper(_ sender: UIStepper) {
        
        countTimesTextField.text = "\(Int(countTimesStepperOutlet.value))"
        if countTimesStepperOutlet.value > 1 {
            addInfoToNoteLabel.isEnabled = true
            infoToNoteSegmentControl.isEnabled  = true
        } else {
            addInfoToNoteLabel.isEnabled = false
            infoToNoteSegmentControl.isEnabled = false
        }
        if countTimesStepperOutlet.value > 5 {
            infoToNoteSegmentControl.setEnabled(false, forSegmentAt: 2)
            infoToNoteSegmentControl.selectedSegmentIndex = 1
        } else {
            infoToNoteSegmentControl.setEnabled(true, forSegmentAt: 2)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

