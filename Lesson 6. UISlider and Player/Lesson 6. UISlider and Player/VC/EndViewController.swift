//
//  EndViewController.swift
//  Lesson 6. UISlider and Player
//
//  Created by Anton Rubenchik on 15.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {
    var titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        titleLabel.text = "Player created"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: view.frame.midX - titleLabel.frame.width/2, y: 80, width: 100, height: 44)
        titleLabel.sizeToFit()
        view.addSubview(titleLabel)
    }
    

    

}
