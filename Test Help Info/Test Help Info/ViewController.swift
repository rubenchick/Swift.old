//
//  ViewController.swift
//  Test Help Info
//
//  Created by Anton Rubenchik on 08/01/2019.
//  Copyright © 2019 Anton Rubenchik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
//        label.text = "From code"
        label.text = NSLocalizedString("Text from code", comment: "")
    }
    


}

