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
           self.navigationController?.popViewController(animated: true)
        
//            var total: Int = 0
//            for item in cartArray {
//                total += item.count! * item.price!
//            }
//
//            var containerVC = ContainerViewController()
//             containerVC.sumLabel.text = "777 ₽"
//            containerVC.sumLabel.text = "\(total) ₽"
//
//
//            var total: Int = 0
//            for item in cartArray {
//                total += item.count! * item.price!
//            }
//            sumLabel.text = "\(total) ₽"
        }
    }
    

}

