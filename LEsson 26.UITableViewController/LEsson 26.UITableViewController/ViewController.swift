//
//  ViewController.swift
//  LEsson 26.UITableViewController
//
//  Created by Anton Rubenchik on 10.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let tableViewController = UITableViewController(style: .plain)
    let studentsArray = ["Mask","Cherchil","Belih","Ivanov"]
    var refreshArray = [Date]()
    let identifier = "myCell"
    var refresh = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        refresh.addTarget(self, action: #selector(pressedRefresh), for: .valueChanged)
        refresh.tintColor = .blue
        tableViewController.tableView.addSubview(refresh)
        
        
        
        createTable()
        view.addSubview(tableViewController.tableView)
    }
    
    @objc func pressedRefresh() {
        refreshArray.append(Date())
        refresh.endRefreshing()
        let indexPath = IndexPath(row: refreshArray.count - 1, section: 0)
        tableViewController.tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func createTable() {
        tableViewController.tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableViewController.tableView.delegate = self
        tableViewController.tableView.dataSource = self
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refreshArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = "\(refreshArray[indexPath.row])"
        return cell
    }
    
    
}

