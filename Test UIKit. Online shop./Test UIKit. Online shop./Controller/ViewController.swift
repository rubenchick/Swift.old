//
//  ViewController.swift
//  Test UIKit. Online shop.
//
//  Created by Anton Rubenchik on 12.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var groupCollectionView: UICollectionView!
    let groupIdentifire = "groupCell"
    var groupArray : [Group] = {
        var newArray = [Group]()
        var newItem = Group()
        let groupNameArray : [String] = ["ОСНОВНОЕ МЕНЮ","МАКЗАВТРАК","НАПИТКИ","ДЕСЕРТЫ","ХЭППИ МИЛ","МАККАФЕ"]
        let groupImageArray : [String] = ["mainMenu","macBreakfast","drink","desert","happyMil","macCafe"]
        for i in 0...groupNameArray.count - 1 {
            newItem.image = groupImageArray[i]
            newItem.name = groupNameArray[i]
            newArray.append(newItem)
        }
        return newArray
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        groupCollectionView.dataSource = self
        groupCollectionView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = groupCollectionView.dequeueReusableCell(withReuseIdentifier: groupIdentifire, for: indexPath) as? MyCollectionViewCell {
            itemCell.group = groupArray[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
}

