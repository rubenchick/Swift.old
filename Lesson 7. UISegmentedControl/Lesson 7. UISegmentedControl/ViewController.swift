//
//  ViewController.swift
//  Lesson 7. UISegmentedControl
//
//  Created by Anton Rubenchik on 16.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var segmentedControl = UISegmentedControl()
    var relaxArray = ["Ocean","Lakes","Mountains","Party","Partner"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        segmentedControl = UISegmentedControl(items: relaxArray)
        segmentedControl.frame = CGRect(x: 30, y: 500, width: view.frame.width-60, height: 44)
        view.addSubview(segmentedControl)
        
        
    }



}

