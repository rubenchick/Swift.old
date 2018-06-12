//
//  MyCollectionViewCell.swift
//  Test UIKit. Online shop.
//
//  Created by Anton Rubenchik on 12.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var groupLabel: UILabel!
    
    var group: Group?  {
        didSet {
            groupLabel.text = group?.name
            if let newImage = group?.image {
                groupImageView.image = UIImage(named: newImage)
            }
        }
    }
}
