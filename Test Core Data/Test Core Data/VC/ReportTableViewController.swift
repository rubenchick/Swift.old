//
//  ReportTableViewController.swift
//  Test Core Data
//
//  Created by Anton Rubenchik on 14.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData

class ReportTableViewController: UITableViewController {
    let identifierCell = "reportCell"
    // запрос
    var  fetchRequest: NSFetchRequest<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
        let sortDescriptor1 = NSSortDescriptor(key: "date", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "customer.name", ascending: true)
        //request.fetchLimit = 1 //ограничения по количеству строк
        fetchRequest.sortDescriptors = [sortDescriptor1,sortDescriptor2]
        let predicateFirst  = NSPredicate(format: "%K = %@", "made", NSNumber(value: true))
        let predicateSecond = NSPredicate(format: "%K = %@", "paid", NSNumber(value: false))
        let compound = NSCompoundPredicate.init(andPredicateWithSubpredicates:[predicateFirst,predicateSecond])
        fetchRequest.predicate = compound
        //        let predicateFirst = NSPredicate(format: "customer.name contains %@", "Get") // work
        //        let predicateFirst = NSPredicate(format: "customer.name = %@", "Gett") // work
        //        let predicateFirst = NSPredicate(format: "customer.name = %@", "Gett") // work
        //        fetchRequest.predicate = predicateFirst
        return fetchRequest
        
    }()
    
    var report: [Order]?
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try report = CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest) as! [Order]
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
        return (report?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath)
        let item = report![indexPath.row]
        cell.textLabel?.text = convertOrder(toString: item)
        cell.detailTextLabel?.text = "Made \(item.made), Paid \(item.paid)"
        return cell
    }
    
    func convertOrder(toString item: Order) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        let title = formatter.string(from: item.date! as Date) + "  " + (item.customer?.name)!
        return title
    }

}
