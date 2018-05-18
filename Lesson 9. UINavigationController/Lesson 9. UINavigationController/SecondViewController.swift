//
//  SecondViewController.swift
//  Lesson 9. UINavigationController
//
//  Created by Anton Rubenchik on 17.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var navigationBar: UINavigationBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Second"
        // If need Hide NavigationBar
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Create unVisiable NavigationBar
        navigationBar = navigationController?.navigationBar
        navigationBar?.isTranslucent = true
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
        navigationBar?.shadowImage = UIImage()

    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationBar?.setBackgroundImage(nil, for: UIBarMetrics.default)
        navigationBar?.shadowImage = nil
        navigationBar?.tintColor = nil
        navigationBar?.isTranslucent = false
    }

    // вызывается после создания
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false) // срабатывает родительский, а потом то что мы дописали
        self.perform(#selector(goBack), with: nil, afterDelay: 3.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    @objc func goBack(){
        // правильная запись
        //self.navigationController?.popViewController(animated: false) // убираем последний экран из стека
        
        // расписанная записть
        var viewControllerArray = self.navigationController?.viewControllers // массив контроллеров
        viewControllerArray?.removeLast()
        
        // Защита от ошибки
        if let newController = viewControllerArray {
            self.navigationController?.viewControllers = newController
        }
        
        
    }

}
