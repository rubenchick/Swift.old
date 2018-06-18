//
//  ProductViewController.swift
//  Test UIKit. Online shop.
//
//  Created by Anton Rubenchik on 13.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var productCollectionCell: UICollectionView!
    
    let productIdentifire = "productCell"
    let segueIdentifire = "showDetail"
    var productArray = [Product]()
    
    var subGroupIndex : SubGroup? {
        didSet{
            var newArray = [Product]()
            var newItem = Product()
            // массивы данных
            let productNameArray = ["ЧИКЕН ГУРМЕ ЭКЗОТИК","ГУРМЕ ГРИЛЬ","ГУРМЕ ВЕСТЕРН",
                                    "БИГ МАК","БИГ ТЕСТИ","ЧИЗБУРГЕР ДЕ ЛЮКС","ГРАНД ЧИЗБУРГЕР","ДВОЙНОЙ ЧИЗБУРГЕР","ЧИЗБУРГЕР","ГАМБУРГЕР",
                                     "МАКЧИКЕН","ЧИКЕН ГУРМЭ","ЦЕЗАРЬ РОЛЛ","ЧИКЕН МАКНАГГЕТС","КУРИНЫЕ КРЫЛЫШКИ","ЧИКЕНБУРГЕР",
                                     "БОЛЬШИЕ КРЕВЕТКИ","ШРИМП РОЛЛ","ДВОЙНОЙ ФИЛЕ-О-ФИШ","ФИШ РОЛЛ","ФИЛЕ-О-ФИШ",
                                     "КАРТОФЕЛЬ ФРИ","ПО-ДЕРЕВЕНСКИ",
                                     "КОФЕ","КОФЕ ЛАТТЕ","ДВОЙНОЙ ЭКСПРЕССО","КАПУЧИНО","КОФЕ ГЛЯССЕ","ЧАЙ ЧЕРНЫЙ","ЧАЙ ЭРЛ ГРЕЙ","ЧАЙ ЗЕЛЕНЫЙ"]
            let productImageArray = ["1_1_1","1_1_2","1_1_3",
                                     "1_2_1","1_2_2","1_2_3","1_2_4","1_2_5","1_2_6","1_2_7",
                                     "1_3_1","1_3_2","1_3_3","1_3_4","1_3_5","1_3_6",
                                     "1_4_1","1_4_2","1_4_3","1_4_4","1_4_5",
                                      "1_7_1","1_7_2",
                                      "3_3_1","3_3_2","3_3_3","3_3_4","3_3_5","3_3_6","3_3_7","3_3_8"]
            let productIndexArray = [1,2,3,
                                     4,5,6,7,8,9,10,
                                     11,12,13,14,15,16,
                                     17,18,19,20,21,
                                     22,23,
                                     24,25,26,27,28,29,30,31]
            let productIndexSubGroupArray = [1,1,1,
                                             2,2,2,2,2,2,2,
                                             3,3,3,3,3,3,
                                             4,4,4,4,4,
                                             7,7,
                                             18,18,18,18,18,18,18,18]
            let productPriceArray = [231,219,253,
                                     130,180,180,201,115,60,50,
                                     92,212,180,152,156,60,
                                     115,130,125,170,160,
                                     82,65,
                                     49,99,79,99,119,49,49,49]
          
            // засовываем в массив
            for i in 0...productImageArray.count - 1 {
                if productIndexSubGroupArray[i] == subGroupIndex?.indexSubGroup {
                    newItem.image = productImageArray[i]
                    newItem.name = productNameArray[i]
                    newItem.index = productIndexArray[i]
                    newItem.indexSubGroup = productIndexSubGroupArray[i]
                    newItem.price = productPriceArray[i]
                    newArray.append(newItem)
                }
            }
            self.productArray = newArray
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productCollectionCell.dataSource = self
        productCollectionCell.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

   }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let titleSubGroup = self.subGroupIndex?.name?.lowercased()
        self.navigationItem.title = titleSubGroup?.firstUppercased
//        print(Memory.sharedInstance.number)
        createRightItems()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifire {
            if let vc = segue.destination as? DetailViewController {
                if let product = sender as? Product {
                    vc.product = product
                }
            }
            
        }
    }
}
extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: productIdentifire, for: indexPath) as? ProductCollectionViewCell {
            productCell.product = productArray[indexPath.row]
            return productCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = productArray[indexPath.row]
        self.performSegue(withIdentifier: segueIdentifire, sender: product)
    }
    
    
}


