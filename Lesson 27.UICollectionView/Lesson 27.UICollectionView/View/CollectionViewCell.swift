//
//  CollectionViewCell.swift
//  Lesson 27.UICollectionView
//
//  Created by Anton Rubenchik on 11.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productLabel: UILabel!

    var product: Product? {
        didSet {
            productLabel.text = product?.name
            if let image = product?.imageName {
                productImageView.image = UIImage(named: image)
            }
        }
    }

}
