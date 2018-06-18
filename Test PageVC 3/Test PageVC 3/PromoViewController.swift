//
//  PromoViewController.swift
//  Test PageVC 3
//
//  Created by Anton Rubenchik on 16.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class PromoViewController: UIViewController {

    var imageView : UIImageView = {
        var newImage = UIImageView()
        newImage.layer.cornerRadius = 20
        newImage.layer.masksToBounds = true //?
        newImage.contentMode = .scaleAspectFit
        newImage.translatesAutoresizingMaskIntoConstraints = false
        return newImage
    }()
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        edgesForExtendedLayout = []
        imageView.image = image
        
        self.view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300),
            NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200),
            NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: -150)
            ])
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
