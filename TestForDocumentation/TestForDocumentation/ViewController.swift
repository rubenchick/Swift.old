//
//  ViewController.swift
//  TestForDocumentation
//
//  Created by Anton Rubenchik on 16.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var nextButton = UIButton()
    
    var navigationBar : UINavigationBar?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "First"
        navigationBar = navigationController?.navigationBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(pressNext))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(pressPrev))

        
        
    }
    @objc func pressNext() {
//        let secondViewController = SecondViewController()
////        navigationController?.pushViewController(secondViewController, animated: true)
        navigationBar?.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationBar?.shadowImage = UIImage()
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        self.perform(#selector(goBack), with: nil, afterDelay: 3.0)
    }
    
    @objc func pressPrev() {
//        navigationBar?.isTranslucent = false
//        navigationBar?.barStyle = .default
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        
        
        navigationBar?.setBackgroundImage(nil, for: UIBarMetrics.default)
        navigationBar?.shadowImage = nil
        navigationBar?.tintColor = nil
        navigationBar?.isTranslucent = false
    }
    
    @objc func goBack(){
        // правильная запись
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

}



