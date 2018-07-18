//
//  MainTableViewController.swift
//  Daily Routine
//
//  Created by Anton Rubenchik on 16.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, MainTableViewCellDelegate {
//    var fetchRequest = CoreDataManager.instance.fetchedResultsController(entityName: "History", keyForSort: "thingToDo.priority")
    var fetchRequest = History.fetchedResults()
    var fetchRequestIsActual = ThingToDo.fetchedResultsIsActual()
    
    let identifierCell = "mainCell"
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        UIApplication.shared.statusBarView?.backgroundColor = .black
        tableView.tableFooterView = UIView()
   
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        fetchRequestIsActual.delegate = self
        
        do {
            try fetchRequestIsActual.performFetch()
        } catch {
            print(error)
        }
        checkDateInToday()
        
//        self.navigationItem.rightBarButtonItem = self.editButtonItem
        fetchRequest.delegate = self
        do {
            try fetchRequest.performFetch()
        } catch {
            print(error)
        }
    }
    // MARK:  Add Function
    func checkDateInToday() {
        //#needAdd
        // Доработать
//        var calendar = Calendar.current
//        calendar.timeZone = NSTimeZone.local
//        let dayToday = calendar.startOfDay(for: Date())
        
        
//        // add yesterday day for testing
//        let dayToday = Date()
//        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: dayToday)
//        UserDefaults.standard.set(yesterday, forKey: "dateToday")
//        UserDefaults.standard.synchronize()
//        print(yesterday)
        
        // take date from UserDefaults
        var savedDate = Date()
        if UserDefaults.standard.value(forKey: "dateToday") != nil {
            savedDate = UserDefaults.standard.value(forKey: "dateToday") as! Date
        }
        
        // check date in User with today()
        //#needAdd current todayDate. In local
        let dateToday = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        if formatter.string(from: dateToday) == formatter.string(from: savedDate) {
            print("equite \(formatter.string(from: dateToday))")
        } else {
            let result = fetchRequestIsActual.fetchedObjects as! [ThingToDo]
            for thing in result {
                let item = History()
                item.date = dateToday as NSDate
                item.thingToDo = thing
                item.isDone = false
            }
            CoreDataManager.instance.saveContext()
            // save today in UserDefaults
            UserDefaults.standard.set(dateToday, forKey: "dateToday")
            UserDefaults.standard.synchronize()
            print("!= old is \(formatter.string(from: savedDate))")
        }
        
        
        
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
        //let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath)
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath) as? MainTableViewCell {
            let todayThing = fetchRequest.object(at: indexPath) as! History
            let formatter = DateFormatter()
            formatter.timeStyle = .none
            formatter.dateStyle = .short
            let newData = Thing(name: (todayThing.thingToDo?.name)! + " \(formatter.string(from: todayThing.date as! Date))",
                                note: "any text", isActual: todayThing.isDone)
            cell.getData(item: newData)
            cell.delegate = self
            return cell
            
        } else {
                return UITableViewCell()
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func didTappedSwitchCell(cell: MainTableViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        let thing = fetchRequest.object(at: indexPath!) as! History
        thing.isDone = cell.isActualSwitch.isOn
        CoreDataManager.instance.saveContext()
        
//        print(indexPath,cell.isActualSwitch.isOn)
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

