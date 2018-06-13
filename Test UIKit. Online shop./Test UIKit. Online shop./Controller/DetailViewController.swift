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
            let addCartTextButton = "ДОБАВИТЬ В КОРЗИНУ           \(product.price! * Int(countLabel.text!)!) ₽ ➜"
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
    }
}
