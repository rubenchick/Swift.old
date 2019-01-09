//
//  ShowViewController.swift
//  Knowledge check
//
//  Created by Anton Rubenchik on 15/11/2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData

class ShowViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleListLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        startWork()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)

    }
    
    @objc func doubleTapped() {
        tableView.isEditing = !tableView.isEditing
        tableView.reloadData()
    }
    func startWork() {
        tableView.isEditing = false
//        titleListLabel.text = titleGlobalArray[currentList]
        titleListLabel.text = groupsArray[currentList].name
        tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordsArray.count
//         return globalArray[currentList].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
//        cell.textLabel?.text = globalArray[currentList][indexPath.row]
        cell.textLabel?.text = wordsArray[indexPath.row].name
        return cell
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
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Words")
            let predicateGroup = NSPredicate(format: "%K == %@", "group",groupsArray[currentList])
            let predicateWords = NSPredicate(format: "%K == %@", "name",wordsArray[indexPath.row].name!)
            let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateGroup,predicateWords])
            request.predicate = compound
            do {
                let words = try CoreDataManager.instance.persistentContainer.viewContext.fetch(request) as! [NSManagedObject]
                if words.count > 0 {
                    for word in words {
                        CoreDataManager.instance.persistentContainer.viewContext.delete(word)
                    }
                    CoreDataManager.instance.saveContext()
                    wordsArray.remove(at: indexPath.row)
                }
            } catch {
                print(error)
            }
            tableView.reloadData()
        }
    }

}
