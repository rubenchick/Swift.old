//
//  CustomerViewController.swift
//  Test Core Data
//
//  Created by Anton Rubenchik on 10.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData

class CustomerViewController: UIViewController {
    
    var customer : Customer?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var infoTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let customer = customer {
            nameTextField.text = customer.name
            infoTextField.text = customer.info
        }        
    }
  
    @IBAction func pressSave(_ sender: UIBarButtonItem) {
        if saveCustomer() {
            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func pressCancel(_ sender: Any) {
        if (nameTextField.text != "") {
            dismiss(animated: true, completion: nil)
        } else {
            if customer != nil {
                let alert = UIAlertController(title: "Warning", message: "Need enter name of company", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(okButton)
                present(alert, animated: true, completion: nil)
            } else {
                dismiss(animated: true, completion: nil)
            }
            
        }
    }
    
    func saveCustomer() -> Bool {
        if customer == nil {
            customer = Customer()
//            customer?.name = nameTextField.text
//            customer?.info = infoTextField.text
            
//            let entity = NSEntityDescription.entity(forEntityName: "Customer", in: CoreDataManager.instance.persistentContainer.viewContext)
//            let newCustomer = NSManagedObject(entity: entity!, insertInto: CoreDataManager.instance.persistentContainer.viewContext) as! Customer
//            newCustomer.name = nameTextField.text
//            newCustomer.info = infoTextField.text
        }
        if nameTextField.text == "" {
            let alert = UIAlertController(title: "Warning", message: "Need enter name of company", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
            return false
        } else {
            customer?.name = nameTextField.text
            customer?.info = infoTextField.text
            CoreDataManager.instance.saveContext()
           return true
        }
    }
    
}
