//
//  ServicesTableViewController.swift
//  Test Core Data
//
//  Created by Anton Rubenchik on 11.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData

class ServicesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    typealias Select = (Services?) -> ()
    var didSelect: Select?
    
    let identifierSegue = "servicesToService"
    let identifierCell = "servicesCell"
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "Services", keyForSort: "name")

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController.delegate = self
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        let item = fetchedResultsController.object(at: indexPath) as? Services
        cell.textLabel?.text = item?.name
        cell.detailTextLabel?.text = item?.info

        return cell
    }

    @IBAction func pressAdd(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: identifierSegue, sender: nil)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let service = fetchedResultsController.object(at: indexPath)
//        performSegue(withIdentifier: identifierSegue, sender: service)
        let service = fetchedResultsController.object(at: indexPath) as? Services
        if let dSelect = didSelect {
            dSelect(service)
            dismiss(animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: identifierSegue, sender: service)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifierSegue {
            let controller = segue.destination as! ServiceViewController
            controller.service = sender as? Services
        }
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
                let customer = fetchedResultsController.object(at: indexPath) as! Services
                let cell = tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = customer.name
                cell?.detailTextLabel?.text = customer.info
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
