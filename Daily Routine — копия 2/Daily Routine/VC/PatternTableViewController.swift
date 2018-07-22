//
//  PatternTableViewController.swift
//  Daily Routine
//
//  Created by Anton Rubenchik on 17.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData

class PatternTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    let identifierCell = "patternCell"
    let identifierSegue = "patternToDetail"
    var fetchRequest = ThingToDo.fetchedResultsIsActual()
    var array : [ThingToDo] = []
//    var fetchRequestHistoryToday = History.fetchedResultsToday()
    override func viewDidLoad() {
        super.viewDidLoad()
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
        fetchRequest.delegate = self
        do {
         try fetchRequest.performFetch()
        } catch {
            print(error)
        }
        tableView.tableFooterView = UIView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        
    }
    override func viewWillAppear(_ animated: Bool) {
//        tableView.reloadData()
    }
    @objc func doubleTapped() {
        tableView.isEditing = !tableView.isEditing
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        guard let countOfSection = fetchRequest.sections?.count else {
            return 0
        }
        return countOfSection
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let sections = fetchRequest.sections else {
            return 0
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath)
        let thing = fetchRequest.object(at: indexPath) as! ThingToDo
        cell.textLabel?.text = thing.name! + " \(thing.priority!)"
        cell.detailTextLabel?.text = thing.note
        return cell
    }
    
    //MARK: Leave page
    @IBAction func pressBackToMain(_ sender: UIBarButtonItem) {
        // test perfomSegue
//        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Move for editing Table
    @IBAction func addNewThing(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: identifierSegue, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print(indexPath)
        if let thing = fetchRequest.object(at: indexPath) as? ThingToDo {
            performSegue(withIdentifier: identifierSegue, sender: thing)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifierSegue {
            let controller = segue.destination as! DetailThingViewController
            let historyArray = fetchRequest.fetchedObjects?.count
            controller.lenght = historyArray
            controller.thing = sender as? ThingToDo
        }
    }

    //MARK: Delegate for editing Table
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
   
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if let temp = fetchRequest.fetchedObjects as? [ThingToDo] {
            array = temp
            array[sourceIndexPath.row].priority = NSDecimalNumber(value: destinationIndexPath.row)
            if sourceIndexPath.row < destinationIndexPath.row {
                for i in sourceIndexPath.row+1...destinationIndexPath.row {
                    array[i].priority = NSDecimalNumber(value: i - 1)
                }
            } else {
                for i in (destinationIndexPath.row...sourceIndexPath.row-1).reversed() {
                    array[i].priority = NSDecimalNumber(value: i + 1)
               }
            }
            CoreDataManager.instance.saveContext()
//            tableView.reloadData()
        }
    }


    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            print("INSERT___________________++++++++++++++++++__________________")
////            if let indexPath = newIndexPath {
////                tableView.insertRows(at: [indexPath], with: .automatic)
////            }
//        case .update:
//            print("UPDATE___________________++++++++++++++++++__________________")
//            if let indexPath = indexPath {
//                if let thing = fetchRequest.object(at: indexPath) as? ThingToDo {
//                    let cell = tableView.cellForRow(at: indexPath)
//                    cell?.textLabel?.text = thing.name
//                    cell?.detailTextLabel?.text = thing.note
//                }
//            }
//        case .move:
//            print("MOVE___________________++++++++++++++++++__________________")
//            if let indexPath = indexPath {
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//            }
//            if let newIndexPath = newIndexPath {
//                tableView.insertRows(at: [newIndexPath], with: .fade)
//            }
//        case .delete:
//            print("DELETE__in big module_________________++++++++++++++++++__________________")
//            if let indexPath = indexPath {
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//            }
//        }
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            let managedObject = fetchedResultsController.object(at: indexPath) as! NSManagedObject
//            CoreDataManager.instance.persistentContainer.viewContext.delete(managedObject)
            print("DELETE___________________++++++++++++++++++__________________")
            if let thing = fetchRequest.object(at: indexPath) as? ThingToDo {
                thing.isActual = false
                CoreDataManager.instance.saveContext()
                let historyFindThisThingToDo = ThingToDo.fetchedResultsHistoryToday(forThingToDo: thing)
                do {
                    try historyFindThisThingToDo.performFetch()
                } catch {
                    print(error)
                }
                if let historyToDelete = historyFindThisThingToDo.fetchedObjects?.first as? NSManagedObject {
                    CoreDataManager.instance.persistentContainer.viewContext.delete(historyToDelete)
                    print("delete - finished")
                }
                CoreDataManager.instance.saveContext()
                
                // prioritet
//                if let temp = fetchRequest.fetchedObjects as? [ThingToDo] {
//                    array = temp
//                    for i in 0...array.count-1 {
//                        array[i].priority = NSDecimalNumber(value: i)
//                    }
//
//                    CoreDataManager.instance.saveContext()
//                    tableView.reloadData()
//                }
            }

            
            
            //                let historyLinkFromThing = thing.history // что хотим удалить
            //                // ищем это в выгрузке
//                let historiesToday = fetchRequestHistory.fetchedObjects as! [NSManagedObject]
//                for history in historiesToday {
//                    if let newHistory = history as? History {
//                        if newHistory == historyLinkFromThing {
//                            print("Yes")
//                        } else {
//                           print("No")
////                            print("newHistory - \(newHistory.thingToDo?.name); History - \(historyLinkFromThing)")
//                        }
//
//                    }
//                }
//
//
////                    CoreDataManager.instance.persistentContainer.viewContext.delete(history)
//
//            }
        }
    }
    
//    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
//        let more = UITableViewRowAction(style: .normal, title: "More") { action, index in
//            print("more button tapped")
//        }
//        more.backgroundColor = .lightGray
//
//        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { action, index in
//            print("favorite button tapped")
//        }
//        favorite.backgroundColor = .orange
//
//        let share = UITableViewRowAction(style: .normal, title: "Share") { action, index in
//            print("share button tapped")
//        }
//        share.backgroundColor = .blue
//
//        return [share, favorite, more]
//    }
//    override func tableView(_ tableView: UITableView,
//                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//    {
//        let closeAction = UIContextualAction(style: .normal, title:  "Close", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//            print("OK, marked as Closed")
//            success(true)
//        })
////        closeAction.image = UIImage(named: "tick")
//        closeAction.backgroundColor = .purple
//        
//        return UISwipeActionsConfiguration(actions: [closeAction])
//        
//    }
    
//    override func tableView(_ tableView: UITableView,
//                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//    {
//        let modifyAction = UIContextualAction(style: .normal, title:  "Update", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//            print("Update action ...")
//            success(true)
//        })
////        modifyAction.image = UIImage(named: "hammer")
//        modifyAction.backgroundColor = .blue
//
//        return UISwipeActionsConfiguration(actions: [modifyAction])
//    }
    

    
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

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
