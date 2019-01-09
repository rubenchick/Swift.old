//
//  ListOfWordsViewController.swift
//  Learn Hebrew
//
//  Created by Anton Rubenchik on 18/11/2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
/*
 +1. Убирание с обучения
 2. Возвращение на обучение
 3. Удаление из базы
 4. Загружать из программы
 5. Поиск
 6. Зайти в карточку
 7. Загружать новые данные, не на автомате, а по нажатию на кнопку
 */

import UIKit
import CoreData
import AVFoundation
import Foundation
import Firebase

class ListOfWordsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var ref: DatabaseReference!
    let user = Auth.auth().currentUser?.email
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var wordsCoreDataArray : [Words] = [] //from CoreData
    var currentWordsArray = [Words]() // from Filter
    
    //MARK:- viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        tableView.tableFooterView = UIView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        tableView.isEditing = false
        createArray()
        // Do any additional setup after loading the view.
    }
    //MARK:- Main function
    func createArray() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Words")

//        let predicate = NSPredicate(format: "%K == %@", "isLearned", NSNumber(value: false)) // all records
        let predicate = NSPredicate(format: "%K == %@", "discription", user!)
        request.predicate = predicate
        do {
            let words = try CoreDataManager.instance.persistentContainer.viewContext.fetch(request) as! [Words]
            wordsCoreDataArray = words
            wordsCoreDataArray.sort(){$0.foreign! < $1.foreign!}
        } catch {
            print(error)
        }
        currentWordsArray = wordsCoreDataArray
        print(currentWordsArray.count)
    }
    
    @objc func doubleTapped() {
        tableView.isEditing = !tableView.isEditing
        tableView.reloadData()
    }
    //MARK:- TableView delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentWordsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        let nextDate = formatter.string(from: currentWordsArray[indexPath.row].nextContact as! Date)
   
        let addInfoLabel = UILabel()
        switch currentWordsArray[indexPath.row].levelOfLearning {
        case 0: addInfoLabel.textColor = UIColor.red
        case 1...3: addInfoLabel.textColor = UIColor.darkGray
        case 4...8: addInfoLabel.textColor = UIColor.black
        default:
            break
        }
        addInfoLabel.text = "[\(currentWordsArray[indexPath.row].levelOfLearning)] \(nextDate)"
        addInfoLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(10))
        addInfoLabel.sizeToFit()
        
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = currentWordsArray[indexPath.row].foreign
        cell.detailTextLabel?.text = currentWordsArray[indexPath.row].original!
        addInfoLabel.frame = CGRect(x: cell.frame.width - addInfoLabel.frame.width - 60 ,
                                    y: cell.frame.height - addInfoLabel.frame.height+30,
                                    width: addInfoLabel.frame.width,
                                    height: addInfoLabel.frame.height)
        cell.addSubview(addInfoLabel)
        cell.accessoryType = !currentWordsArray[indexPath.row].dontWantToLearn ? .checkmark : .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Обязательно нужен данный метод, без него не будет обновление работать
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            array.remove(at: indexPath.row)
//            tableView.reloadData()

//            let managedObject = fetchRequest.object(at: indexPath) as! NSManagedObject
//            CoreDataManager.instance.persistentContainer.viewContext.delete(managedObject)
//            wordsCoreDataArray.remove(at: indexPath.row)
//            CoreDataManager.instance.saveContext()
//            tableView.reloadData()
            print(currentWordsArray[indexPath.row].foreign," delete")
            
//
//            var fetchRequest = History.fetchedResultsToday()
//            if editingStyle == .delete {
//                let managedObject = fetchRequest.object(at: indexPath) as! NSManagedObject
//                CoreDataManager.instance.persistentContainer.viewContext.delete(managedObject)
//                CoreDataManager.instance.saveContext()
//            }
//
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            currentWordsArray[indexPath.row].dontWantToLearn = true
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            currentWordsArray[indexPath.row].dontWantToLearn = false
        }
        CoreDataManager.instance.saveContext()
    }
    //MARK:- Navigation
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- SearchBar delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text != "" {
            currentWordsArray = wordsCoreDataArray.filter({ (word) -> Bool in
                guard let text = searchBar.text else { return false }
                return word.foreign?.lowercased().contains(text.lowercased()) ?? false
            })
        } else {
            currentWordsArray = wordsCoreDataArray
        }
        print("---")
        tableView.reloadData()

        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
}
