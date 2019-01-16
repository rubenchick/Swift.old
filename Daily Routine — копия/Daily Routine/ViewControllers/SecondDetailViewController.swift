//
//  SecondDetailViewController.swift
//  Daily Routine
//
//  Created by Anton Rubenchik on 21.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.

// Закончил полностью функционал Weekly для нового Thing.
// + 1. Нужно грузить weekly для уже существующих thing
// + 2. Сделать monthly.
// + 3. Отображать в списке Today согласно weekly и monthly
// + 3.5 Не создавать в History новую записть, при создании новой Thing если этого не нужно делать Weekly and Monthly
// + 3.6 If times>1 need check algoritm (Do you need new record in History)
// 4. Проверить, где еще иcпользуется Today. Может быть moved???
// 5. После добавления 3-х записей, указать, как можно менять порядок/удалить
// 6. При удалении thing in Today сообщить, что он удалится только сегодня, и нужно удалить в списке, если на всегда
// 7. При первом открытии, указать что это за страница, и где посмотреть список всех дел
// + 8. Добавить срок выполнения. % 5 дней
// 8.5 Убрать желтые предупреждения
// AppStore
// 9. Сделать обучающие слайды???
// 10. Английская версия
// 11. Почистить ViewDidLoad
// 12. Почистить код.
// 13.
// 14. Поддержка IPad



import UIKit
import CoreData

class SecondDetailViewController: UIViewController {
    // MARK: Var
    var thingToDo: ThingToDo?
    var count: Int? //????
    // MARK: @IBOutlet
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var noteTExtField: UITextField!
    @IBOutlet weak var addInfoToNoteLabel: UILabel!
    @IBOutlet weak var countTimesTextField: UITextField!
    @IBOutlet weak var duringTextField: UITextField!
    @IBOutlet weak var infoToNoteSegmentControl: UISegmentedControl!
    @IBOutlet weak var countTimesStepperOutlet: UIStepper!
    @IBOutlet weak var duringStepperOutlet: UIStepper!
    @IBOutlet weak var weeklyView: UIView!
    @IBOutlet weak var monthlyView: UIView!
    @IBOutlet weak var weeklyLabel: UILabel!
    @IBOutlet weak var monthlyLabel: UILabel!
    @IBOutlet weak var weeklySwitch: UISwitch!
    @IBOutlet weak var monthlySwitch: UISwitch!
    @IBOutlet weak var dailySwitch: UISwitch!
    @IBOutlet weak var pressSaveButton: UIBarButtonItem!
    @IBOutlet weak var pressCancelButton: UIBarButtonItem!
    @IBOutlet weak var readyWeeklyViewOutlet: UIButton!
    @IBOutlet weak var titleOnMonthlyView: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var titelLabel: UILabel!
    
    // MARK: own function
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        UIApplication.shared.statusBarView?.backgroundColor = .black
//        print(navigationBar.frame.minY)
//        print(navigationBar.frame.maxY)
//        print(navigationBar.bounds.minY)
//        print(navigationBar.bounds.maxY)
//        titelLabel.frame = CGRect(x: titelLabel.frame.minX,
//                                  y: navigationBar.frame.midY - titelLabel.frame.height/2 ,
//                                  width: titelLabel.frame.width,
//                                  height: titelLabel.frame.height)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let thingToDo = thingToDo {
            nameTextField.text = thingToDo.name
            noteTExtField.text = thingToDo.note
//            createElementsBeforeStart()
            
            if thingToDo.daily {
                if thingToDo.time != nil {
                    let finishDay = thingToDo.time as? Date
                    if finishDay != nil {
                        if let diffInDays = Calendar.current.dateComponents([.day], from: Date(), to: finishDay!).day {
                            duringTextField.text = "\(Int(diffInDays)+1)"
                            duringStepperOutlet.value = Double(diffInDays+1)
                        }
                    }
                }
            } else {
                if thingToDo.weekly {
                    installSwitchForDaily(howOften: 2)
                    if let weekly = thingToDo.week {
                        createElementForWeeklyView()
                        //                    bad idea, I known
                        for i in 1...7 {
                            if let item = self.view.viewWithTag(i) as? UIButton {
                                if (weekly.monday) && (i == 1) { item.isSelected = true }
                                if (weekly.tuesday) && (i == 2) { item.isSelected = true }
                                if (weekly.wednesday) && (i == 3) { item.isSelected = true }
                                if (weekly.thursday) && (i == 4) { item.isSelected = true }
                                if (weekly.friday) && (i == 5) { item.isSelected = true }
                                if (weekly.saturday) && (i == 6) { item.isSelected = true }
                                if (weekly.sunday) && (i == 7) { item.isSelected = true }
                            }
                        }
                    }
                } else {
                    if thingToDo.monthly {
                        installSwitchForDaily(howOften: 3)
                        createElementForMonthlyView()
                        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DayOfMonth")
                        let predicate = NSPredicate(format: "%K == %@", "thingToDo", thingToDo)
                        request.predicate = predicate
                        do {
                            let dayOfMonth = try CoreDataManager.instance.persistentContainer.viewContext.fetch(request)
                            if let days = dayOfMonth as? [DayOfMonth] {
                                for day in days {
                                    if let i = day.date?.intValue {
                                        if let item = self.view.viewWithTag(100 + i) as? UIButton {
                                            print(i)
                                            item.isSelected = true
                                        }
                                    }
                                }
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
        
//        weeklyView.frame.size.height = weeklyView.frame.size.width / 2
        // tap for WeeklyLabel
        let tapGestureForWeeklyLabel = UITapGestureRecognizer(target: self, action: #selector(tapForWeeklyLabel))
        weeklyLabel.isUserInteractionEnabled = true
        weeklyLabel.addGestureRecognizer(tapGestureForWeeklyLabel)
        
        let tapGestureForMonthlyLabel = UITapGestureRecognizer(target: self, action: #selector(tapForMonthlyLabel))
        monthlyLabel.isUserInteractionEnabled = true
        monthlyLabel.addGestureRecognizer(tapGestureForMonthlyLabel)
    }
    // MARK: Button on Navigation
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if saveThingToDo() {
            dismiss(animated: true, completion: nil)
            if UserDefaults.standard.value(forKey: "pageToday") != nil {
                if UserDefaults.standard.value(forKey: "pageToday") as! Int == 1 {
                    UserDefaults.standard.set(2, forKey: "pageToday")
                 }
            }
            if UserDefaults.standard.value(forKey: "pageAllDay") != nil {
                if UserDefaults.standard.value(forKey: "pageAllDay") as! Int == 0 {
                    UserDefaults.standard.set(1, forKey: "pageAllDay")
                }
            }
        } else {
            let alert = UIAlertController(title: NSLocalizedString("Attention", comment: ""),
                                          message: NSLocalizedString("No title entered", comment: ""), preferredStyle: .alert)
            let okButton = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil)
//            let alert = UIAlertController(title: "Внимание", message: "Не введено название ", preferredStyle: .alert)
//            let okButton = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    func addInfoToNote(atIndex index: Int) -> String{
//        let timeForDayDictionary = [2: ["утром","вечером"],
//                                    3: ["утром","днем","вечером"],
//                                    4: ["утром","до обеда","после обеда","вечером"],
//                                    5: ["утром","до обеда","после обеда","вечером","ночью"]]
//        let endOfNumbersArray = ["-ой","-ый","-ой","-ий","-ый","-ый","-ой","-ой","-ой","-ый","-ый"]
        let timeForDayDictionary = [2: [NSLocalizedString("in the morning", comment: ""),
                                        NSLocalizedString("in the evening", comment: "")],
                                    3: [NSLocalizedString("in the morning", comment: ""),
                                        NSLocalizedString("in the midday", comment: ""),
                                        NSLocalizedString("in the evening", comment: "")],
                                    4: [NSLocalizedString("in the morning", comment: ""),
                                        NSLocalizedString("before lunch", comment: ""),
                                        NSLocalizedString("after lunch", comment: ""),
                                        NSLocalizedString("in the evening", comment: "")],
                                    5: [NSLocalizedString("in the morning", comment: ""),
                                        NSLocalizedString("before lunch", comment: ""),
                                        NSLocalizedString("after lunch", comment: ""),
                                        NSLocalizedString("in the evening", comment: ""),
                                        NSLocalizedString("at night", comment: "")]]
        let endOfNumbersArray = ["",
                                 NSLocalizedString("st", comment: ""),
                                 NSLocalizedString("nd", comment: ""),
                                 NSLocalizedString("rd", comment: ""),
                                 NSLocalizedString("th", comment: ""),
                                 NSLocalizedString("th", comment: ""),
                                 NSLocalizedString("th1", comment: ""),
                                 NSLocalizedString("th1", comment: ""),
                                 NSLocalizedString("th1", comment: ""),
                                 NSLocalizedString("th", comment: ""),
                                 NSLocalizedString("th", comment: "")]
        var addInfo = ""
        if let times = Int(countTimesTextField.text!) {
            if times > 1 {
                if infoToNoteSegmentControl.selectedSegmentIndex != 0 {
                    if infoToNoteSegmentControl.selectedSegmentIndex == 1 {
                        addInfo = "(\(index)\(endOfNumbersArray[index])" + NSLocalizedString(" times) ", comment: "")
//                        addInfo = "(\(index)\(endOfNumbersArray[index])" + " раз) "
                    } else {
                        let timeForDayArray = timeForDayDictionary[times]
                        addInfo = "( " + timeForDayArray![index-1] + " ) "
                    }
                }
            }
        }
        return addInfo
    }
    // MARK: For Save Record
    // record from WeekView To ThingToDo.Week entity Week
    func record(week: Week){
        for i in 1...7 {
            if let newButton = self.view.viewWithTag(i) as? UIButton {
                if newButton.isSelected {
                    switch i {
                    case 1: week.monday = true
                    case 2: week.tuesday = true
                    case 3: week.wednesday = true
                    case 4: week.thursday = true
                    case 5: week.friday = true
                    case 6: week.saturday = true
                    case 7: week.sunday = true
                    default: break
                    }
                } else {
                    switch i {
                    case 1: week.monday = false
                    case 2: week.tuesday = false
                    case 3: week.wednesday = false
                    case 4: week.thursday = false
                    case 5: week.friday = false
                    case 6: week.saturday = false
                    case 7: week.sunday = false
                    default: break
                    }
                }
            }
        }
    }
    
    // MARK:  Add Function
    
    func createElementsBeforeStart() {
        let widthView = view.frame.size.width
//        monthlyView.frame.size.height = widthView * 0.95
        let widthOneButton = Double(monthlyView.frame.size.width / 11)
        let monthlyViewMixY = nameTextField.frame.maxY + (nameTextField.frame.maxY - nameTextField.frame.minY ) / 2
        let monthlyViewWidth = Int(widthView) - Int(widthOneButton * 1.6)
        let titleMaxY = titleOnMonthlyView.frame.maxY //MaxY for title in this View


        monthlyView.frame = CGRect(x: Int(widthOneButton * 0.8),
                                       y: Int(monthlyViewMixY),
                                       width: Int(monthlyViewWidth),
                                       height: Int(Int(titleMaxY) + Int(Double(widthOneButton) * (2.2  + 1.4 * 5)))
                )
    }
    
    // check property this thingToDo, and desicion need do this Thing today or not
    func isNeedToday()-> Bool {
        let today = Date()
        if dailySwitch.isOn {
             return true
        }
        else {
            if weeklySwitch.isOn {
                let dayNumberOfWeek = (today.dayNumberOfWeek() != 1) ? (today.dayNumberOfWeek()! - 1) : 7
                if let newButton = self.view.viewWithTag(dayNumberOfWeek) as? UIButton {
                    if newButton.isSelected {
                        return true
                    } else {
                        return false
                    }
                }
            } else {
                if monthlySwitch.isOn {
                    if let newButton = self.view.viewWithTag(100 + today.dayNumberOfMonth()!) as? UIButton {
                        if newButton.isSelected {
                            return true
                        }
                        else {
                            return false
                        }
                    }
                }
            }
        }
        return false
    }
    // check entity History. Is record present or not?
    func isRecordInHistoryForToday(thingToDo: ThingToDo) -> Bool {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        let dateFrom = calendar.startOfDay(for: Date()) // eg. 2016-10-10 00:00:00
        let predicateDate = NSPredicate(format: "%K >= %@", "date", dateFrom as NSDate)
        let predicateThingToDo = NSPredicate(format: "%K == %@", "thingToDo",thingToDo)
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateDate,predicateThingToDo])
        request.predicate = compound
        do {
            let things = try CoreDataManager.instance.persistentContainer.viewContext.fetch(request) as! [NSManagedObject]
            if things.count > 0 {
                return true
            } else {
                return false
            }
        } catch {
            print(error)
        }
        return true
    }
    
    func deleteOldRecordInDayOfMonthFrom(thingToDo: ThingToDo){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DayOfMonth")
        let predicate = NSPredicate(format: "%K == %@", "thingToDo", thingToDo)
        request.predicate = predicate
        do {
            let dayOfMonth = try CoreDataManager.instance.persistentContainer.viewContext.fetch(request) as! [NSManagedObject]
            for day in dayOfMonth {
                CoreDataManager.instance.persistentContainer.viewContext.delete(day)
            }
//            CoreDataManager.instance.saveContext()
        } catch {
            print(error)
        }
    }
    
    func deleteFromHistoryToday(thingToDo: ThingToDo) {
        // делаем список всех history за сегодняшний день от этого thingToDo и удаляем их
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        let dateFrom = calendar.startOfDay(for: Date()) // eg. 2016-10-10 00:00:00
        let predicateDate = NSPredicate(format: "%K >= %@", "date", dateFrom as NSDate)
        let predicateThingToDo = NSPredicate(format: "%K == %@", "thingToDo",thingToDo)
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateDate,predicateThingToDo])
        request.predicate = compound
        do {
            let things = try CoreDataManager.instance.persistentContainer.viewContext.fetch(request) as! [NSManagedObject]
            if things.count > 0 {
                for thing in things {
                    CoreDataManager.instance.persistentContainer.viewContext.delete(thing)
                }
                CoreDataManager.instance.saveContext()
            }
        } catch {
            print(error)
        }
    }
    
    // this is bad code. ;-(
    func saveThingToDo() -> Bool {
        if nameTextField.text != "" {
            // newRecord
            if thingToDo == nil {
                thingToDo = ThingToDo()
                if dailySwitch.isOn {
                    let history = History()
                    history.date = Date() as NSDate
                    history.isDone = false
                    history.thingToDo = thingToDo
                }
                if let count = count {
                    thingToDo?.priority = NSDecimalNumber(value: count)
                } else {
                    thingToDo?.priority = NSDecimalNumber(value: 100)
                }
                thingToDo?.isActual = true
            }
            // проверка указано ли количество дней, в которые нужно выполнять задание
            if duringStepperOutlet.value > 0 {
                let dayToday = Date()
                thingToDo?.time = Calendar.current.date(byAdding: .day, value: Int(duringStepperOutlet.value), to: dayToday)! as NSDate
            } else {
                thingToDo?.time = nil
            }
            
            // oldRecord or continue newRecord
            if dailySwitch.isOn {
                thingToDo?.daily = true
                thingToDo?.weekly = false
                thingToDo?.monthly = false
                // если нет созданного history Today, нужно создать
                if !isRecordInHistoryForToday(thingToDo: thingToDo!) {
                    let history = History()
                    history.date = Date() as NSDate
                    history.isDone = false
                    history.thingToDo = thingToDo
                }
                
            } else {
                if weeklySwitch.isOn {
                    thingToDo?.daily = false
                    thingToDo?.weekly = true
                    thingToDo?.monthly = false
                    // check and create new record in History
                    if isNeedToday() {
                        if !isRecordInHistoryForToday(thingToDo: thingToDo!) {
                            let history = History()
                            history.date = Date() as NSDate
                            history.isDone = false
                            history.thingToDo = thingToDo
                        }
                    } else {
//                        проверка есть ли уже запись в History и удалить ее
                        deleteFromHistoryToday(thingToDo: thingToDo!)
                    }
                    
                    if thingToDo?.week == nil {
                        let week = Week()
                        thingToDo?.week = week
                    }
                    
                    record(week: (thingToDo?.week)!)
                } else {
                    if monthlySwitch.isOn {
                        thingToDo?.daily = false
                        thingToDo?.weekly = false
                        thingToDo?.monthly = true
                        
                        // delete old record in DayOfMonth
                        deleteOldRecordInDayOfMonthFrom(thingToDo: thingToDo!)
                        
                        // check and create new record in History
                        if isNeedToday() {
                            if !isRecordInHistoryForToday(thingToDo: thingToDo!) {
                                let history = History()
                                history.date = Date() as NSDate
                                history.isDone = false
                                history.thingToDo = thingToDo
                            }
                        } else {
                            //  проверка есть ли уже запись в History и удалить ее
                            deleteFromHistoryToday(thingToDo: thingToDo!)
                        }
                        // create new record in Entity DayOfMonth
                        for i in 1...31 {
                            if let newButton = self.view.viewWithTag(100 + i) as? UIButton {
                                if newButton.isSelected {
                                    let dayOfMonth = DayOfMonth()
                                    dayOfMonth.date = NSDecimalNumber(decimal: Decimal(i))
                                    dayOfMonth.thingToDo = thingToDo
                                }
                            }
                        }
                    }
                }
                
            }
            thingToDo?.name = nameTextField.text
            thingToDo?.note = addInfoToNote(atIndex: 1) + noteTExtField.text!
            CoreDataManager.instance.saveContext()
            
            if let times = Int(countTimesTextField.text!) {
                if times > 1 {
                    for i in 2...times {
                        let newThingToDo = ThingToDo()
                        
                        // нужно создавать не всегда
                        if  isNeedToday() {
                            let newHistory = History()
                            newHistory.date = Date() as NSDate
                            newHistory.isDone = false
                            newHistory.thingToDo = newThingToDo
                        }
                        
                        if let count = count {
                            newThingToDo.priority = NSDecimalNumber(value: count + i)
                        } else {
                            newThingToDo.priority = NSDecimalNumber(value: 100)
                        }
                        newThingToDo.isActual = true
                        newThingToDo.name = nameTextField.text
                        newThingToDo.note = addInfoToNote(atIndex: i) + noteTExtField.text!
                        if dailySwitch.isOn {
                            newThingToDo.daily = true
                            newThingToDo.weekly = false
                            newThingToDo.monthly = false
                            
                            // проверка указано ли количество дней, в которые нужно выполнять задание
                            if duringStepperOutlet.value > 0 {
                                let dayToday = Date()
                                newThingToDo.time = Calendar.current.date(byAdding: .day, value: Int(duringStepperOutlet.value), to: dayToday)! as NSDate
                            }
                            
                        } else {
                            if weeklySwitch.isOn {
                                newThingToDo.daily = false
                                newThingToDo.weekly = true
                                newThingToDo.monthly = false
                                let week = Week()
                                record(week: week)
                                newThingToDo.week = week
                            } else {
                                if monthlySwitch.isOn {
                                    newThingToDo.daily = false
                                    newThingToDo.weekly = false
                                    newThingToDo.monthly = true
                                    for i in 1...31 {
                                        if let newButton = self.view.viewWithTag(100 + i) as? UIButton {
                                            if newButton.isSelected {
                                                let dayOfMonth = DayOfMonth()
                                                dayOfMonth.date = NSDecimalNumber(decimal: Decimal(i))
                                                dayOfMonth.thingToDo = newThingToDo
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    CoreDataManager.instance.saveContext()
                }
            }
            return true
        } else {
            return false
        }
    }
    // rule for work Stepper
    @IBAction func countTimesStepper(_ sender: UIStepper) {
        
        countTimesTextField.text = "\(Int(countTimesStepperOutlet.value))"
        if countTimesStepperOutlet.value > 1 {
            addInfoToNoteLabel.isEnabled = true
            infoToNoteSegmentControl.isEnabled  = true
        } else {
            addInfoToNoteLabel.isEnabled = false
            infoToNoteSegmentControl.isEnabled = false
        }
        if countTimesStepperOutlet.value > 5 {
            infoToNoteSegmentControl.setEnabled(false, forSegmentAt: 2)
            infoToNoteSegmentControl.selectedSegmentIndex = 1
        } else {
            infoToNoteSegmentControl.setEnabled(true, forSegmentAt: 2)
        }
    }
    
    @IBAction func duringStepper(_ sender: UIStepper) {
        if duringStepperOutlet.value == 0 {
            duringTextField.text = "∞"
        } else {
            duringTextField.text = "\(Int(duringStepperOutlet.value))"
        }
        installSwitchForDaily(howOften: 1)
    }
    // убрать клавиатуру, когда нажали на "другую" часть экрана
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // tap for WeeklyLabel
    @objc func tapForWeeklyLabel(sender: UITapGestureRecognizer) {
        guard let _ = sender.view as? UILabel else { return }
        if weeklySwitch.isOn {
            weeklyView.isHidden = false
            enabledElementInVC(is: false)
            createElementForWeeklyView()
        }
    }
    // tap for MonthlyLabel
    @objc func tapForMonthlyLabel(sender: UITapGestureRecognizer) {
        guard let _ = sender.view as? UILabel else { return }
        if monthlySwitch.isOn {
            monthlyView.isHidden = false
            enabledElementInVC(is: false)
            createElementForMonthlyView()
        }
    }

    // tag 1...7 - bad idea, I known
    func createElementForWeeklyView() {
        
        weeklyView.layer.cornerRadius = 15
        //        let dayArray = ["Пн","Вт","Ср","Чт","Пт","Сб","Вс"] // tag 1...7
        let dayArray = [NSLocalizedString("Mo", comment: ""),
                        NSLocalizedString("Tu", comment: ""),
                        NSLocalizedString("We", comment: ""),
                        NSLocalizedString("Th", comment: ""),
                        NSLocalizedString("Fr", comment: ""),
                        NSLocalizedString("Sa", comment: ""),
                        NSLocalizedString("Su", comment: "")] // tag 1...7
        let widht = Int(weeklyView.frame.size.width / 11)
        for i in 1...7 {
            // проверка создавались ли уже кнопки
            if let _ = self.view.viewWithTag(i) as? UIButton {
            } else {
                let dayButton = UIButton(type: .system)
                // old data
//                dayButton.frame = CGRect(x: Int(Double(widht)*1) + (i - 1) * Int(Double(widht) * 1.4) , y: widht * 4, width: widht, height: widht)
                dayButton.frame = CGRect(x: Int(Double(widht)*1) + (i - 1) * Int(Double(widht) * 1.4) ,
                                         y: Int(weeklyView.frame.height / 2) ,
                                         width: widht, height: widht)
                dayButton.layer.cornerRadius = CGFloat(Double(widht) / 5)
                dayButton.clipsToBounds = true
                dayButton.backgroundColor = .lightGray
                dayButton.setTitle(dayArray[i - 1], for : UIControlState.normal)
                dayButton.setTitleColor(UIColor(red: 51/255, green: 102/255, blue: 153/255, alpha: 1), for: .normal)
                dayButton.setTitleColor(.lightGray, for: .selected)
                dayButton.tintColor = UIColor(red: 51/255, green: 102/255, blue: 153/255, alpha: 1)
                dayButton.setBackgroundColor(UIColor(red: 51/255, green: 102/255, blue: 153/255, alpha: 1), for: .selected)
                dayButton.tag = i
                dayButton.addTarget(self, action: #selector(pressButton), for: .touchDown)
                weeklyView.addSubview(dayButton)
            }
        }
        readyWeeklyViewOutlet.sizeToFit()
        weeklyView.frame.size.height = CGFloat(widht * 8)
        readyWeeklyViewOutlet.center.x = CGFloat(Double(widht) * 5.6)
        readyWeeklyViewOutlet.center.y = CGFloat(Double(widht) * 6.5)
    }
    
    // tag 101...131
    func createElementForMonthlyView() {
        
        monthlyView.layer.cornerRadius = 15
        let width = Int(monthlyView.frame.size.width / 11)
        var row = 1
        var column = 1
        for i in 1...31 {
            // проверка создавались ли уже кнопки
            if let _ = self.view.viewWithTag(100+i) as? UIButton {
            } else {
                let dayButton = UIButton(type: .system)
                let startY = titleOnMonthlyView.frame.maxY //MaxY for title in this View
                // old version
//                dayButton.frame = CGRect(x: Int(Double(width)*1) + (column - 1) * Int(Double(width) * 1.4) ,
//                                         y: Int(Double(width) * (3.5 + 1.4 * Double((row - 1)) )),
//                                         width: width, height: width)
                dayButton.frame = CGRect(x: Int(Double(width)*1) + (column - 1) * Int(Double(width) * 1.4) ,
                                         y: Int(startY) + Int(Double(width) * (0.7 + 1.4 * Double((row - 1)) )),
                                         width: width, height: width)
                dayButton.layer.cornerRadius = CGFloat(Double(width) / 5)
                dayButton.clipsToBounds = true
                dayButton.backgroundColor = .lightGray
                dayButton.setTitle("\(i)", for : UIControlState.normal)
                dayButton.setTitleColor(UIColor(red: 51/255, green: 102/255, blue: 153/255, alpha: 1), for: .normal)
                dayButton.setTitleColor(.lightGray, for: .selected)
                dayButton.setBackgroundColor(UIColor(red: 51/255, green: 102/255, blue: 153/255, alpha: 1), for: .selected)
                dayButton.tag = 100 + i
                dayButton.addTarget(self, action: #selector(pressButton), for: .touchDown)
                monthlyView.addSubview(dayButton)
//                if row == 5 {
//                    print("row = 5",Int(startY) + Int(Double(width) * (0.7 + 1.4 * Double((row - 1)) )))
//                }
            }
            column += 1
            if (i % 7) == 0 {
                row += 1
                column = 1
            }
        }
        
//        let width8 = Double(monthlyView.frame.size.width / 11)
//        let yyy = nameTextField.frame.maxY + (nameTextField.frame.maxY - nameTextField.frame.minY ) / 2
//        let width2 = view.frame.size.width
//        let width3 = Int(width2) - Int(width8 * 1.6)
////        let newView = UIView()
//        let startY = titleOnMonthlyView.frame.maxY //MaxY for title in this View
//        monthlyView.frame = CGRect(x: Int(width8 * 0.8),
//                               y: Int(yyy),
//                               width: Int(width3),
//                               height: Int(Int(startY) + Int(Double(width8) * (2.2  + 1.4 * 5)))
//        )
//        newView.backgroundColor = .blue
//        view.addSubview(newView)
////        monthlyView.frame.size.height = CGFloat(Double(width) * 12.7)
//        monthlyView.frame.size.height = 200
    }

    
    // choose weekly day on add View
    @objc func pressButton(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
    }
    
    // turn of is need
    func installSwitchForDaily(howOften index:Int) {
        switch index {
        case 1: dailySwitch.setOn(true, animated: true)
                weeklySwitch.setOn(false, animated: true)
                monthlySwitch.setOn(false, animated: true)
        case 2: dailySwitch.setOn(false, animated: true)
                weeklySwitch.setOn(true, animated: true)
                monthlySwitch.setOn(false, animated: true)
        case 3: dailySwitch.setOn(false, animated: true)
                weeklySwitch.setOn(false, animated: true)
                monthlySwitch.setOn(true, animated: true)
        default:
            break
        }
        
    }
    // change enabled property if Add View is Active
    func enabledElementInVC(is isEnabled:Bool){
        pressSaveButton.isEnabled = isEnabled
        pressCancelButton.isEnabled = isEnabled
        nameTextField.isEnabled = isEnabled
        noteTExtField.isEnabled = isEnabled
        infoToNoteSegmentControl.isEnabled = isEnabled
        countTimesStepperOutlet.isEnabled = isEnabled
        weeklyLabel.isEnabled = isEnabled
        monthlyLabel.isEnabled = isEnabled
        weeklySwitch.isEnabled = isEnabled
        monthlySwitch.isEnabled = isEnabled
        dailySwitch.isEnabled = isEnabled
//        notificationSwitch.isEnabled = isEnabled
    }
    // choose 1 from 3
    @IBAction func actionDailySwitch(_ sender: UISwitch) {
        installSwitchForDaily(howOften: 1)
    }
    
    // choose 2 from 3
    @IBAction func actionWeeklySwitch(_ sender: UISwitch) {
        installSwitchForDaily(howOften: 2)
        weeklyView.isHidden = false
        enabledElementInVC(is: false)
        createElementForWeeklyView()
        duringTextField.text = "∞"
        duringStepperOutlet.value = 0
    }
    
    // choose 3 from 3
    @IBAction func actionMonthlySwitch(_ sender: UISwitch) {
        installSwitchForDaily(howOften: 3)
        monthlyView.isHidden = false
        enabledElementInVC(is: false)
        createElementForMonthlyView()
        duringTextField.text = "∞"
        duringStepperOutlet.value = 0
    }
    
    func showAlertWith(message:String) {
//        let alert = UIAlertController(title: "Внимание", message: message, preferredStyle: .alert)
//        let okButton = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
        let alert = UIAlertController(title: NSLocalizedString("Attention", comment: ""),
                                      message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: NSLocalizedString("OK", comment: ""),
                                     style: .cancel, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    // close WeeklyView
    @IBAction func readyWeeklyViewButton(_ sender: UIButton) {
        var isSelected = false
        var numberWeeklyDay = 1
        while numberWeeklyDay != 8 { // I known bad
            if let newButton = self.view.viewWithTag(numberWeeklyDay) as? UIButton {
                if newButton.isSelected {
                    isSelected = true
                    print(numberWeeklyDay)
                }
            }
            if isSelected {
                numberWeeklyDay = 8
            } else {
                numberWeeklyDay += 1
            }
        }
        if !isSelected {
//            showAlertWith(message: "Не выбран день недели")
            showAlertWith(message: NSLocalizedString("The day of the week is not selected", comment: ""))
        }
        else {
            enabledElementInVC(is: true)
            weeklyView.isHidden = true
        }
    }
    
    @IBAction func readyMonthlyViewButton(_ sender: UIButton) {
        // need code
        var isSelected = false
        var numberDay = 1
        while numberDay != 32 { // I known bad
            if let newButton = self.view.viewWithTag(100 + numberDay) as? UIButton {
                if newButton.isSelected {
                    isSelected = true
                }
            }
            if isSelected {
                numberDay = 32
            } else {
                numberDay += 1
            }
        }
        if !isSelected {
//            showAlertWith(message: "Не выбраны даты")
            showAlertWith(message: NSLocalizedString("Dates are not selected", comment: ""))
        }
        else {
            enabledElementInVC(is: true)
            monthlyView.isHidden = true
        }
    }
    
}

// set Color in backGround if button is Selected = true
extension UIButton {
    private func imageWithColor(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func setBackgroundColor(_ color: UIColor, for state: UIControlState) {
        self.setBackgroundImage(imageWithColor(color: color), for: state)
    }
}
