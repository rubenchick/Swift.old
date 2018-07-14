//
//  OrdersTableViewController.swift
//  Test Core Data
//
//  Created by Anton Rubenchik on 11.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class OrdersTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    let identifierSegue = "odersToOder"
    let identifierCell = "ordersCell"
    var fetchedResultsController
        = CoreDataManager.instance.fetchedResultsController(entityName: "Order", keyForSort: "date")
    var fetchedResultsControllerCustomer
        = CoreDataManager.instance.fetchedResultsController(entityName: "Customer", keyForSort: "name")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }

    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        guard let countOfSection = fetchedResultsController.sections?.count else {
            return 0
        }
        
        return countOfSection
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let sections = fetchedResultsController.sections else {
            return 0
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath)
        if let order = fetchedResultsController.object(at: indexPath) as? Order {
            cell.textLabel?.text = convertOrder(toString: order)
        }
        return cell
    }
    
    func convertOrder(toString order: Order) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        let title = formatter.string(from: order.date! as Date) + "  " + (order.customer?.name)!
        return title
    }

    @IBAction func pressAdd(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: identifierSegue, sender: nil)
//        let order = Order()
//        let customer = fetchedResultsControllerCustomer.fetchedObjects?.first as! Customer
////        let service = fetchedResultsControllerServices.fetchedObjects?.first as! Services
////        let rowOfOrder = fetchedResultsControllerRow.fetchedObjects
//
//        order.date = NSDate() as Date
//        order.made = false
//        order.customer = customer
//        CoreDataManager.instance.saveContext()
////        print(fetchedResultsController.fetchedObjects?.count)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifierSegue {
            let controller = segue.destination as! OrderViewController
            controller.order = sender as? Order
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = fetchedResultsController.object(at: indexPath) as! Order
        performSegue(withIdentifier: identifierSegue, sender: order)
    }
    
//MARK: Ruler for editing TableView
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
                let order = fetchedResultsController.object(at: indexPath) as! Order
                let cell = tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = convertOrder(toString: order)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObject = fetchedResultsController.object(at: indexPath) as! NSManagedObject
            CoreDataManager.instance.persistentContainer.viewContext.delete(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }

}
