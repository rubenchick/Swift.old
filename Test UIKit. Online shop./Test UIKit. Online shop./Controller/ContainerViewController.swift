//
//  ContainerViewController.swift
//  Test UIKit. Online shop.
//
//  Created by Anton Rubenchik on 15.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var orderLabel: UIButton! //sorry Button
    @IBOutlet weak var sumLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .blue
//
        self.navigationItem.title = "Корзина"
        
        orderLabel.layer.cornerRadius = 15
        orderLabel.backgroundColor = .clear
        orderLabel.setTitleColor(UIColor(red: 176/255, green: 40/255, blue: 30/255, alpha: 1), for: .normal)
        orderLabel.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        orderLabel.layer.borderWidth = 3
        orderLabel.layer.borderColor = UIColor(red: 176/255, green: 40/255, blue: 30/255, alpha: 1).cgColor
        var total: Int = 0
        for item in cartArray {
            total += item.count! * item.price!
        }
        sumLabel.text = "\(total) ₽"
    }


    @IBAction func orderButton(_ sender: Any) {
        let orderedMeggageController = UIAlertController(title: nil, message: "Списобо за заказ.\n Ждем Вас снова.", preferredStyle: .alert)
        let alertButtton = UIAlertAction(title: "Закрыть", style: .cancel) { (x) in
            Order.sharedInstance.sum = 0
            self.navigationController?.popToRootViewController(animated: true)
        }
        orderedMeggageController.addAction(alertButtton)
        self.present(orderedMeggageController, animated: true, completion: nil)
    }
    
}
