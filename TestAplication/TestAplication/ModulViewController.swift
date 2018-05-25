//
//  ModulViewController.swift
//  TestAplication
//
//  Created by Anton Rubenchik on 25.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ModulViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        
        let myButton = UIButton(type: .detailDisclosure)
        myButton.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        myButton.center = view.center
        view.addSubview(myButton)
        myButton.addTarget(self, action: #selector(pressReturn), for: .touchUpInside)
        
        self.navigationItem.hidesBackButton = true
    }
    @objc func pressReturn() {
        navigationController?.popViewController(animated: true)
        
        //Мой вариант решения
//        self.dismiss(animated: false, completion: nil)
        
    }



}
