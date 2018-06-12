//
//  ViewController.swift
//  Lesson 27.UICollectionView
//
//  Created by Anton Rubenchik on 11.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var itemProductArray : [Product] = {
        var tempArray : [Product] = []
        for i in 0...10 {
            var firstProduct  = Product()
            firstProduct.name = "Coca-cola"
            firstProduct.imageName = "cola"
            var secondProduct  = Product()
            secondProduct.name = "Burger"
            secondProduct.imageName = "hamburger"
            tempArray.append(firstProduct)
            tempArray.append(secondProduct)
        }
        return tempArray
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    // ловим переход по сигвею
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDatailVC" {
            if let vc = segue.destination as? DetailViewController {
                let product = sender as? Product
                vc.product = product
            }
        }
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // count item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemProductArray.count
    }
    
    // как будет выглядить ячейка, какие данные передадим
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? CollectionViewCell {
            
            // передача данных из модели в ячейку
            itemCell.product = itemProductArray[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
    
    // метод срабатывает, когда нажимаем на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = itemProductArray[indexPath.row]
        // переходим на следующий контроллер
        self.performSegue(withIdentifier: "showDatailVC", sender: product)
        
    }
    
}
