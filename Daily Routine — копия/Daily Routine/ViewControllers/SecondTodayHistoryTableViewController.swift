//
//  SecondTodayHistoryTableViewController.swift
//  Daily Routine
//
//  Created by Anton Rubenchik on 21.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData
enum typeInfoForHelp {
    case main
    case rightTop
    case leftTop
    case deleteData
    case editData
    case detailData
    case exit
}

class SecondTodayHistoryTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, SecondMainTableViewCellDelegate {

    
  
    let identifierCell = "SecondMainCell"
    let identifierSegue = "todayToDaily"
    
    var fetchRequest = History.fetchedResultsToday()
    var array : [ThingToDo] = []
    var helpView = UIView()
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkDateInToday()
//        setOrder() // need for record same priority because they don't everyday show
        fetchRequest.delegate = self
        // History
        do {
            try fetchRequest.performFetch()
        } catch {
            print(error)
        }
        tableView.reloadData()
//        UIApplication.shared.statusBarStyle = .lightContent
        UIApplication.shared.statusBarView?.backgroundColor = .black
        checkShowHelp()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setOrder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
    }
    
    @objc func doubleTapped() {
        if !helpView.isHidden {
            helpView.isHidden = true
        } else {
            tableView.isEditing = !tableView.isEditing
            tableView.reloadData()
            if UserDefaults.standard.value(forKey: "pageToday") != nil {
                if UserDefaults.standard.value(forKey: "pageToday") as! Int == 3 {
                    UserDefaults.standard.set(4, forKey: "pageToday")
                    checkShowHelp()
                }
            }
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
        if let count = fetchRequest.fetchedObjects?.count {
            return count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath) as? SecondTodayHistoryTableViewCell {
            let todayThing = fetchRequest.object(at: indexPath) as! History
            let formatter = DateFormatter()
            formatter.timeStyle = .none
            formatter.dateStyle = .short
            let newData = Thing(name: (todayThing.thingToDo?.name)!, note: (todayThing.thingToDo?.note)!, isActual: todayThing.isDone)
            cell.getData(item: newData)
            if todayThing.thingToDo?.note == "" {
                cell.nameLabel.frame = CGRect(x: Int(cell.nameLabel.frame.minX), y: 15, width: Int(cell.nameLabel.frame.width), height: Int(cell.nameLabel.frame.height))
            }

            // Hidden Switch, if edit styli is ON
            if tableView.isEditing {
                cell.isActualSwitch.isHidden = true
                
            } else {
                cell.isActualSwitch.isHidden = false
            }
            cell.delegate = self
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //MARK: Delegate for editing Table
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
//            print("INSERT Today___________________++++++++++++++++++__________________")
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
//            print("Update TODAY___________________++++++++++++++++++__________________")
            if let indexPath = indexPath {
                let todayThing = fetchRequest.object(at: indexPath) as! History
                
                let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath) as? SecondTodayHistoryTableViewCell
                let formatter = DateFormatter()
                formatter.timeStyle = .none
                formatter.dateStyle = .short
                let newData = Thing(name: (todayThing.thingToDo?.name)! + " \(formatter.string(from: todayThing.date! as Date))",
                    note: (todayThing.thingToDo?.note)!, isActual: todayThing.isDone)
                cell?.getData(item: newData)
            }
        case .move:
//            print("MOVE Today___________________++++++++++++++++++__________________")
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
//            print("DELETE Today___________________++++++++++++++++++__________________")
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        var isFromMove = false
        var isToMove = false
        var sourceIndexPathThing = 0
        var destinationIndexPathThing = 0
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ThingToDo")
        let sortDescription = NSSortDescriptor(key: "priority", ascending: true)
        request.sortDescriptors = [sortDescription]
        let predicate = NSPredicate(format: "%K == %@", "isActual", NSNumber(value: true))
        request.predicate = predicate
        do {
            let thingToDo = try CoreDataManager.instance.persistentContainer.viewContext.fetch(request)
            if let thingToDo = thingToDo as? [ThingToDo] {
                if let sourceHistory = fetchRequest.object(at: sourceIndexPath) as? History {
                    if let destinationHistory = fetchRequest.object(at: destinationIndexPath) as? History {
                        for (i,thingToDoItem) in zip(thingToDo.indices,thingToDo) {
                            if sourceHistory.thingToDo == thingToDoItem {
                                sourceIndexPathThing = i
                                isFromMove = true
                            }
                            if destinationHistory.thingToDo == thingToDoItem {
                                destinationIndexPathThing = i
                                isToMove = true
                            }
                        }
                        if isFromMove && isToMove {
//                            print("From - \(sourceIndexPathThing) To - \(destinationIndexPathThing)")
                            
                            setOrder()
                            array = thingToDo
                            array[sourceIndexPathThing].priority = NSDecimalNumber(value: destinationIndexPathThing)
                            
                            if sourceIndexPathThing < destinationIndexPathThing {
                                for i in sourceIndexPathThing+1...destinationIndexPathThing {
                                    array[i].priority = NSDecimalNumber(value: i - 1)
                                }
                            } else {
                                for i in (destinationIndexPathThing...sourceIndexPathThing-1).reversed() {
                                    array[i].priority = NSDecimalNumber(value: i + 1)
                                }
                            }
                            CoreDataManager.instance.saveContext()
                            do {
                                try fetchRequest.performFetch()
                            } catch {
                                print(error)
                            }
//                            tableView.reloadData()
                        }
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
    func setOrder() {
        // Put if need. Need for right order !!!!!!!
        
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ThingToDo")
//        let sortDescription = NSSortDescriptor(key: "priority", ascending: true)
//        request.sortDescriptors = [sortDescription]
//        let predicate = NSPredicate(format: "%K == %@", "isActual", NSNumber(value: true))
//        request.predicate = predicate
//        do {
//            let thingToDo = try CoreDataManager.instance.persistentContainer.viewContext.fetch(request)
//            if let temp = thingToDo as? [ThingToDo] {
//                if temp.count < 2 {
//                    if temp.count == 1 {
//                        array[0].priority = 0
//                    }
//                } else {
//                    array = temp
//                    array[0].priority = 0
//                    if array.count > 0 {
//                        for i in 1...array.count-1 {
//                            array[i].priority = NSDecimalNumber(value: Int(truncating: array[i-1].priority!) + 1)
//                        }
//                    }
//                    CoreDataManager.instance.saveContext()
//                    tableView.reloadData()
//                }
//            }
//        } catch {
//            print(error)
//        }
    }
    
    // Обязательно нужен данный метод, без него не будет обновление работать
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObject = fetchRequest.object(at: indexPath) as! NSManagedObject
            CoreDataManager.instance.persistentContainer.viewContext.delete(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }

    //MARK: Delegate for change data
    func didTappedSwitchCell(cell: SecondTodayHistoryTableViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        let history = fetchRequest.object(at: indexPath!) as! History
        history.isDone = cell.isActualSwitch.isOn
        CoreDataManager.instance.saveContext()
    }
    
    //MARK: Move to other page
//    @IBAction func addButton(_ sender: UIBarButtonItem) {
//        performSegue(withIdentifier: identifierSegue, sender: nil)
//    }
    @IBAction func addNewThingButton(_ sender: UIButton) {
         performSegue(withIdentifier: identifierSegue, sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifierSegue {
            let controller = segue.destination as! SecondDetailViewController
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ThingToDo")
            let sortDescription = NSSortDescriptor(key: "priority", ascending: true)
            request.sortDescriptors = [sortDescription]
            let predicate = NSPredicate(format: "%K == %@", "isActual", NSNumber(value: true))
            request.predicate = predicate
            do {
                let thingToDo = try CoreDataManager.instance.persistentContainer.viewContext.fetch(request)
                controller.count = thingToDo.count
            } catch {
                print(error)
            }
            controller.thingToDo = sender as? ThingToDo
        }
    }
    
    // MARK:  Add Function
    func isNeedToday(thing: ThingToDo)-> Bool {
        let today = Date()
        if thing.weekly {
            if let week = thing.week {
                if let dayOfWeek = today.dayNumberOfWeek() {
                    switch dayOfWeek {
                    case 1: if week.sunday    { return true }
                    case 2: if week.monday    { return true }
                    case 3: if week.tuesday   { return true }
                    case 4: if week.wednesday { return true }
                    case 5: if week.thursday  { return true }
                    case 6: if week.friday    { return true }
                    case 7: if week.saturday  { return true }
                    default: return false
                    }
                }
            }
            return false
        } else {
            if thing.monthly {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DayOfMonth")
                let predicate = NSPredicate(format: "%K == %@", "thingToDo", thing)
                request.predicate = predicate
                do {
                    let days = try CoreDataManager.instance.persistentContainer.viewContext.fetch(request) as! [DayOfMonth]
                    for day in days {
                        if day.date?.intValue == today.dayNumberOfMonth(){
                            return true
                        }
                    }
                    return false
                } catch {
                    print(error)
                }
            }
        }
        return true
    }
    
    func createLabelForHelpView(typeInfo: typeInfoForHelp, text: String) -> UILabel {
        // create example
        
        let label = UILabel()
        var width = CGFloat()
        
        switch typeInfo {
        case .exit: width = helpView.frame.width*3/4
        default: width = helpView.frame.width/3
        }
        
        label.frame = CGRect(x: 0, y: 0, width: width, height: helpView.frame.height)
//        print(helpView.frame.width)
//        print(helpView.frame.height)
        if helpView.frame.width > 400 {
            label.font = UIFont(name: "Marker Felt", size: UIFont.labelFontSize+5)
        }
        else {
            label.font = UIFont(name: "Marker Felt", size: UIFont.labelFontSize)
        }
//        label.font = UIFont(name: "Marker Felt", size: UIFont.labelFontSize+5)
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
        case 0...668: delta = helpView.frame.height*1/37
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
        case .rightTop:
            label.frame = CGRect(x: helpView.frame.width*37/60,
                                 y: helpView.frame.height/8,
                                 width: helpView.frame.width/3,
                                 height: label.frame.height)
            let image = UIImageView(image: UIImage(named: "arrow right"))
            image.frame = CGRect(x: helpView.frame.width*47/60, y: helpView.frame.height/40, width: helpView.frame.width/10, height: helpView.frame.height/12)
            helpView.addSubview(image)
        case .detailData:
            label.frame = CGRect(x: helpView.frame.width*33/60,
                                 y: helpView.frame.height*4/22 + delta,
                                 width: helpView.frame.width/3,
                                 height: label.frame.height)
            let image = UIImageView(image: UIImage(named: "arrow right"))
            image.frame = CGRect(x: helpView.frame.width*43/60, y: helpView.frame.height*3/37 + delta, width: helpView.frame.width/10, height: helpView.frame.height/12)
            helpView.addSubview(image)
        case .deleteData:
            label.frame = CGRect(x: helpView.frame.width/20,
                                 y: helpView.frame.height*4/22 + delta,
                                 width: helpView.frame.width/3,
                                 height: label.frame.height)
            let image = UIImageView(image: UIImage(named: "arrow left"))
            image.frame = CGRect(x: helpView.frame.width/9, y: helpView.frame.height*3/37 + delta, width: helpView.frame.width/10, height: helpView.frame.height/12)
            helpView.addSubview(image)
        case .editData:
            label.frame = CGRect(x: helpView.frame.width/4,
                                 y: helpView.frame.height*45/100,
                                 width: helpView.frame.width/2,
                                 height: label.frame.height)
            let image = UIImageView(image: UIImage(named: "double-tap"))
            image.frame = CGRect(x: helpView.frame.width/2 - helpView.frame.height/24, y: helpView.frame.height*45/100 - helpView.frame.height/12, width: helpView.frame.height/12, height: helpView.frame.height/12)
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
        return label
    }
    
    func showHelpFisrtTime(){
        helpView.addSubview(createLabelForHelpView(typeInfo: .main,
                                                   text: NSLocalizedString("Today's to do list", comment: "")))
//                                                   text: "Список дел, которые нужно выполнить сегодня"))
        helpView.addSubview(createLabelForHelpView(typeInfo: .leftTop,
                                                   text: NSLocalizedString("Tap to 'All tasks'", comment: "")))
//                                                   text: "Перейти к 'Список всех дел'"))
        helpView.addSubview(createLabelForHelpView(typeInfo: .rightTop,
                                                   text: NSLocalizedString("Add a new task", comment: "")))
//                                                    text: "Добавить новое дело"))
        helpView.addSubview(createLabelForHelpView(typeInfo: .exit,
                                                   text: NSLocalizedString("Double-tap to continue", comment: "")))
//        text: "Дважды нажмите на экран, чтобы продолжить"))
        view.addSubview(helpView)
    }
    
    func showHelpAddFisrtTask(){
        helpView.addSubview(createLabelForHelpView(typeInfo: .editData,
                                                   text: NSLocalizedString("Tap twice to delete or change a task sequence", comment: "")))
//        text: "Для удаления или изменения последовательности заданий, коснитесь два раза"))
        helpView.addSubview(createLabelForHelpView(typeInfo: .leftTop,
                                                   text: NSLocalizedString("Tap to 'All tasks'", comment: "")))
//        text: "Перейти к 'Список всех дел'"))
        helpView.addSubview(createLabelForHelpView(typeInfo: .detailData,
                                                   text: NSLocalizedString("Mark the completed task", comment: "")))
//        text: "Отмечаем выполненное задание"))
        helpView.addSubview(createLabelForHelpView(typeInfo: .exit,
                                                   text: NSLocalizedString("Double-tap to continue", comment: "")))
//        text: "Дважды нажмите на экран, чтобы продолжить"))
        view.addSubview(helpView)
    }
    func showHelpDeleteTask(){
        helpView.addSubview(createLabelForHelpView(typeInfo: .editData,
                                                   text: NSLocalizedString("Double-tap to exit edit mode", comment: "")))
//        text: "Для выхода из режима редактирования, коснитесь два раза"))
        helpView.addSubview(createLabelForHelpView(typeInfo: .deleteData,
                                                   text: NSLocalizedString("Tap to delete the task ˚", comment: "")))
//        text: "Нажмите, для удаления задания ˚" ))
        helpView.addSubview(createLabelForHelpView(typeInfo: .detailData,
                                                   text: NSLocalizedString("Tap to change order", comment: "")))
//        text: "Потяните, чтобы изменить порядок"))
        helpView.addSubview(createLabelForHelpView(typeInfo: .exit,
                                                   text: NSLocalizedString("˚ - The task will only be removed from the list 'Tasks for today'. For complete removal, go to the 'All tasks' page.", comment: "")))
//        text: "˚ - Задача удалится только из списке 'Дела на сегодня'. Для полного удаления, пререйдите на страницу 'Список всех дел'" ))
        view.addSubview(helpView)
    }
    
    func checkShowHelp() {
        var times = 0
        // add check
        if UserDefaults.standard.value(forKey: "pageToday") != nil {
            times = UserDefaults.standard.value(forKey: "pageToday") as! Int
//            UserDefaults.standard.set(3, forKey: "pageToday") for test
        } else {
            UserDefaults.standard.set(times, forKey: "pageToday")
        }
//        print("Times -",times)
        guard times < 5 else { return }
        helpView = UIView()
        // !isHide helpView and changeFrame
        helpView.frame = CGRect(x: view.frame.minX,
                                y: view.frame.minY,
                                width: view.frame.maxX,
                                height: view.frame.maxY)
        
        helpView.backgroundColor = .darkGray
        helpView.alpha = 0.8
        
//         times = 4 // for test
        // 0 - never meeting (1 - showed)
        // 2 - add first task and never show nelp (3 - showed)
        // 4 - first time double click and never show nelp
        // 5 - teaching mode is finish
        switch times {
        case 0:
            showHelpFisrtTime()
            UserDefaults.standard.set(1, forKey: "pageToday")
        case 2:
            helpView.isHidden = false
            showHelpAddFisrtTask()
            UserDefaults.standard.set(3, forKey: "pageToday")
        case 4:
            helpView.isHidden = false
            showHelpDeleteTask()
            UserDefaults.standard.set(5, forKey: "pageToday") 
        default: return
        }
    }
    
    func checkDateInToday() {
        //#needAdd
        // Доработать дата должна быть согласно локации
        //        var calendar = Calendar.current
        //        calendar.timeZone = NSTimeZone.local
        //        let dayToday = calendar.startOfDay(for: Date())
        
        // Don't DELETE!!!
        //        // add yesterday day for testing
//                let dayToday = Date()
//                let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: dayToday)
//                UserDefaults.standard.set(yesterday, forKey: "dateToday")
//                UserDefaults.standard.synchronize()
//                print(yesterday)
        
        // take date from UserDefaults
        var savedDate = Date()
        if UserDefaults.standard.value(forKey: "dateToday") != nil {
            savedDate = UserDefaults.standard.value(forKey: "dateToday") as! Date
        } else {
           UserDefaults.standard.set(savedDate, forKey: "dateToday")
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
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ThingToDo")
            let sortDescription = NSSortDescriptor(key: "priority", ascending: true)
            request.sortDescriptors = [sortDescription]
            // Difficilt predicate daily, weekly, monthly
            let predicateIsActual = NSPredicate(format: "%K == %@", "isActual", NSNumber(value: true))
            request.predicate = predicateIsActual
            do {
                let thingToDo = try CoreDataManager.instance.persistentContainer.viewContext.fetch(request)
                if let thingToDo = thingToDo as? [ThingToDo] {
                    var calendar = Calendar.current
                    calendar.timeZone = NSTimeZone.local
                    let dateFrom = calendar.startOfDay(for: Date()) // eg. 2016-10-10 00:00:00
                    for thing in thingToDo {
                        if let finishedTime = thing.time as Date? {
                            if finishedTime < dateFrom {
                                thing.isActual = false
                                CoreDataManager.instance.saveContext()
                            } else {
                                if isNeedToday(thing: thing) {
                                    let history = History()
                                    history.date = dateToday as NSDate
                                    history.thingToDo = thing
                                    history.isDone = false
                                }
                            }
                        } else {
                            if isNeedToday(thing: thing) {
                                let history = History()
                                history.date = dateToday as NSDate
                                history.thingToDo = thing
                                history.isDone = false
                            }
                        }
                    }
                }
            } catch {
                print(error)
            }
            CoreDataManager.instance.saveContext()
            // save today in UserDefaults
            UserDefaults.standard.set(dateToday, forKey: "dateToday")
            UserDefaults.standard.synchronize()
//            print("!= old date is \(formatter.string(from: savedDate))")
        }
    }

}

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    func dayNumberOfMonth() -> Int? {
        return Calendar.current.dateComponents([.day], from: self).day
    }
    func monthOfYear() -> Int? {
        return Calendar.current.dateComponents([.month], from: self).month
    }
    func year() -> Int? {
        return Calendar.current.dateComponents([.year], from: self).year
    }
}
