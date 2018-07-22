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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

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
    func saveThingToDo() -> Bool {
        if nameTextField.text != "" {
            if thingToDo == nil {
                thingToDo = ThingToDo()
            }
            thingToDo?.name = nameTextField.text
            if let count = count {
                thingToDo?.priority = NSDecimalNumber(value: count)
            } else {
                thingToDo?.priority = NSDecimalNumber(value: 100)
            }
            thingToDo?.isActual = true
            thingToDo?.note = noteTExtField.text
            let history = History()
            history.date = Date() as NSDate
            history.isDone = false
            history.thingToDo = thingToDo
            CoreDataManager.instance.saveContext()
            
            return true
        } else {
            return false
        }
    }
}
