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
    let segueIdentifire = "showSubVC"
    var groupArray : [Group] = {
        var newArray = [Group]()
        var newItem = Group()
        let groupNameArray : [String] = ["ОСНОВНОЕ МЕНЮ","МАКЗАВТРАК","НАПИТКИ","ДЕСЕРТЫ","ХЭППИ МИЛ","МАККАФЕ"]
        let groupImageArray : [String] = ["mainMenu2","macBreakfast2","drink2","desert2","happyMil2","macCafe2"]
        let groupIndexArray : [Int] = [1,2,3,4,5,6]
        for i in 0...groupNameArray.count - 1 {
            newItem.image = groupImageArray[i]
            newItem.name = groupNameArray[i]
            newItem.index = groupIndexArray[i]
            newArray.append(newItem)
        }
        return newArray
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        groupCollectionView.dataSource = self
        groupCollectionView.delegate = self
        
        // add image on titleview
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "macLogoSmall")
        imageView.image = image
        self.navigationItem.titleView = imageView
        
        // delete text in left button
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        createRightItems()
    }
    //отловили переход по seque
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifire  {
            if let vc = segue.destination as? SubGroupViewController {
                if let numberSubGroup = sender as? Int {
                    vc.group = groupArray[numberSubGroup].index
                }
            }
        }
    }
    
    func createRightItems() {
        let cardButtonNavigationItem = self.navigationItem.rightBarButtonItems?.first
        if Order.sharedInstance.sum == 0 {
            self.navigationItem.rightBarButtonItems = [cardButtonNavigationItem] as? [UIBarButtonItem]
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
            self.navigationItem.rightBarButtonItems = [cardButtonNavigationItem,totalButtonNavigationItem] as? [UIBarButtonItem]
        }
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
    
    //отловили нажатие на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: segueIdentifire , sender: indexPath.row)
    }
}

