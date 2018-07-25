//
//  SecondDetailViewController.swift
//  Daily Routine
//
//  Created by Anton Rubenchik on 21.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.

// Закончил полностью функционал Weekly для нового Thing.
// 1. Нужно грузить weekly для уже существующих thing
// 2. Сделать monthly.

import UIKit

class SecondDetailViewController: UIViewController {
    var thingToDo: ThingToDo?
    var count: Int?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var noteTExtField: UITextField!
    @IBOutlet weak var addInfoToNoteLabel: UILabel!
    @IBOutlet weak var countTimesTextField: UITextField!
    @IBOutlet weak var infoToNoteSegmentControl: UISegmentedControl!
    @IBOutlet weak var countTimesStepperOutlet: UIStepper!
    @IBOutlet weak var weeklyView: UIView!
    @IBOutlet weak var weeklyLabel: UILabel!
    @IBOutlet weak var monthlyLabel: UILabel!
    @IBOutlet weak var weeklySwitch: UISwitch!
    @IBOutlet weak var monthlySwitch: UISwitch!
    @IBOutlet weak var dailySwitch: UISwitch!
    @IBOutlet weak var pressSaveButton: UIBarButtonItem!
    @IBOutlet weak var pressCancelButton: UIBarButtonItem!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        UIApplication.shared.statusBarView?.backgroundColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let thingToDo = thingToDo {
            nameTextField.text = thingToDo.name
            noteTExtField.text = thingToDo.note
        }
        
        weeklyView.frame.size.height = weeklyView.frame.size.width / 2
        // tap for WeeklyLabel
        let tapGestureForWeeklyLabel = UITapGestureRecognizer(target: self, action: #selector(tapForWeeklyLabel))
        weeklyLabel.isUserInteractionEnabled = true
        weeklyLabel.addGestureRecognizer(tapGestureForWeeklyLabel)
    }

    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if saveThingToDo() {
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Внимание", message: "Не введено название ", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    func addInfoToNote(atIndex index: Int) -> String{
        let timeForDayDictionary = [2: ["утром","вечером"],
                                    3: ["утром","днем","вечером"],
                                    4: ["утром","до обеда","после обеда","вечером"],
                                    5: ["утром","до обеда","после обеда","вечером","ночью"]]
        let endOfNumbersArray = ["-ой","-ый","-ой","-ий","-ый","-ый","-ой","-ой","-ой","-ой","-ой"]
        var addInfo = ""
        if let times = Int(countTimesTextField.text!) {
            if times > 1 {
                if infoToNoteSegmentControl.selectedSegmentIndex != 0 {
                    if infoToNoteSegmentControl.selectedSegmentIndex == 1 {
                        addInfo = "(\(index)\(endOfNumbersArray[index]) раз) "
                    } else {
                        let timeForDayArray = timeForDayDictionary[times]
                        addInfo = "( " + timeForDayArray![index-1] + " ) "
                    }
                }
            }
        }
        return addInfo
    }
    
    func saveThingToDo() -> Bool {
        if nameTextField.text != "" {
            if thingToDo == nil {
                thingToDo = ThingToDo()
                let history = History()
                history.date = Date() as NSDate
                history.isDone = false
                history.thingToDo = thingToDo
                if let count = count {
                    thingToDo?.priority = NSDecimalNumber(value: count)
                } else {
                    thingToDo?.priority = NSDecimalNumber(value: 100)
                }
                thingToDo?.isActual = true
            }
            if dailySwitch.isOn {
                thingToDo?.daily = true
            } else {
                
                if weeklySwitch.isOn {
                    thingToDo?.weekly = true
                    let weekly = Week()
                    for i in 1...7 {
                        if let newButton = self.view.viewWithTag(i) as? UIButton {
                            if newButton.isSelected {
                                switch i {
                                case 1: weekly.monday = true
                                case 2: weekly.tuesday = true
                                case 3: weekly.wednesday = true
                                case 4: weekly.thursday = true
                                case 5: weekly.friday = true
                                case 6: weekly.saturday = true
                                case 7: weekly.sunday = true
                                default: break
                                }
                            }
                        }
                    }
                    thingToDo?.week = weekly
                } else {
                    if monthlySwitch.isOn {
                        
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
                        let newHistory = History()
                        newHistory.date = Date() as NSDate
                        newHistory.isDone = false
                        newHistory.thingToDo = newThingToDo
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
                        } else {
                            if weeklySwitch.isOn {
                                newThingToDo.weekly = true
                                let weekly = Week()
                                for i in 1...7 {
                                    if let newButton = self.view.viewWithTag(i) as? UIButton {
                                        if newButton.isSelected {
                                            switch i {
                                            case 1: weekly.monday = true
                                            case 2: weekly.tuesday = true
                                            case 3: weekly.wednesday = true
                                            case 4: weekly.thursday = true
                                            case 5: weekly.friday = true
                                            case 6: weekly.saturday = true
                                            case 7: weekly.sunday = true
                                            default: break
                                            }
                                        }
                                    }
                                }
                                newThingToDo.week = weekly
                            } else {
                                if monthlySwitch.isOn {
                                    
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
    
    // tag 1...7
    func createElementForWeeklyView() {
        
        weeklyView.layer.cornerRadius = 15
        let dayArray = ["Пн","Вт","Ср","Чт","Пт","Сб","Вс"] // tag 1...7
        let widht = Int(weeklyView.frame.size.width / 13)
        for i in 1...7 {
            // проверка создавались ли уже кнопки
            if let _ = self.view.viewWithTag(i) as? UIButton {
            } else {
                let dayButton = UIButton(type: .system)
                dayButton.frame = CGRect(x: Int(Double(widht)*1.5) + (i - 1) * Int(Double(widht) * 1.5) , y: widht * 4, width: widht, height: widht)
                dayButton.layer.cornerRadius = CGFloat(Double(widht) / 5)
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
        notificationSwitch.isEnabled = isEnabled
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
    }
    // choose 3 from 3
    @IBAction func actionMonthlySwitch(_ sender: UISwitch) {
         installSwitchForDaily(howOften: 3)
    }
    // close WeeklyView
    @IBAction func readyWeeklyViewButton(_ sender: UIButton) {
        var isSelected = false
        var numberWeeklyDay = 1
        while numberWeeklyDay != 8 {
            if let newButton = self.view.viewWithTag(numberWeeklyDay) as? UIButton {
                if newButton.isSelected {
                    isSelected = true
                    print(numberWeeklyDay)
                }
            }
            numberWeeklyDay += 1
        }
        if !isSelected {
            let alert = UIAlertController(title: "Внимание", message: "Не выбран день недели", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
        else {
            enabledElementInVC(is: true)
            weeklyView.isHidden = true
        }
    }
    
    
}

