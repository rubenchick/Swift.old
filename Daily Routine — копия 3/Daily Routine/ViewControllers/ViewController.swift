// FOR TEST. Doesn't use in real program
//  ViewController.swift
//  Daily Routine
//
//  Created by Anton Rubenchik on 15.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, NSFetchedResultsControllerDelegate {
//    var fetchRequestThingToDo = CoreDataManager.instance.fetchedResultsController(entityName: "ThingToDo", keyForSort: "priority")
//    var fetchRequestHistory = CoreDataManager.instance.fetchedResultsController(entityName: "History", keyForSort: "date")
//
    @IBOutlet weak var moButton: UIButton!
    @IBOutlet weak var weeklyView: UIView!
    @IBAction func anyTimesButton(_ sender: UIButton) {
        weeklyView.isHidden = false
    }
    @IBOutlet weak var workLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createStartElement()
        weeklyView.frame.size.height = weeklyView.frame.size.width
//        fetchRequestHistory.delegate = self
//        fetchRequestThingToDo.delegate = self
//        do {
//            try fetchRequestThingToDo.performFetch()
//        } catch {
//            print(error)
//        }
//        do {
//            try fetchRequestHistory.performFetch()
//        } catch {
//            print(error)
//        }
//        print("Count - \(String(describing: fetchRequest.fetchedObjects?.count))")

//        print("It is work")
        
        /// Test
        print("Yes")
        
        let data = Date()
        print(data)
        print(data.dayNumberOfWeek()!)
        print(data.dayNumberOfMonth()!)
        
        
        
        

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        workLabel.isUserInteractionEnabled = true
        workLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        guard let a = (sender.view as? UILabel)?.text else { return }
        print(a)
        
    }
    
    func createStartElement() {
        weeklyView.layer.cornerRadius = 15
        let dayArray = ["Пн","Вт","Ср","Чт","Пт","Сб","Вс"]
        let widht = Int(weeklyView.frame.size.width / 13)
        print(weeklyView.frame.size.width)
        print(widht)
        for i in 1...7 {
            let dayButton = UIButton(type: .system)
            
            dayButton.frame = CGRect(x: Int(Double(widht)*1.5) + (i - 1) * Int(Double(widht) * 1.5) , y: widht * 2, width: widht, height: widht)
            dayButton.layer.cornerRadius = CGFloat(Double(widht) / 2)
            if i > 4 {
            dayButton.layer.cornerRadius = CGFloat(Double(widht) / 2)
            }
            else {
             dayButton.layer.cornerRadius = CGFloat(Double(widht) / 5)
            }
            dayButton.clipsToBounds = true
            dayButton.backgroundColor = .lightGray
            dayButton.setTitle(dayArray[i - 1], for : UIControlState.normal)
            dayButton.setTitleColor(UIColor(red: 51/255, green: 102/255, blue: 153/255, alpha: 1), for: .normal)
            dayButton.setTitleColor(.lightGray, for: .selected)
            dayButton.tag = i
            dayButton.addTarget(self, action: #selector(pressButton), for: .touchDown)
            weeklyView.addSubview(dayButton)
        }
    }
    
    @objc func pressButton(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func pressMoButton(_ sender: UIButton) {
        let x = sender.tag
        moButton.isSelected = !moButton.isSelected
    }
    
    @IBAction func changeCountTimes(_ sender: UIStepper) {
        
    }
    @IBAction func newItemThingToGo(_ sender: UIButton) {
//        print("SaveNewRecords")
//        let thing = ThingToDo()
//        thing.name = "Other Way"
//        thing.priority = 50
//        thing.note = "Second line"
//        thing.isActual = true
//        CoreDataManager.instance.saveContext()
//
    }
    @IBAction func movedButton(_ sender: UIButton) {
//        let result = fetchRequestThingToDo.fetchedObjects as! [ThingToDo]
//        for thing in result {
//            if thing.isActual {
//                let item = History()
//                item.date = Date() as NSDate
//                item.thingToDo = thing
//                item.isDone = false
//            }
//        }
//        CoreDataManager.instance.saveContext()
//        print("Moved is work")
    }
    
    @IBAction func addNewThingButton(_ sender: UIButton) {
//                let item = ThingToDo()
//                item.name = "Clean my teeth"
//                item.isActual = false
//                item.priority = 60
//                CoreDataManager.instance.saveContext()
        // reinstall button
//        print("Count ThingToDo- \(String(describing: fetchRequestThingToDo.fetchedObjects?.count))")

    }
    
    @IBAction func pressDeleteItemsInHistory(_ sender: UIButton) {
//        if let result = fetchRequestHistory.fetchedObjects {
//            for item in result {
//                CoreDataManager.instance.persistentContainer.viewContext.delete(item as! NSManagedObject)
//            }
//            CoreDataManager.instance.saveContext()
//        }
//
//        print("Deleted is finished")
//
    }
    
    @IBAction func fetchHowManyCountInHistory(_ sender: UIButton) {
//        print("Count History- \(String(describing: fetchRequestHistory.fetchedObjects?.count))")
    }
    
    @IBAction func changeDate(_ sender: UIButton) {
//        let index = IndexPath(row: 0, section: 0)
//        let first = fetchRequestHistory.object(at: index) as! History
//        let tomorrow = Calendar.current.date(byAdding: .day, value: -50, to: first.date as! Date)
//        first.date = tomorrow as! NSDate
//        CoreDataManager.instance.saveContext()
//////        let newDate = first.date
//        let formatter = DateFormatter()
//        formatter.timeStyle = .none
//        formatter.dateStyle = .short
////        let tomorrow = Calendar.current.date(byAdding: .day, value: -50, to: first.date as! Date)
////        print(formatter.string(from: tomorrow!))
//        let results = fetchRequestHistory.fetchedObjects as! [History]
//        for result in results {
//            print(formatter.string(from: result.date! as Date))
//        }

        
        
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
////        switch type {
////        case .insert:
////            if let indexPath = newIndexPath {
//                tableView.insertRows(at: [indexPath], with: .automatic)
//            }
//        case .update:
//            if let indexPath = indexPath {
//                let customer = fetchedResultsController.object(at: indexPath) as! Services
//                let cell = tableView.cellForRow(at: indexPath)
//                cell?.textLabel?.text = customer.name
//                cell?.detailTextLabel?.text = customer.info
//            }
//        case .move:
//            if let indexPath = indexPath {
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//            }
//            if let newIndexPath = newIndexPath {
//                tableView.insertRows(at: [newIndexPath], with: .fade)
//            }
//        case .delete:
//            if let indexPath = indexPath {
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//            }
//        }
    }
}

