//
//  ProductCollectionViewCell.swift
//  Test UIKit. Online shop.
//
//  Created by Anton Rubenchik on 13.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    
    var product: Product? {
        didSet{
            productLabel.text = product?.name
            if let image = product?.image {
                productImage.image = UIImage(named: image)
            }
        }
    }
}


    
