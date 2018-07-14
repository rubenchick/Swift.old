//
//  CustomerTableViewController.swift
//  Test Core Data
//
//  Created by Anton Rubenchik on 06.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData

class CustomerTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    typealias Select = (Customer?) -> ()
    var didSelect: Select?
    
    let segueIdetntifyToDetailVC = "customersToCustomer"
    
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "Customer", keyForSort: "name")
    
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
        guard let sections = fetchedResultsController.sections else {
            return 0
        }
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else {
            return 0
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
        
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customerCell", for: indexPath)
        let result = fetchedResultsController.object(at: indexPath) as! Customer
        cell.textLabel?.text = result.name
        cell.detailTextLabel?.text = result.info

        return cell
    }
    
    @IBAction func pressTrash(_ sender: UIBarButtonItem) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let context = CoreDataManager.instance.persistentContainer.viewContext
            let deleteItem = fetchedResultsController.object(at: (indexPath)) as! Customer
            context.delete(deleteItem)
            do {
                try context.save()
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func addAction(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Enter", message: "new company", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.saveNewCustomer(name: (alert.textFields?[0].text)!, info: alert.textFields?[1].text)
//            self.tableView.reloadData()

        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField(configurationHandler: nil)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func saveNewCustomer(name: String, info: String?){

        let context = CoreDataManager.instance.persistentContainer.viewContext
        let newCustomer = Customer()
        newCustomer.name = name
        newCustomer.info = info
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    @IBAction func addCustomer(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: segueIdetntifyToDetailVC, sender: nil)
    }
    
    // отправляем данные при переходе по seque
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let customer = fetchedResultsController.object(at: indexPath) as? Customer
        
        if let dSelect = didSelect {
            dSelect(customer)
            dismiss(animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: segueIdetntifyToDetailVC, sender: customer)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdetntifyToDetailVC {
            let controller = segue.destination as! CustomerViewController
            controller.customer = sender as? Customer
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
                let customer = fetchedResultsController.object(at: indexPath) as! Customer
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

//// -----------------------------------------------------------------------
//// -----------------------------------------------------------------------
////                      Version 2.0 whit Array
//// -----------------------------------------------------------------------
//// -----------------------------------------------------------------------

//class CustomerTableViewController: UITableViewController {
//
//    var customersArray : [Customer] = []
//
//    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Customer")
//        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//        return fetchedResultsController
//    }
//
//    //    override func viewWillAppear(_ animated: Bool) {
//    //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    //        let context = appDelegate.persistentContainer.viewContext
//    //        // выгружаем данные с места хранения в массив
//    //        let request : NSFetchRequest<Customer> = Customer.fetchRequest()
//    //        do {
//    //          customersArray = try context.fetch(request)
//    //            print(customersArray.count)
//    //            for (i, result) in zip(customersArray.indices, customersArray)  {
//    //                if result.name == "Garprom" {
//    //                    context.delete(result)
//    //                    customersArray.remove(at: i)
//    //                }
//    //                print(result.name ?? "norm")
//    //            }
//    //            appDelegate.saveContext()
//    //            self.tableView.reloadData()
//    //
//    //        } catch {
//    //            print("error")
//    //        }
//    //    }
//    override func viewWillAppear(_ animated: Bool) {
//
//        //        let context = CoreDataManager.instance.persistentContainer.viewContext
//        //        // выгружаем данные с места хранения в массив
//        //        let request : NSFetchRequest<Customer> = Customer.fetchRequest()
//        //        do {
//        //            customersArray = try context.fetch(request)
//        //            print(customersArray.count)
//        //            for (i, result) in zip(customersArray.indices, customersArray)  {
//        //                if result.name == "Garprom" {
//        //                    context.delete(result)
//        //                    customersArray.remove(at: i)
//        //                }
//        //                print(result.name ?? "norm")
//        //            }
//        //            CoreDataManager.instance.saveContext()
//        //            self.tableView.reloadData()
//        //
//        //        } catch {
//        //            print("error")
//        //        }
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //        self.navigationItem.rightBarButtonItem = self.editButtonItem
//        do {
//            try fetchedResultsController.performFetch()
//        } catch {
//            print(error)
//        }
//    }
//
//
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return customersArray.count
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "customerCell", for: indexPath)
//        cell.textLabel?.text = customersArray[indexPath.row].name
//        cell.detailTextLabel?.text = customersArray[indexPath.row].info
//        return cell
//    }
//
//    //    @IBAction func pressTrash(_ sender: UIBarButtonItem) {
//    //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    //        let context = appDelegate.persistentContainer.viewContext
//    //        let deleteItem = customersArray[(tableView.indexPathForSelectedRow?.row)!]
//    //        context.delete(deleteItem)
//    //        customersArray.remove(at: (tableView.indexPathForSelectedRow?.row)!)
//    //        let entity = NSEntityDescription.entity(forEntityName: "Customer", in: context)
//    //
//    //        let newCustomer = NSManagedObject(entity: entity!, insertInto: context) as! Customer
//    //        newCustomer.name = "Piter"
//    //        newCustomer.info = "drink"
//    //        do {
//    //            try context.save()
//    //            customersArray.append(newCustomer)
//    //
//    //        } catch {
//    //            print(error.localizedDescription)
//    //        }
//    //        tableView.reloadData()
//    //    }
//    @IBAction func pressTrash(_ sender: UIBarButtonItem) {
//
//        let context = CoreDataManager.instance.persistentContainer.viewContext
//        let deleteItem = customersArray[(tableView.indexPathForSelectedRow?.row)!]
//        context.delete(deleteItem)
//        customersArray.remove(at: (tableView.indexPathForSelectedRow?.row)!)
//        let newCustomer = Customer()
//        newCustomer.name = "Piter"
//        newCustomer.info = "drink"
//        do {
//            try context.save()
//            customersArray.append(newCustomer)
//
//        } catch {
//            print(error.localizedDescription)
//        }
//        tableView.reloadData()
//    }
//
//    @IBAction func addAction(_ sender: UIBarButtonItem) {
//        print("Yes")
//        let alert = UIAlertController(title: "Enter", message: "new company", preferredStyle: .alert)
//        let ok = UIAlertAction(title: "Ok", style: .default, handler: { action in
//            print(alert.textFields![0].text!)
//            self.saveNewCustomer(name: (alert.textFields?[0].text)!, info: alert.textFields?[1].text)
//            self.tableView.reloadData()
//
//        })
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alert.addTextField(configurationHandler: nil)
//        alert.addTextField(configurationHandler: nil)
//        alert.addAction(cancel)
//        alert.addAction(ok)
//        present(alert, animated: true, completion: nil)
//    }
//
//    func saveNewCustomer(name: String, info: String?){
//
//        let context = CoreDataManager.instance.persistentContainer.viewContext
//        let newCustomer = Customer()
//        newCustomer.name = name
//        newCustomer.info = info
//        do {
//            try context.save()
//            customersArray.append(newCustomer)
//
//        } catch {
//            print(error.localizedDescription)
//        }
//
//    }

//    lazy var fetchedResultsController: NSFetchedResultsController<Customer> = {
//        let fetchRequest: NSFetchRequest<Customer> = Customer.fetchRequest()
//
//        // Add sort
//        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//
//        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//
//        return fetchedResultsController
//    }()
//}
//// -----------------------------------------------------------------------
//// -----------------------------------------------------------------------
////                      END Version 2.0 whit Array
//// -----------------------------------------------------------------------
//// -----------------------------------------------------------------------


