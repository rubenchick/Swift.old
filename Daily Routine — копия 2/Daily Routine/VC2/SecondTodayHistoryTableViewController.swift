//
//  SecondTodayHistoryTableViewController.swift
//  Daily Routine
//
//  Created by Anton Rubenchik on 21.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData
// NSFetchedResultsControllerDelegate,
class SecondTodayHistoryTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
  
    let identifierCell = "mainCell"
    var fetchRequest = History.fetchedResultsToday()
//    var fetchRequest = CoreDataManager.instance.fetchedResultsController(entityName: "History", keyForSort: "thingToDo.priority")
  
    override func viewWillAppear(_ animated: Bool) {
//        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        fetchRequest.delegate = self

        do {
            try fetchRequest.performFetch()
        } catch {
            print(error)
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let count = fetchRequest.fetchedObjects?.count {
            return count
        } else {
            return 0
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath)
        if let history = fetchRequest.object(at: indexPath) as? History {
            if let x = history.thingToDo {
                cell.textLabel?.text = x.name! + " \(String(describing: x.priority))"
            }
            
        }

        return cell
    }
    //MARK: Delegate for editing Table
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
                        let history = fetchRequest.object(at: indexPath) as! History
                        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath)
        
                        let formatter = DateFormatter()
                        formatter.timeStyle = .none
                        formatter.dateStyle = .short
//                        let newData = Thing(name: (history.thingToDo?.name)! + " \(formatter.string(from: history.date! as Date))",
//                            note: "any text", isActual: history.isDone)
//                        cell?.getData(item: newData)
                        if let x = history.thingToDo {
                            cell.textLabel?.text = x.name! + " \(String(describing: x.priority))"
                        }
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */



}
