//
//  PromoViewController.swift
//  Test 4 PageVC
//
//  Created by Anton Rubenchik on 16.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class PromoViewController: UIViewController {

    private let promoImage: UIImageView = {
        let newImage = UIImageView()
        newImage.layer.cornerRadius = 20
        newImage.layer.masksToBounds = true
        newImage.translatesAutoresizingMaskIntoConstraints = false
        return newImage
    }()
    
//    lazy var subView: [UIView] = [self.promoImage]
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        edgesForExtendedLayout = []
        promoImage.image = image
        view.backgroundColor = .blue
        view.addSubview(promoImage)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: promoImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250),
            NSLayoutConstraint(item: promoImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250),
            NSLayoutConstraint(item: promoImage, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 150),
            NSLayoutConstraint(item: promoImage, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
