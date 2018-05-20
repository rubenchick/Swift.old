//
//  ManualViewController.swift
//  Lesson 11. UITabBarController and UITabBarItem
//
//  Created by Anton Rubenchik on 18.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ManualViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "rubik_small")
        imageView.image = image
        self.navigationItem.titleView = imageView
        
        // Do any additional setup after loading the view.
    }

}
