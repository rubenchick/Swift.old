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
    var relaxArray = ["Ocean","Snowboard","Mountains","Party","Partner"]
    
    var imageArray = [UIImage(named: "Ocean.png"),
                      UIImage(named: "Snowboard.png"),
                      UIImage(named: "Mountains.png"),
                      UIImage(named: "Party.png"),
                      UIImage(named: "Partner.png")]
    var imageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        segmentedControl = UISegmentedControl(items: relaxArray)
        segmentedControl.frame = CGRect(x: 20, y: 550, width: view.frame.width-40, height: 44)
        view.addSubview(segmentedControl)

        imageView.frame = CGRect(x: 0, y: 0, width: 380, height: 300)
        imageView.center = view.center
        imageView.image = imageArray[0]
        view.addSubview(imageView)
        
        segmentedControl.addTarget(self, action: #selector(chooseNewRelax), for: .valueChanged)
        
    }
    
    
    @objc func chooseNewRelax(target: UISegmentedControl) {
        if target == self.segmentedControl {
            //let segmentIndex = target.selectedSegmentIndex
            imageView.image = imageArray[segmentedControl.selectedSegmentIndex]
        }
    }



}



