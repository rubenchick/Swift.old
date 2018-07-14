//
//  CartTableViewController.swift
//  Test UIKit. Online shop.
//
//  Created by Anton Rubenchik on 14.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class CartTableViewController: UITableViewController {

    let cellIdentifier = "cartCell"
    var dictionary = ["Total": 777]
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Cart")
        print(cartArray.count)
         self.navigationItem.rightBarButtonItem = self.editButtonItem
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.title = "Корзина"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cartArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if   let cell = tableView.dequeueReusableCell(withIdentifier: "333", for: indexPath) as? CartTableViewCell {
            cell.getData(item: cartArray[indexPath.row])
            return cell
         }
        else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    // нажали на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(cartArray[indexPath.row])
        tableView.isEditing = !tableView.isEditing
    }

    //delete
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Order.sharedInstance.sum -= cartArray[indexPath.row].count! * cartArray[indexPath.row].price!
            cartArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .middle)
           //  This is a bad decision. It is necessary to rewrite.
//            self.navigationController?.popViewController(animated: true)
            // This is good decision
            
            dictionary["Total"] = Order.sharedInstance.sum
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationFromTableViewAboutTotalCoast"), object: nil, userInfo: dictionary)
            
            
        }
    }
}

