//
//  ViewController.swift
//  Lesson 9. UINavigationController
//
//  Created by Anton Rubenchik on 17.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var button = UIButton()
    var navigationBar = UINavigationBar()
    var lastContentOffset: CGFloat = 0.0
    var startingTouchLocation: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createTitleNavigationBar()
        // Create Visiable NavigationBar
        navigationBar = (navigationController?.navigationBar)!
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .default
    
        createButtonsOnNavigationBar()
        
        // Trening different method
        // createButton()
        // createSwitchOnNavigationBar()
        // createTitle()
        // createButtonOnNavigationBar()
        // createSigmenedControllerOnNavigationBar()
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {

            if Float(touch.location(in: view).y) < Float(touch.previousLocation(in: view).y) {
                navigationBar.isTranslucent = true
                navigationBar.setBackgroundImage(UIImage(), for: .default)
                navigationBar.shadowImage = UIImage()
            }
            else {
                navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
                navigationBar.shadowImage = nil
                navigationBar.tintColor = nil
                navigationBar.isTranslucent = false
                
            }
        }
    }
    
//    Код для светлого текста в статус баре не работает без добавления строчки в plist.info.
//    Этой строки нет её надо именно добавить с помощью плюсика. View controller-based status bar appearance = NO.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    // MARK: - Method

    fileprivate func createTitleNavigationBar() {
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        
        let nameLabel = UILabel()
        nameLabel.text = "The Swift Developers"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.sizeToFit()
        nameLabel.frame = CGRect(x: 100 - (nameLabel.frame.width/2), y: 2, width: 50, height: 24)
        nameLabel.sizeToFit()
        nameLabel.textColor = UIColor.white
        
        let statusLabel = UILabel()
        statusLabel.text = "500 members"
        statusLabel.font = UIFont.boldSystemFont(ofSize: 12)
        statusLabel.sizeToFit()
        statusLabel.frame = CGRect(x: 100 - (statusLabel.frame.width/2), y: 25, width: 50, height: 24)
        statusLabel.sizeToFit()
        statusLabel.textColor = UIColor(red:   137/255, green: 153/255, blue:  162/255, alpha: 1)
        titleView.addSubview(nameLabel)
        titleView.addSubview(statusLabel)
        navigationItem.titleView = titleView
    }
    
    fileprivate func createButtonsOnNavigationBar() {
        let rightButton = UIButton()
        if let imageRigthButton = UIImage(named: "logo4.png") {
            rightButton.setImage(imageRigthButton, for: .normal)
        }
        //     rightButton.backgroundColor = UIColor.blue
        rightButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        rightButton.layer.cornerRadius = 20
        rightButton.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        
        let testButton = UIButton(type: .system)
        testButton.setImage(#imageLiteral(resourceName: "apple_blue"), for: .normal)
        testButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: testButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    
    @objc func chooseSegmentedControl(param: UISegmentedControl) {
        if param.selectedSegmentIndex == 0 {
            print("Yes")
        }
        else {
            print("No")
        }
        
    }
    @objc func changedSwitch(param: UISwitch) {
        if param.isOn {
            print("Yes")
        }
        else {
            print("No")
        }
    }
    
    @objc func pressButton(){
        let secondViewController = SecondViewController()
        navigationController?.pushViewController(secondViewController, animated: false)

//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
        
    }
    
    fileprivate func createTitle() {
        // Do any additional setup after loading the view, typically from a nib.
        //self.title = "First VC"
        
        // картинка вместо текста
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        imageView.contentMode = .scaleAspectFit // не растягивать - истинный размер
        let image = UIImage(named: "apple")
        imageView.image = image
        self.navigationItem.titleView = imageView
    }
    
    fileprivate func createButton() {
        button = UIButton(type: .system)
        button.setTitle("Go to Next", for: .normal)
        button.sizeToFit()
        button.center = self.view.center
        self.view.addSubview(button)
        self.button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
    }
    
    fileprivate func createButtonOnNavigationBar() {
        
        // добавляем в navigationbar кнопку
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(pressButton))
    }
    
    fileprivate func createSwitchOnNavigationBar() {
        // switch in NavigationBar
        let navigationSwitch = UISwitch()
        navigationSwitch.isOn = true
        navigationSwitch.addTarget(self, action: #selector(changedSwitch(param: )), for: .valueChanged)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationSwitch)
    }
    
    fileprivate func createSigmenedControllerOnNavigationBar() {
        //  title = "First"
        //navigationItem.back
        
        let items = ["up","stop","down"]
        let segmentedController = UISegmentedControl(items: items)
        segmentedController.isMomentary = true
        segmentedController.addTarget(self, action: #selector(chooseSegmentedControl(param:)), for: .valueChanged)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: segmentedController)
    }


}

