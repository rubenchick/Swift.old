//
//  ViewController.swift
//  TestPageController
//
//  Created by Anton Rubenchik on 15.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class PromoViewController: UIViewController {
    var mainLabel : UILabel = {
        var newLabel = UILabel()
        newLabel.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        newLabel.textColor = .red
        newLabel.font = UIFont.boldSystemFont(ofSize: 28)
        return newLabel
    }()
    
    init(label:String) {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
        edgesForExtendedLayout = []
        mainLabel.text = label
        self.view.addSubview(mainLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}

