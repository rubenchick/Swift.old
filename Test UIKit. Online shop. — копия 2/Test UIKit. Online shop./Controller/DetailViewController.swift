//
//  DetailViewController.swift
//  Test UIKit. Online shop.
//
//  Created by Anton Rubenchik on 13.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var product = Product()

    @IBOutlet weak var datailImageView: UIImageView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var datailTextView: UITextView!
    @IBOutlet weak var addCartButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        createStartElements()

    }
    override func viewWillAppear(_ animated: Bool) {
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
    
    func createStartElements() {
        
        self.view.backgroundColor = .white
        plusButton = createButton(sender: plusButton, cornerRadius: 10.0, sizeFont: 20)
        minusButton = createButton(sender: minusButton, cornerRadius: 10.0, sizeFont: 20)
        addCartButton = createButton(sender: addCartButton, cornerRadius: 15.0, sizeFont: 15)
        countLabel.text = "1"
        minusButton.setTitleColor(UIColor.gray, for: .normal)
        minusButton.layer.borderColor = UIColor.gray.cgColor

        
        // create Title
        let titleSubGroup = self.product.name?.lowercased()
        self.navigationItem.title = titleSubGroup?.firstUppercased
        // create Image
        
        if let newImage = product.image {
            datailImageView.image = UIImage(named: newImage)
        }
        
        // create addCartButton
        let addCartTextButton = "ДОБАВИТЬ В КОРЗИНУ           \(product.price!) ₽ ➜"
        addCartButton.setTitle(addCartTextButton, for: .normal)
        
        //create textView
        switch product.index! {
        case 0...21 : datailTextView.text = "Большой сандвич с двумя рубленными бифштексами из натуральной цельной говядины на специальной булочке, заправленной луком, двумя кусочками  маринованных огурчиков, ламтиком сыра 'Чеддер', свежим салатом, и специальным соусом 'Биг Мак'.\n\nКилокалорий (Ккал):    503\nБелки (г):                         26\nУглеводы (г):                   42\nЖиры (г):                         25 "
        case 22...23 : datailTextView.text = "Вкусные, обжаренные в растительном фритюре ломтики картофеля со специями.\n\nКилокалорий (Ккал):   321\nБелки (г):                      4,5\nУглеводы (г):                 41\nЖиры (г):                       14 "
        case 24...31 : datailTextView.text = "Кофе эспрессо с большим количеством горячего вспененного молока.\n\nКилокалорий (Ккал):    132\nБелки (г):                          6\nУглеводы (г):                   10\nЖиры (г):                          8 "
        default:
            break
        }
    }
    
    func createButton(sender: UIButton, cornerRadius : CGFloat, sizeFont: CGFloat) -> UIButton {
        let newButton = sender
        newButton.layer.cornerRadius = cornerRadius
        newButton.backgroundColor = .clear
        newButton.setTitleColor(UIColor(red: 176/255, green: 40/255, blue: 30/255, alpha: 1), for: .normal)
        newButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: sizeFont)
        newButton.layer.borderWidth = 3
        newButton.layer.borderColor = UIColor(red: 176/255, green: 40/255, blue: 30/255, alpha: 1).cgColor
        return newButton
    }
    @IBAction func plusButton(_ sender: Any) {
        if let count = Int(countLabel.text!) {
            countLabel.text = String(count+1)
            let addCartTextButton = "ДОБАВИТЬ В КОРЗИНУ                \(product.price! * Int(countLabel.text!)!) ₽ ➜"
            addCartButton.setTitle(addCartTextButton, for: .normal)
            minusButton.setTitleColor(UIColor(red: 176/255, green: 40/255, blue: 30/255, alpha: 1), for: .normal)
            minusButton.layer.borderColor = UIColor(red: 176/255, green: 40/255, blue: 30/255, alpha: 1).cgColor
        }
    }
    
    @IBAction func minusButton(_ sender: Any) {
        if countLabel.text == "2" {
            countLabel.text = "1"
            minusButton.setTitleColor(UIColor.gray, for: .normal)
            minusButton.layer.borderColor = UIColor.gray.cgColor
            let addCartTextButton = "ДОБАВИТЬ В КОРЗИНУ           \(product.price! * Int(countLabel.text!)!) ₽ ➜"
            addCartButton.setTitle(addCartTextButton, for: .normal)
        }
        else {
            if countLabel.text != "1" {
                if let count = Int(countLabel.text!) {
                    countLabel.text = String(count - 1)
                    let addCartTextButton = "ДОБАВИТЬ В КОРЗИНУ           \(product.price! * Int(countLabel.text!)!) ₽ ➜"
                    addCartButton.setTitle(addCartTextButton, for: .normal)
                }
            }
        }
        
    }
    
    @IBAction func addCartButton(_ sender: Any) {
        if let newCount = Int(countLabel.text!) {
            var newItem = Cart()
            newItem.name = product.name
            newItem.price = product.price
            newItem.count = newCount
            newItem.image = product.image
            cartArray.append(newItem)
//            Memory.sharedInstance.number = 4
            Order.sharedInstance.sum += newItem.price! * newItem.count!
        }
//        print(cartArray)
        print("Sum - \(Order.sharedInstance.sum)")
        self.navigationController?.popViewController(animated: true)
    }
}
