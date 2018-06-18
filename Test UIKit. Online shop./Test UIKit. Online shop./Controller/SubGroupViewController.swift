//
//  SubGroupViewController.swift
//  Test UIKit. Online shop.
//
//  Created by Anton Rubenchik on 12.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class SubGroupViewController: UIViewController {
    let subGroupIdentifire = "subGroupCell"
    let segueIdentifire = "showProduct"
    
    @IBOutlet weak var subGroupCollectionView: UICollectionView!
    
    var subGroupArray = [SubGroup]()
    
    var group: Int? {
        didSet{
            var newArray = [SubGroup]()
            var newItem = SubGroup()
            // массивы данных
            let subGroupNameArray = ["ГУРМЕ","ГОВЯДИНА","КУРИЦА","РЫБА","САЛАТЫ И РОЛЫ","СТАРТЕРЫ","КАРТОФЕЛЬ","СОУСЫ",
                                     "МАКМАФФИНЫ","РОЛЫ И ОМЛЕТЫ","КАРТОФЕЛЬ","РАЗНОЕ","ДЖЕМЫ","ХЕППИ МИЛ","ОВОЩИ",
                                     "ПРОХЛАДИТЕЛЬНЫЕ","НАПИТКИ-ДЕСЕРТЫ","ГОРЯЧИЕ НАПИТКИ",
                                     "МОРОЖЕННОЕ","МАФФИНЫ",
                                     "САНДВИЧИ","КАРТОФЕЛЬ","ФРУКТЫ","НАПИТКИ",
                                     "НАПИТКИ"]
            let subGroupImageArray = ["1gurme","1beaf","1cheaken","1fish","1salad","1started","1patetos","1sous",
                                      "2macmaffin","2rolls","2diferent","1patetos","2jem","happyMil2","2fruit",
                                      "3cool","3coctail","3hot",
                                      "4icecream","4maffin",
                                      "5sandwich","5popetos","2fruit","5drink",
                                      "6drink"]
            let subGroupIndexArray = [1,2,3,4,5,6,7,8,
                                      9,10,11,12,13,14,15,
                                      16,17,18,
                                      19,20,
                                      21,22,23,24,
                                      25]
            let subGroupIndexGroupArray = [1,1,1,1,1,1,1,1,
                                           2,2,2,2,2,2,2,
                                           3,3,3,
                                           4,4,
                                           5,5,5,5,
                                           6]
            // засовываем в массив
            for i in 0...subGroupImageArray.count - 1 {
                if subGroupIndexGroupArray[i] == group {
                    newItem.image = subGroupImageArray[i]
                    newItem.name = subGroupNameArray[i]
                    newItem.indexGroup = subGroupIndexGroupArray[i]
                    newItem.indexSubGroup = subGroupIndexArray[i]
                    newArray.append(newItem)
                }
            }
            self.subGroupArray = newArray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subGroupCollectionView.delegate = self
        subGroupCollectionView.dataSource = self

    }
    
    func createRightItems() {
        let cardButtonNavigationItem = self.navigationItem.rightBarButtonItems?.first
        if Order.sharedInstance.sum == 0 {
           self.navigationItem.rightBarButtonItems = [cardButtonNavigationItem] as! [UIBarButtonItem]
        }
        else {
            // createLabel with total coast
            let cartButton = UIButton()
            cartButton.backgroundColor = .white
            cartButton.setTitleColor(.black, for: .normal)
            cartButton.layer.cornerRadius = 10
            cartButton.setTitle("\(Order.sharedInstance.sum) ₽", for: .normal)
            cartButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
            cartButton.sizeToFit()
            cartButton.frame = CGRect(x: 0, y: 0, width: cartButton.frame.width + 12, height: 20)
            
            let totalButtonNavigationItem = UIBarButtonItem(customView: cartButton)
            self.navigationItem.rightBarButtonItems = [cardButtonNavigationItem,totalButtonNavigationItem] as! [UIBarButtonItem]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let vc = ViewController()
        let titleArray = vc.groupArray.filter { $0.index == group }
        if !titleArray.isEmpty {
            let titleGroup = titleArray.first?.name?.lowercased()
            self.navigationItem.title = titleGroup?.firstUppercased
        }
        
        createRightItems()
    }
    // перехват segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifire {
            if let vc = segue.destination as? ProductViewController {
                let numberSubGroup = sender as? Int
                vc.subGroupIndex = subGroupArray[numberSubGroup!]
            }
        }
    }
}

extension SubGroupViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subGroupArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: subGroupIdentifire, for: indexPath) as? SubGroupCollectionViewCell {
            itemCell.subGroup = subGroupArray[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
    
    //нажатие на ячейку
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: segueIdentifire , sender: indexPath.row)
    }
    
    
}

extension String {
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}
