//
//  ViewController.swift
//  TestAplication
//
//  Created by Anton Rubenchik on 25.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ManualViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .done, target: self, action: #selector(pressExit))
    }
    @objc func pressExit() {
        let modulVC = ModulViewController()
        navigationController?.pushViewController(modulVC, animated: false)
        //Мой вариант решения
//      present(modulVC, animated: true, completion: nil)
        
    }
}


