//
//  ServiceViewController.swift
//  Test Core Data
//
//  Created by Anton Rubenchik on 11.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData

class ServiceViewController: UIViewController {
    var service : Services?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var infoTextFiled: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let service = service { // проверка на nil
            nameTextField.text = service.name
            infoTextFiled.text = service.info
        }

        // Do any additional setup after loading the view.
    }

    @IBAction func pressCancel(_ sender: Any) {
        if (nameTextField.text != "") {
            dismiss(animated: true, completion: nil)
        } else {
            if service != nil {
                let alert = UIAlertController(title: "Warning", message: "You need to enter a name of service", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(okButton)
                present(alert, animated: true, completion: nil)
            } else {
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func pressSave(_ sender: Any) {
        if saveService() {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func saveService() -> Bool {
        // create new service
        if service == nil {
            service = Services()
        }
        // save
        if nameTextField.text != "" {
            service?.name = nameTextField.text
            service?.info = infoTextFiled.text
            CoreDataManager.instance.saveContext()
           return true
        } else {
            let alert = UIAlertController(title: "Warning", message: "You need to enter a name of service", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
            return false
        }
    }
    
    
}
