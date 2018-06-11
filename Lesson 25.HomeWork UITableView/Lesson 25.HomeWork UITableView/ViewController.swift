//
//  ViewController.swift
//  Lesson 25.HomeWork UITableView
//
//  Created by Anton Rubenchik on 09.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//Ученик.
//
//1. Создайте таблицу которая содержит 1000 разных ячеек.
//2. для каждой ячейки генирируйте радномный цвет.
//3. RGB данные пишите в тексте ячейки, например: RGB(10,20,255)
//4. Также раскрашивайте текст ячейки этим цветом.
//
//Студент.
//
//5. Теперь создайте класс, который содержит цвет и нейм.
//6. В viewDidLoad сгенерируйте 1000 объектов такого класса по принципу из ученика
//7. Положите их в массив и отобразите в таблице
//8. В этом случае когда вы будете листать назад вы увидете те же ячейки, что там и были, а не новые рандомные
//
//Мастер.
//
//9. Возвращаемся к слудентам. Сгенерируйте 20-30 разных студентов.
//10. В таблице создавайте не дефаулт ячейку а Value1. В этом случае у вас появится еще одна UILabel - detailLabel.
//11. В textLabel пишите имя и фамилию студента, а в detailLabel его средний бал.
//12. Если средний бал низкий - окрашивайте имя студента в красный цвет
//13. Отсортируйте студентов в алфовитном порядке и отобразите в таблице
//
//Супермен.
//
//14. Средний бал для студентов ставьте рандомно от 2 до 5
//15. После того, как вы сгенерировали 30 студентов вам надо их разбить на группы:
//отличники, хорошисты, троечники и двоечники
//16. Каждая группа это секция с соответствующим названием.
//17. Студенты внутри своих групп должны быть в алфовитном порядке
//18. Отобразите группы студентов с их оченками в таблице.
//
//Mission Impossible!
//
//19. Добавьте к супермену еще одну секцию, в которой вы отобразите 10 моделей цветов из задания Студент.
//20. Помните, это должно быть 2 разных типа ячеек Value1 для студентов и Default для цветов.

import UIKit
import Foundation

class ViewController: UIViewController {
   
    let identify = "mainCell"
    let identify2 = "colorCell"
    var mainTableView = UITableView()
    // array for different level
    var levelStudentArray : [TypeOfCell] = []
    var levelMasterArray : [(String,Double)] = [("Ситдикова Айлара Ринатовна",4.4),
                                                ("Докучаева Кристина Алексеевна",3.6),
                                                ("Пегасин Кристиан Иванович",3.9),
                                                ("Глембо Алексей Сергеевич",3.4),
                                                ("Яковлева Ульяна Владимировна",5.0),
                                                ("Волова Анна Дмитриевна",3.0),
                                                ("Ишмухаметова Элина Ильдаровна",4.6),
                                                ("Зеленов Владимир Эдуардович",4.7),
                                                ("Топоркова Марина Сергеевна",4.4),
                                                ("Корбей Анастасия Сергеевна", 4.3),
                                                ("Калёнова Екатерина Денисовна",5.0),
                                                ("Пономарева Елизавета Андреевна",4.9),
                                                ("Антонов Антон Игоревич ",3.4),
                                                ("Коновалова Арина Александровна",3.9),
                                                ("Нопин Данил Александрович",4.7),
                                                ("Грачёва Анна Алексеевна",4.1),
                                                ("Васильева Наталья Васильевна",4.4),
                                                ("Очирова Римма Осоровна",3.4),
                                                ("Крицкая Екатерина Владимировна",3.1),
                                                ("Васильев Денис Филиппович",3.1),
                                                ("Чиквашвили Николай Давидович",4.7),
                                                ("Матвеева Мария Евгеньевна",4.6),
                                                ("Болгов Артем Игоревич",4.2),
                                                ("Гунькина Дарья Александровна",4.1)]

    let typeOfStudent = ["Отличники","Хорошисты","Троечники","Двоечники","Colors"]
    var (exellent, good, satisfactory, bad) = (0,0,0,0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTable()
        createLevelStudentArray()
    }
    
    func createTable() {
        mainTableView = UITableView(frame: view.bounds, style: .plain)
        
        //automatically created for you using the UITableViewCellStyleDefault style.
        // level SchoolBoy and Student
     //   mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: identify)
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        //level Master
        //levelMasterArray.sort(by: {$0.0 < $1.0})
        
        //level Superman
        createLevelSupermanArray()

        levelMasterArray.sort(by: {
            var (mark1,mark2) = (0,0)
            
            switch $0.1 {
            case 0..<3: mark1 = 2
            case 3..<4: mark1 = 3
            case 4..<4.8: mark1 = 4
            case 4.8...5: mark1 = 5
            default:
                break
            }
            switch $1.1 {
            case 0..<3: mark2 = 2
            case 3..<4: mark2 = 3
            case 4..<4.8: mark2 = 4
            case 4.8...5: mark2 = 5
            default:
                break
            }
            
            if mark2 < mark1 {return true}
            else if mark2 > mark1 { return false }
            else {if $0.0 > $1.0  { return false } }
            return true
        })
        view.addSubview(mainTableView)
    }
    
    func createLevelSupermanArray() {
        
        for i in 0...levelMasterArray.count - 1 {
            levelMasterArray[i].1 = (Double((arc4random() % 30)) + 20)/10
            // count type of mark
            switch levelMasterArray[i].1 {
            case 0..<3: bad += 1
            case 3..<4: satisfactory += 1
            case 4..<4.8: good += 1
            case 4.8...5: do {
                print(levelMasterArray[i].0," ",levelMasterArray[i].1)
                exellent += 1
                }
            default: break
            }
        }
    }
    
    func createLevelStudentArray() {
        for _ in 0...9 {
            let newItem = TypeOfCell()
            let red = arc4random() % 255
            let green = arc4random() % 255
            let blue = arc4random() % 255
            
            let getRandomColor : UIColor = {
                let randomRed:CGFloat = CGFloat(red) / CGFloat(255)
                let randomGreen:CGFloat = CGFloat(green) / CGFloat(255)
                let randomBlue:CGFloat = CGFloat(blue) / CGFloat(255)
                return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
            }()
            
            newItem.color =  getRandomColor
            newItem.text  =  "RGB(\(red),\(green),\(blue))"
            levelStudentArray.append(newItem)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return typeOfStudent.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return typeOfStudent[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0: return exellent
        case 1: return good
        case 2: return satisfactory
        case 3: return bad
        case 4: return 10
        default: break
        }
        
        return 0
    }
//    // level schoolBoy, student and master
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //level schoolBoy and Student
//        //return 1000
//
//        //level Master
//        return levelMasterArray.count
//
//    }
    
//    // Level SchoolBoy
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath)
//
//        let red = arc4random() % 255
//        let green = arc4random() % 255
//        let blue = arc4random() % 255
//
//        let getRandomColor : UIColor = {
//            let randomRed:CGFloat = CGFloat(red) / CGFloat(255)
//            let randomGreen:CGFloat = CGFloat(green) / CGFloat(255)
//            let randomBlue:CGFloat = CGFloat(blue) / CGFloat(255)
//        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
//        }()
//
//        cell.textLabel?.textColor = getRandomColor
//        cell.textLabel?.text = "RGB(\(red),\(green),\(blue))"
//
//        return cell
//    }
    
//     Level Students
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath)
//            cell.textLabel?.text = levelStudentArray[indexPath.row].text
//            cell.textLabel?.textColor = levelStudentArray[indexPath.row].color
//
//            return cell
//        }

    //     Level Master
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        // level SchooBoy and Student
////        let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath)
//
//        // level Master
//        // custom cell
//        var cell = tableView.dequeueReusableCell(withIdentifier: identify)
//        if cell == nil {
//            cell = UITableViewCell(style: .value1, reuseIdentifier: identify)
//        }
//
//        cell?.textLabel?.text = levelMasterArray[indexPath.row].0
//        cell?.textLabel?.textColor = levelMasterArray[indexPath.row].1 >= 4 ? UIColor.black : UIColor.red
//        cell?.detailTextLabel?.text = String(levelMasterArray[indexPath.row].1)
//        cell?.detailTextLabel?.textColor = UIColor.black
//
//        return cell!
//
//    }
//         Level Superman
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            if indexPath.section < 4 {
                var cell = tableView.dequeueReusableCell(withIdentifier: identify)
                if cell == nil {
                    cell = UITableViewCell(style: .value1, reuseIdentifier: identify)
                }
                
                var delta = 0
                switch indexPath.section {
                case 1: delta = exellent
                case 2: delta = exellent + good
                case 3: delta = exellent + good + satisfactory
                default: break
                }
                
                cell?.textLabel?.text = levelMasterArray[indexPath.row + delta].0
                cell?.textLabel?.textColor = levelMasterArray[indexPath.row + delta].1 >= 4 ? UIColor.black : UIColor.red
                cell?.detailTextLabel?.text = String(levelMasterArray[indexPath.row + delta].1)
                cell?.detailTextLabel?.textColor = UIColor.black
                
                return cell!
            }
            else {
                
                // level Mission Impossible!
                var cell = tableView.dequeueReusableCell(withIdentifier: identify2)
                if cell == nil {
                    cell = UITableViewCell(style: .default, reuseIdentifier: identify2)
                }
                cell?.textLabel?.text = levelStudentArray[indexPath.row].text
                cell?.textLabel?.textColor = levelStudentArray[indexPath.row].color
                
                return cell!
            }
        }
    
    // section set background color and set text color
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 255/255, green: 206/255, blue: 110/255, alpha: 1)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor(red: 0/255, green: 140/255, blue: 255/255, alpha: 1)
    }
}
























