//
//  ViewController.swift
//  Lesson 20.  PageViewController
//
//  Created by Anton Rubenchik on 16.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func pressButton(_ sender: Any) {
        let pageVC = PageViewController()
        self.navigationController?.pushViewController(pageVC, animated: true)
    }
    

}
