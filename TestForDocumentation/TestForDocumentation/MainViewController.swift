//
//  MainViewController.swift
//  TestForDocumentation
//
//  Created by Anton Rubenchik on 18.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var goToManualButton = UIButton()
    var startPosition : CGRect? = nil
    var image = UIImage()
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createStartElement()

    }

    @objc func pressNext() {
        step = 0
        self.tabBarController?.tabBar.bounds = startPosition!
        navigationController?.popViewController(animated: true)
        navigationItem.hidesBackButton = false
    }

    fileprivate func createStartElement() {
        //create Button
        goToManualButton.setTitle("Инструкция по сборке", for: .normal)
        goToManualButton.setTitleColor(UIColor.white, for: .normal)
        goToManualButton.setTitleColor(UIColor.lightGray, for: .highlighted)

        goToManualButton.frame = CGRect(x: view.frame.midX - 150, y: 620, width: 300, height: 44)
        goToManualButton.layer.cornerRadius = 15
        
        // greate color
        goToManualButton.backgroundColor = UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 1)
       
        goToManualButton.layer.shadowOpacity = 0.6
        goToManualButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        goToManualButton.layer.shadowRadius = 2
        
        goToManualButton.addTarget(self, action: #selector(pressNext), for: .touchUpInside)
        view.addSubview(goToManualButton)
        
        // create Image
        image = UIImage(named: "rubik_big")!
        imageView.image = image
        imageView.frame = CGRect(x: view.frame.midX - 128, y: view.frame.midY - 128, width: 256, height: 256)
        view.addSubview(imageView)
   
        //hide tabBar
        startPosition = self.tabBarController?.tabBar.bounds
        self.tabBarController?.tabBar.bounds = CGRect(x: 1000, y: 100, width: 50, height: 50)
        
        //create Title
        title = "Кубик Рубик"
        navigationItem.hidesBackButton = true
    }
}
