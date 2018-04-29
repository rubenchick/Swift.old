//
//  NormalYearViewController.swift
//  Lesson 5. Picker
//
//  Created by Anton Rubenchik on 28.04.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class NormalYearViewController: UIViewController {
    var label = UILabel()
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        label.frame = CGRect(x: 0, y: 0, width: 140, height: 44)
        label.center = view.center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        self.view.addSubview(label)
        
        
        button.frame = CGRect(x: view.frame.midX-100, y: view.frame.maxY - 200, width: 200, height: 44)
        button.backgroundColor = UIColor(red: 60/255, green: 137/255, blue: 183/255, alpha: 1)
        button.layer.cornerRadius = 15
        button.setTitle("Back", for: .normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(pressBack), for: .touchDown)
        
        
    }
    @objc func pressBack(){
        let vc = ViewController()
        vc.view.backgroundColor = UIColor.white
        present(vc, animated: false, completion: nil)
    }
}
