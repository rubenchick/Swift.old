//
//  DetailViewController.swift
//  Lesson 27.UICollectionView
//
//  Created by Anton Rubenchik on 12.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var datailImageView: UIImageView! {
        didSet {
            guard let image = product?.imageName else { return }
            datailImageView.image = UIImage(named: image)
        }
    }
    
    @IBOutlet weak var datailLabel: UILabel! {
        didSet{
            datailLabel.text = product?.name
        }
    }
    var product: Product?
    override func viewDidLoad() {
        super.viewDidLoad()
    }




}
