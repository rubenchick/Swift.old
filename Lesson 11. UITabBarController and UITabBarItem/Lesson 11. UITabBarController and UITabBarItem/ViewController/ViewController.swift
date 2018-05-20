//
//  ViewController.swift
//  Lesson 11. UITabBarController and UITabBarItem
//
//  Created by Anton Rubenchik on 18.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // var navigation
    override func viewDidLoad() {
        super.viewDidLoad()
        let manualViewController = ManualViewController()
        let helpViewController = HelpViewController()
        let manualNavigationController = UINavigationController(rootViewController: manualViewController)
        let helpNavigationController = UINavigationController(rootViewController: helpViewController)
        let tabBarViewController = UITabBarController()
        tabBarViewController.setViewControllers([manualNavigationController,helpNavigationController], animated: false)
        self.
       // present(tabBarViewController, animated: true, completion: nil)
        
        
        
        
        
        
        
//   //     self.title = "Кубик Рубик"
//        let imageView = UIImageView()
//        imageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
//        imageView.contentMode = .scaleAspectFit
//        let image = UIImage(named: "rubik_small")
//        imageView.image = image
//        self.navigationItem.titleView = imageView
//
//        //Create Rigth Button
////        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Инструкция", style: .done, target: self, action: #selector(pressManual))
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(pressManual))
        
    }
    
    @objc func pressManual() {
    // Create TabBarItem
//        var manualViewController = ManualViewController()
//        var helpViewController = HelpViewController()
//        
//        manualViewController.title = "Инструкция"
//        helpViewController.title = "Помощь"
//        var tabBarViewControllrer = UITabBarController()
//        var tabBarItem1 = UITabBarItem()
//        tabBarItem1 = UITabBarItem(tabBarSystemItem: .history, tag: 0)
//        self.tabBarItem = tabBarItem1
////        tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
////        self.tabBarItem = tabBarItem
//        tabBarViewControllrer.setViewControllers([manualViewController,helpViewController], animated: true)
//        navigationController?.pushViewController(tabBarViewControllrer, animated: true)
     //   navigationController?.pushViewController(manualViewController, animated: true)


    }
}

