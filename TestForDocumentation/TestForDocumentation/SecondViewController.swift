//
//  SecondViewController.swift
//  TestForDocumentation
//
//  Created by Anton Rubenchik on 18.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var navigationBar: UINavigationBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Second"
        
        navigationBar = navigationController?.navigationBar
        navigationBar?.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationBar?.shadowImage = UIImage()
        navigationBar?.setBackgroundImage(UIImage(), for: .default)

        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressNext))

    }

    @objc func pressNext() {
        navigationController?.popViewController(animated: true)
        
    }

}
