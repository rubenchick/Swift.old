//
//  SecondThingToDoTableViewController.swift
//  Daily Routine
//
//  Created by Anton Rubenchik on 21.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class SecondThingToDoTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let identifierCell = "thingToDoCell"
    let identifierSegue = "patternToDetail"
    var fetchRequest = ThingToDo.fetchedResultsIsActual()
    var array : [ThingToDo] = []
    var helpView = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        // ??????? not test it
//        setOrder() // need for record same priority because they don't everyday show
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setOrder()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkShowHelp()
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
    
    
    @objc func doubleTapped() {
//        tableView.isEditing = !tableView.isEditing
        if !helpView.isHidden {
            helpView.isHidden = true
        } else {
            tableView.isEditing = !tableView.isEditing
            tableView.reloadData()            
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
        if let thingToDo = fetchRequest.object(at: indexPath) as? ThingToDo {
            cell.textLabel?.text = thingToDo.name!// + " \(String(describing: thingToDo.priority))"
//            cell.textLabel?.text = thingToDo.name! + " \(String(describing: thingToDo.priority))"
            var addInfo = ""
            if !thingToDo.daily {
                if thingToDo.weekly {
                    addInfo = " ["
                    if let newWeek = thingToDo.week {
                        if newWeek.monday { addInfo = addInfo + NSLocalizedString("Mo.", comment: "") }
                        if newWeek.tuesday { addInfo = addInfo + " " + NSLocalizedString("Tu.", comment: "") }
                        if newWeek.wednesday { addInfo = addInfo + " " + NSLocalizedString("We.", comment: "") }
                        if newWeek.thursday { addInfo = addInfo + " " + NSLocalizedString("Th.", comment: "") }
                        if newWeek.friday { addInfo = addInfo + " " + NSLocalizedString("Fr.", comment: "") }
                        if newWeek.saturday { addInfo = addInfo + " " + NSLocalizedString("Sa.", comment: "") }
                        if newWeek.sunday { addInfo = addInfo + " " + NSLocalizedString("Su.", comment: "") }
                    }
//                    if let newWeek = thingToDo.week {
//                        if newWeek.monday { addInfo = addInfo + "Пн." }
//                        if newWeek.tuesday { addInfo = addInfo + " " + "Вт." }
//                        if newWeek.wednesday { addInfo = addInfo + " " + "Ср." }
//                        if newWeek.thursday { addInfo = addInfo + " " + "Чт." }
//                        if newWeek.friday { addInfo = addInfo + " " + "Пт." }
//                        if newWeek.saturday { addInfo = addInfo + " " + "Сб." }
//                        if newWeek.sunday { addInfo = addInfo + " Вс." }
//                    }
                    addInfo = addInfo + " ]"
                    if addInfo == " [ ]" { addInfo = ""}
                } else {
                    if thingToDo.monthly {
                        addInfo = NSLocalizedString(" [ each", comment: "")
//                        addInfo = " [ каждое"
                        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DayOfMonth")
                        let sortDescription = NSSortDescriptor(key: "date", ascending: true)
                        request.sortDescriptors = [sortDescription]
                        let predicate = NSPredicate(format: "%K == %@", "thingToDo", thingToDo)
                        request.predicate = predicate
                        do {
                            let dayOfMonth = try CoreDataManager.instance.persistentContainer.viewContext.fetch(request)
                            if let dayOfMonth = dayOfMonth as? [DayOfMonth] {
                                for item in dayOfMonth {
                                    addInfo = addInfo + " \(String(describing: item.date!))"
                                }
                            }
                        } catch {
                            print(error)
                        }
                        addInfo = addInfo + " ]"
                        if addInfo == NSLocalizedString(" [ each ]", comment: "") { addInfo = ""}
//                        if addInfo == " [ каждое ]" { addInfo = ""}
                    }
                }
            } else {
                // задано количество дней, в которые нужно выполнять задание
                
                if let finishDate = thingToDo.time {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd.MM.YY"
                    let correctedDate = dateFormatter.string(from: finishDate as Date)
                    addInfo = NSLocalizedString(" (to ", comment: "") + "\(correctedDate))"
//                       addInfo = " (до " + "\(correctedDate))"
                    
//                    addInfo = "\(finishDate)"
                }
            }
            if let note = thingToDo.note {
                cell.detailTextLabel?.text = note + addInfo
            } else {
               cell.detailTextLabel?.text = addInfo
            }
//            if thingToDo.note != nil {
//                cell.detailTextLabel?.text = thingToDo.note! + addInfo
//            } else {
//                cell.detailTextLabel?.text = addInfo
//            }
          //  cell.detailTextLabel?.text = thingToDo.note! + addInfo
            
        }
        
        return cell
    }
    //MARK: Move to other page
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print(indexPath)
        if let thing = fetchRequest.object(at: indexPath) as? ThingToDo {
            performSegue(withIdentifier: identifierSegue, sender: thing)
        }
    }
    
    @IBAction func addNewThingToDoButton(_ sender: UIButton) {
        performSegue(withIdentifier: identifierSegue, sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifierSegue {
            let controller = segue.destination as! SecondDetailViewController
            let thingToDoActualArray = fetchRequest.fetchedObjects?.count
            controller.count = thingToDoActualArray //?
            controller.thingToDo = sender as? ThingToDo
        }
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
                let thingToDo = fetchRequest.object(at: indexPath) as! ThingToDo
                let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath)
                cell.textLabel?.text = thingToDo.name! + " \(String(describing: thingToDo.priority))"
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

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if let temp = fetchRequest.fetchedObjects as? [ThingToDo] {
            setOrder()
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
            tableView.reloadData()
        }
    }
    func setOrder() {

        if let temp = fetchRequest.fetchedObjects as? [ThingToDo] {
            if temp.count < 2 {
//                if temp.count == 1 {
//                    array[0].priority = 0
//                }
            } else {
                array = temp
                array[0].priority = 0
                if array.count > 0 {
                    for i in 1...array.count-1 {
                        array[i].priority = NSDecimalNumber(value: Int(truncating: array[i-1].priority!) + 1)
                    }
                }
                CoreDataManager.instance.saveContext()
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            print("DELETE___________________++++++++++++++++++__________________")
            // lifehack
            let reserve = ThingToDo()
            reserve.name = "TEst Delete"
            reserve.priority = 999
            CoreDataManager.instance.saveContext()
            if let thing = fetchRequest.object(at: indexPath) as? ThingToDo {
                thing.isActual = false
                let historyFindThisThingToDo = ThingToDo.fetchedResultsHistoryToday(forThingToDo: thing)
                do {
                    try historyFindThisThingToDo.performFetch()
                    historyFindThisThingToDo.delegate = self
                } catch {
                    print(error)
                }
                if let historyToDelete = historyFindThisThingToDo.fetchedObjects?.first as? NSManagedObject {
                    CoreDataManager.instance.persistentContainer.viewContext.delete(historyToDelete)
//                    print("delete HIstory- finished")
                }
             }
            let managedObject = fetchRequest.fetchedObjects?.last as! NSManagedObject
            CoreDataManager.instance.persistentContainer.viewContext.delete(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }
    
    //MARK: Help View
    func createLabelForHelpView(typeInfo: typeInfoForHelp, text: String) -> UILabel {
        // create example
        
        let label = UILabel()
        var width = CGFloat()
        
        switch typeInfo {
        case .exit: width = helpView.frame.width*3/4
        default: width = helpView.frame.width/3
        }
        
        label.frame = CGRect(x: 0, y: 0, width: width, height: helpView.frame.height)
        if helpView.frame.width > 400 {
            label.font = UIFont(name: "Marker Felt", size: UIFont.labelFontSize+5)
        }
        else {
            label.font = UIFont(name: "Marker Felt", size: UIFont.labelFontSize)
        }
        label.text = text
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.2
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.textAlignment  = .center
        label.sizeToFit()
        
        var delta = CGFloat(0)
        switch helpView.frame.height {
        case 0...569: delta = helpView.frame.height*2/37
        case 0...668: delta = helpView.frame.height/37
        default: delta = 0
        }
        // change position
        switch typeInfo {
        case .main:
            label.frame = CGRect(x: helpView.frame.width/4,
                                 y: helpView.frame.height/3,
                                 width: helpView.frame.width/2,
                                 height: label.frame.height)
        case .leftTop:
            label.frame = CGRect(x: helpView.frame.width/20,
                                 y: helpView.frame.height/8,
                                 width: helpView.frame.width/3,
                                 height: label.frame.height)
            let image = UIImageView(image: UIImage(named: "arrow left"))
            image.frame = CGRect(x: helpView.frame.width/9, y: helpView.frame.height/40, width: helpView.frame.width/10, height: helpView.frame.height/12)
            helpView.addSubview(image)
        case .detailData:
            label.frame = CGRect(x: helpView.frame.width*33/60,
                                 y: helpView.frame.height*4/22 + delta,
                                 width: helpView.frame.width/3,
                                 height: label.frame.height)
            let image = UIImageView(image: UIImage(named: "arrow right"))
            image.frame = CGRect(x: helpView.frame.width*43/60, y: helpView.frame.height*3/37 + delta, width: helpView.frame.width/10, height: helpView.frame.height/12)
            helpView.addSubview(image)
        case .exit:
            label.frame = CGRect(x: helpView.frame.width/8,
                                 y: helpView.frame.height*3/4,
                                 width: helpView.frame.width*3/4,
                                 height: label.frame.height)
        default:
            label.frame = CGRect(x: helpView.frame.width/3,
                                 y: helpView.frame.height/8,
                                 width: helpView.frame.width/3,
                                 height: label.frame.height)
        }
        
        label.textColor = .white
        //        label.backgroundColor = .blue
        return label
    }
    
    func showHelpFisrtTime(){
        helpView.addSubview(createLabelForHelpView(typeInfo: .main,
                                                   text: NSLocalizedString("Tasks to be performed regularly", comment: "")))
//        text: "Список задач, которые нужно регулярно выполнять"))
        helpView.addSubview(createLabelForHelpView(typeInfo: .leftTop,
                                                   text: NSLocalizedString("Tap to 'Today's tasks'", comment: "")))
//        text: "Перейти к списку 'Дела на сегодня'"))
        helpView.addSubview(createLabelForHelpView(typeInfo: .detailData,
                                                   text: NSLocalizedString("Tap to show / edit task", comment: "")))
//        text: "Посмотреть/изменить задание"))
        helpView.addSubview(createLabelForHelpView(typeInfo: .exit,
                                                   text: NSLocalizedString("Double-tap to continue", comment: "")))
//        text: "Дважды нажмите на экран, чтобы продолжить" ))
        view.addSubview(helpView)
    }
    
    func checkShowHelp() {
        var times = 0
        // add check
        if UserDefaults.standard.value(forKey: "pageAllDay") != nil {
            times = UserDefaults.standard.value(forKey: "pageAllDay") as! Int
//            UserDefaults.standard.set(0, forKey: "pageAllDay")
        } else {
            UserDefaults.standard.set(times, forKey: "pageAllDay")
        }
        guard times < 5 else { return }
        
//        times = 1 // for test
        // 0 - never meeting (1 - showed)
        // 5 - teaching mode is finish
        if times == 1 {
            //        helpView = UIView()
            // !isHide helpView and changeFrame
            helpView.frame = CGRect(x: view.frame.minX,
                                    y: view.frame.minY,
                                    width: view.frame.maxX,
                                    height: view.frame.maxY)
            
            helpView.backgroundColor = .darkGray
            helpView.alpha = 0.8
            showHelpFisrtTime()
            UserDefaults.standard.set(5, forKey: "pageAllDay")
        }
    }

}
