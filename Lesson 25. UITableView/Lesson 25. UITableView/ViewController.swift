//
//  ViewController.swift
//  Lesson 25. UITableView
//
//  Created by Anton Rubenchik on 09.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//


import UIKit

class ViewController: UIViewController{
    
    var mainTableView = UITableView()
    let identifier = "currentCell"
    var studentArray : [String] = ["Ivan","Petr","Max","Olga","Sveta","Den"]
    var sectionArray : [String] = ["Man","Woman"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()

    }
    
    fileprivate func createTableView() {
        mainTableView = UITableView(frame: view.bounds, style: .plain)
        // ХЗ - нужно разбираться. Строчка, если делать кодом
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        mainTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]


        mainTableView.delegate   = self
        mainTableView.dataSource = self
        view.addSubview(mainTableView)
    }



}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - DataSource
    // Count section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Count cell in Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 3
//        case 2: return 8
        default:
            break
        }
//        return studentArray.count
        return 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionArray[section]
    }
    
    // какая ячейка будет. Формирует
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        //cell.textLabel?.text = "Section - \(indexPath.section), row -  \(indexPath.row)"
        let student = studentArray[indexPath.row]
        cell.textLabel?.text = student + "S - \(indexPath.section), R - \(indexPath.row)  "
        
        
        // some standart things with cell
//        cell.accessoryType = .checkmark
        cell.accessoryType = .detailButton // нажатие обрабатывается в Delegate
//        cell.accessoryType = .disclosureIndicator
//        cell.accessoryType = .detailDisclosureButton
        // different things with different section
//        switch indexPath.section {
//        case 0: cell.backgroundColor = UIColor.red
//        case 1: cell.backgroundColor = UIColor.blue
//        case 2: cell.backgroundColor = UIColor.orange
//        default: break
//        }
  
        return cell
    }
    
    // MARK: - Delegate
    // hight cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // при нажатии на cell.accessoryType = .detailButton
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("Accessory \(indexPath)")
        let ownCell  = tableView.cellForRow(at: indexPath) // получаем данные из ячейки
        print("Text \(ownCell?.textLabel?.text ?? "nil")")
    }
    
    // нажали на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(studentArray[indexPath.row])
        tableView.isEditing = !tableView.isEditing
    }
    
    //delete
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            studentArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .middle)
        }
    }
    
    // Moving
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = studentArray[sourceIndexPath.row]
        studentArray.remove(at: sourceIndexPath.row)
        studentArray.insert(item, at: destinationIndexPath.row)
        
    }
    
    
    
    
    
    
    
    
}
