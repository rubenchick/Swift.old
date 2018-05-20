//
//  MainViewController.swift
//  Lesson 11. UITabBarController and UITabBarItem
//
//  Created by Anton Rubenchik on 19.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var goToManualButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton()

        
    }

    
    @objc func pressNext() {
      //  goToManualButton.setTitleColor(UIColor.white, for: .normal)
        let viewController = ViewController()
        present(viewController, animated: true, completion: nil)
        
    }
    
    fileprivate func createButton() {
        
        goToManualButton.setTitle("Инструкция по сборке", for: .normal)
        goToManualButton.setTitleColor(UIColor.white, for: .normal)
        goToManualButton.frame = CGRect(x: view.frame.midX - 150, y: 500, width: 300, height: 44)
        goToManualButton.layer.cornerRadius = 15
        goToManualButton.backgroundColor = UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 1)
        goToManualButton.addTarget(self, action: #selector(pressNext), for: .touchUpInside)
        goToManualButton.addTarget(self, action: #selector(pressButton), for: .touchDown)
        view.addSubview(goToManualButton)
    }
    // Изврат
    @objc func pressButton() {
       goToManualButton.setTitleColor(UIColor.gray, for: .normal)
    }


}
