//
//  SubGroupCollectionViewCell.swift
//  Test UIKit. Online shop.
//
//  Created by Anton Rubenchik on 12.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class SubGroupCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var subGroupImage: UIImageView!
    @IBOutlet weak var subGroupName: UILabel!
    
    var subGroup: SubGroup? {
        didSet{
            subGroupName.text = subGroup?.name
            if let newImage = subGroup?.image {
                subGroupImage.image = UIImage(named: newImage)
            }
        }
    }
    
}
