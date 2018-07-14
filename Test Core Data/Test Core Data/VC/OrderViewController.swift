//
//  OrderViewController.swift
//  Test Core Data
//
//  Created by Anton Rubenchik on 11.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    var table : NSFetchedResultsController<NSFetchRequestResult>?
    
    let identifierSegueOrderToCustomers = "orderToCustomers"
    let identifierSegueOrderToRow = "oderToRow"
    let identifierCell = "rowCell"
    var order : Order?
    var fetchedResultsControllerCustomer
        = CoreDataManager.instance.fetchedResultsController(entityName: "Customer", keyForSort: "name")
//    var fetchedResultsControllerRow
//        = CoreDataManager.instance.fetchedResultsController(entityName: "RowOfOder", keyForSort: "services.name")

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var madeSwitch: UISwitch!
    @IBOutlet weak var paidSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var customerNameTextField: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        do {
            try fetchedResultsControllerCustomer.performFetch()
        } catch {
            print(error)
        }
        
//        do {
//            try fetchedResultsControllerRow.performFetch()
//        } catch {
//            print(error)
//        }
        
        if let order = order  {
            if let temp = order.date {
                datePicker.date = temp as Date
            }
            customerNameTextField.text = order.customer?.name
            madeSwitch.isOn = order.made
            paidSwitch.isOn = order.paid

            table = Order.fetchedResults(forOrder: order)
            do {
                try table?.performFetch()
            } catch {
                print(error)
            }
            table?.delegate = self
          }
    }

    @IBAction func pressCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func pressSave(_ sender: UIBarButtonItem) {
        if saveOrder() {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func saveOrder() -> Bool {
        // whitout check. Need to fix
        if order == nil {
            let alert = UIAlertController(title: "Warning", message: "You need to choose customer", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
            return false
        }
        // save new data
        if let order = order {
            order.date = datePicker.date as NSDate
            order.made = madeSwitch.isOn
            order.paid = paidSwitch.isOn
            CoreDataManager.instance.saveContext()
        }
        
        return true
    }
    
    @IBAction func pressSelectCustomer(_ sender: UIButton) {
        performSegue(withIdentifier: identifierSegueOrderToCustomers, sender: nil)
    }
    
    @IBAction func pressAddRowOfServices(_ sender: UIButton) {
        performSegue(withIdentifier: identifierSegueOrderToRow, sender: nil)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowOfOder = table?.object(at: indexPath) as? RowOfOder
        performSegue(withIdentifier: identifierSegueOrderToRow, sender: rowOfOder )
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifierSegueOrderToCustomers {
            let viewController = segue.destination as! CustomerTableViewController
            // create new order
            if order == nil {
                let customer = fetchedResultsControllerCustomer.fetchedObjects?.first as! Customer
                order = Order()
                order?.date = datePicker.date as NSDate
                order?.customer = customer
            }
            viewController.didSelect = { [unowned self] (customer) in
                if let customer = customer {
                    self.order?.customer = customer
                    self.customerNameTextField.text = customer.name
                }
            }
        }
        if segue.identifier == identifierSegueOrderToRow {
            let viewController = segue.destination as! RowOfOderViewController
            viewController.order = order
            viewController.rowOfOder = sender as? RowOfOder
        }
        
        
        
//        func fetchedResultsController2(entityName: String, keyForSort: String) -> NSFetchedResultsController<NSFetchRequestResult> {
//
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//
//            // Add sort
//            let sortDescriptor = NSSortDescriptor(key: keyForSort, ascending: true)
//            fetchRequest.sortDescriptors = [sortDescriptor]
//
//            let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//
//            return fetchedResultsController
//        }
    }
    

    
    // MARK: Extantion for Delegate and DataSourse

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // need fix
//        return (fetchedResultsControllerRow.fetchedObjects?.count)!
        return table?.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath)
        if let rowOfOder = table?.object(at: indexPath) as? RowOfOder {
            cell.textLabel?.text = "\((rowOfOder.services?.name)!) - \(rowOfOder.sum) руб."
        }
//        let rowOfOder = fetchedResultsControllerRow.object(at: indexPath) as! RowOfOder
//        cell.textLabel?.text = "\((rowOfOder.services?.name)!) - \(rowOfOder.sum) руб."
        return cell
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let rowOfOder = table?.object(at: indexPath) as! RowOfOder
                let cell = tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = "\((rowOfOder.services?.name)!) - \(rowOfOder.sum) руб."
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObject = table?.object(at: indexPath) as! NSManagedObject
            CoreDataManager.instance.persistentContainer.viewContext.delete(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }
    
    
    
    
    
    
}
