//
//  TableViewController.swift
//  Lesson 26. UITAbleViewController. Storyboard
//
//  Created by Anton Rubenchik on 10.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var mainArray = [Member]()
    let identifier = "mainCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createArray()
    }
    func createArray() {
        let newElement = Member (name: "Ivanov", job: "teacher")
        mainArray.append(newElement)
        mainArray.append(Member (name: "Petrov", job: "footballer"))
        mainArray.append(Member (name: "Sidorov", job: "builder"))
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TableViewCell {
            
            cell.getData(item: mainArray[indexPath.row])
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
