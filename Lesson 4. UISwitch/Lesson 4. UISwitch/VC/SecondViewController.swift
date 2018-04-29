//
//  SecondViewController.swift
//  Lesson 4. UISwitch
//
//  Created by Anton Rubenchik on 26.04.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var mySwitch = [UISwitch()]
    var businessLabel = [UILabel()]
    var business : [(String,Int)] = []
    var isSwitch : [Bool] = [] // в идеале нужно эти данные перенести в массив business
    let tempButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.setNavigationBar()
        self.setInformational()
        self.setLabelAndButton()
        self.tempButton.addTarget(self, action: #selector(pressButton), for: .touchDown)
    }
    
    func setLabelAndButton(){
        // Label
        let tempLabel =  UILabel()
        tempLabel.frame = CGRect(x: 300, y: 64  , width: 300, height: 44)
        tempLabel.font = UIFont.boldSystemFont(ofSize: 20)
        tempLabel.text =  "Done"
        self.view.addSubview(tempLabel)
        
        //Button
        self.tempButton.frame = CGRect(x: self.view.frame.midX-50  , y: self.view.frame.maxY-100, width: 100, height: 50)
        self.tempButton.backgroundColor = UIColor(red: 60/255, green: 137/255, blue: 183/255, alpha: 1)
        self.tempButton.layer.cornerRadius = 13
        self.tempButton.setTitle("New day", for: .normal)
        self.view.addSubview(tempButton)
    }
    
    @objc func pressButton(){
        for i in 0...isSwitch.count-1 {
            mySwitch[i].isOn = false
            isSwitch[i] = false
        }
    }
    
    // create Navigation Bar
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: screenSize.width, height: 44))
        let navigationItem = UINavigationItem(title: "Business for a day")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .undo, target: nil, action: #selector(pressUndo))
        navigationBar.setItems([navigationItem], animated: true)
        self.view.addSubview(navigationBar)
    }
    
    func setInformational(){
        var t : String
        var i : Int
        (t,i) = business[1]
        var j = 0
        while j < business.count {
            (t,i) = business[j]
            var k = i
            while k != 0 {
                if i != 1 { printNewBusiness(newBusiness: t + " (" + String(i-k+1) + " times)") }
                else{
                    printNewBusiness(newBusiness: t)
                }
                k -= 1
            }
            j += 1
        }
    }
    
    func printNewBusiness(newBusiness: String) {
        let tempSwitch =  UISwitch()
        let tempLabel =  UILabel()
        
        self.mySwitch.append(tempSwitch)
        self.businessLabel.append(tempLabel)

        let number = businessLabel.count-1

            
        mySwitch[number].frame = CGRect(x: 300, y: ( 70 + (number * 44)) , width: 0, height: 0)
        businessLabel[number].frame = CGRect(x: 20, y: ( 64 + (number * 44)) , width: 300, height: 44)
        businessLabel[number].text = newBusiness
        // Проверяем было ли данной действие до этого, или новое
        if number < isSwitch.count {
            if isSwitch[number] {
                    mySwitch[number].isOn = true
            }
        }
        else {
            isSwitch.append(false)
        }
        
        
        self.view.addSubview(businessLabel[number])
        self.view.addSubview(mySwitch[number])
    }

    @objc func pressUndo() {
        for i in 0...(mySwitch.count - 1) {
            if mySwitch[i].isOn {
                isSwitch[i] = true
            }
        }
        
        let viewController : ViewController = ViewController()
        viewController.isSwitch = self.isSwitch
        viewController.business = self.business
        present(viewController, animated: false)  {
            viewController.view.backgroundColor = UIColor.white
        }
    }

}
