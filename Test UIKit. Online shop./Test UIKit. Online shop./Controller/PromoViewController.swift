//
//  PromoViewController.swift
//  Test UIKit. Online shop.
//
//  Created by Anton Rubenchik on 17.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class PromoViewController: UIViewController {

    let promoImageView : UIImageView = {
        let newImageview = UIImageView()
        newImageview.layer.masksToBounds = true
        newImageview.contentMode = .scaleAspectFit
        newImageview.translatesAutoresizingMaskIntoConstraints = false
        return newImageview
    }()

    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        edgesForExtendedLayout = []
        promoImageView.image = image
        view.addSubview(promoImageView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: promoImageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: promoImageView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: promoImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 35),
            NSLayoutConstraint(item: promoImageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
            ])
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
