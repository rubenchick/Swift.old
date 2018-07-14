//
//  RowOfOderViewController.swift
//  Test Core Data
//
//  Created by Anton Rubenchik on 12.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData

class RowOfOderViewController: UIViewController {

    
    // MARK: var & Let
    let identifierSegueRowToServices = "rowToServices"
    var order : Order?
    var rowOfOder : RowOfOder?
    var fetchedResultsControllerServices
        = CoreDataManager.instance.fetchedResultsController(entityName: "Services", keyForSort: "name")
    var fetchedResultsControllerRow
        = CoreDataManager.instance.fetchedResultsController(entityName: "RowOfOder", keyForSort: "sum")
    
    // MARK: @IBOutlet
    @IBOutlet weak var nameServiceTextField: UITextField!
    @IBOutlet weak var costTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if rowOfOder != nil {
            costTextField.text = "\((rowOfOder?.sum)!)"
            nameServiceTextField.text = rowOfOder?.services?.name
        }
        do {
            try fetchedResultsControllerServices.performFetch()
        } catch {
            print(error)
        }
        do {
            try fetchedResultsControllerRow.performFetch()
        } catch {
            print(error)
        }
        
    }
    
    // MARK: @IBAction
    @IBAction func pressChooseService(_ sender: UIButton) {
        performSegue(withIdentifier: identifierSegueRowToServices, sender: nil)
    }
    
    
    @IBAction func pressSave(_ sender: UIBarButtonItem) {
        if saveOrder() {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func pressCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK:  Fuction secondary
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifierSegueRowToServices {
            let viewController = segue.destination as! ServicesTableViewController
            // create new row
            if rowOfOder == nil {
                let service = fetchedResultsControllerServices.fetchedObjects?.first as! Services
                rowOfOder = RowOfOder()
                rowOfOder?.order = order
                rowOfOder?.services = service
            }
            viewController.didSelect = { [unowned self] (service) in
                if let service = service {
                    self.rowOfOder?.services = service
                    self.nameServiceTextField.text = service.name
                }
            }
        }
    }
    
    func saveOrder()-> Bool {
        
        if rowOfOder == nil {
            let alert = UIAlertController(title: "Warning", message: "You need choose a service", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
            return false
        } else {
            rowOfOder?.sum = (costTextField.text! as NSString).floatValue
            CoreDataManager.instance.saveContext()
        }
        return true
    }

}
