//
//  ViewController.swift
//  Lesson 4. UISwitch
//
//  Created by Anton Rubenchik on 25.04.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Additional object
    var businessLabel = [UILabel()]
    var timesLabel = [UILabel()]
    var isSwitch : [Bool] = []
    // список дел
    var business : [(String,Int)] = [("Morning gym 15 min",1),("Learning English words",1),("Take vitamins",2),("Read with daughter",1)]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        printInterface()
    }

    func printInterface(){
        var t : String
        var i : Int
        for item in business {
            (t,i) = item
            addNewBusiness(newBusiness: t,times: i,isNew: false)
        }
    }
    //MARK: Additional new Business in array and print it
    func addNewBusiness(newBusiness: String,times: Int, isNew: Bool){
        
        if isNew  { business.append((newBusiness,times)) }
        let tempLabel = UILabel()
        let tempLabel2 = UILabel()
        
        businessLabel.append(tempLabel)
        timesLabel.append(tempLabel2)
        
        let number = businessLabel.count-1
        
        businessLabel[number].frame = CGRect(x: 20, y: ( 34 + (number * 44)) , width: 300, height: 44)
        timesLabel[number].frame = CGRect(x: 300, y: ( 34 + (number * 44)) , width: 80, height: 44)
        
        businessLabel[number].text = newBusiness
        timesLabel[number].text = String(times) + " times"
        
        self.view.addSubview(businessLabel[number])
        self.view.addSubview(timesLabel[number])
    }
    
    // create Navigation Bar
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: screenSize.width, height: 44))
        let navigationItem = UINavigationItem(title: "Setting")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(pressDone))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: #selector(alertMessage))
        navigationBar.setItems([navigationItem], animated: true)
        self.view.addSubview(navigationBar)
    }
    
    // go to next page
    @objc func pressDone() {
        let secondViewController : SecondViewController = SecondViewController()
        secondViewController.business = self.business
        secondViewController.isSwitch = self.isSwitch
        present(secondViewController, animated: false, completion: nil)
        
    }
  
 
    @objc func alertMessage(){
        var newBusiness = ""
        //create controller
        let alertController = UIAlertController(title: "Additional", message: "Type new business", preferredStyle: .alert)
        
        // create button
        let buttonForMessageFirst = UIAlertAction(title: "Save", style: .default) { (text) in
            if let text = alertController.textFields?.first?.text {
                if text != "" {
                    // repeat for second question
                    newBusiness = text
                    let alertController = UIAlertController(title: "Additional", message: "How many times?", preferredStyle: .alert)
                    
                    let buttonForMessageFirst = UIAlertAction(title: "Save", style: .default) { (text) in
                        if let text = alertController.textFields?.first?.text {
                            if (text != "") && (text != "0") {
                                self.addNewBusiness(newBusiness: newBusiness, times: Int(text)!,isNew: true)
                            }
                        }
                    }
                    
                    let buttonForMessageSecond = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    
                    // add textField
                    alertController.addTextField { (textField) in
                        textField.placeholder = "1"
                        textField.keyboardType = .numberPad
                    }
                    
                    // add button
                    alertController.addAction(buttonForMessageFirst)
                    alertController.addAction(buttonForMessageSecond)
                    
                    //start controller
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        let buttonForMessageSecond = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // add textField
        alertController.addTextField { (textField) in
            textField.placeholder = "New business"
            textField.keyboardType = .asciiCapable
        }
        
        // add button
        alertController.addAction(buttonForMessageFirst)
        alertController.addAction(buttonForMessageSecond)
        
        //start controller
        self.present(alertController, animated: true, completion: nil)
    }
}
    
//    @objc func isOn(switchChanged:UISwitch){
//        if switchChanged.isOn {
//            self.myButton.backgroundColor = UIColor.darkGray
//            self.myButton.isUserInteractionEnabled = true
//        }
//        else {
//            self.present(vc, animated: true, completion: nil)
//            self.myButton.backgroundColor = UIColor.blue
//            self.myButton.isUserInteractionEnabled = false
//        }
//
//    }


//        self.view.addSubview(navBar);
//
//        let navItem = UINavigationItem(title: "SomeTitle");
//        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: nil);
//        navItem.rightBarButtonItem = doneItem;
//        navBar.setItems([navItem], animated: false);



//        self.mySwitch.frame = CGRect(x: 100, y: 100, width: 0, height: 0)
//        navigationItem.title = "Daile do"
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: myButton)
//        navigationItem.visi
//
//        vc.title = "dd"
//        vc.title?.append("Good")
//        view.addSubview(mySwitch)
//
//        myButton.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
//        myButton.layer.cornerRadius = 13
//        myButton.clipsToBounds = true
//        myButton.backgroundColor = UIColor(red: 60/255, green: 137/255, blue: 183/255, alpha: 1)
//        myButton.setTitle("Yes", for: .normal)
//        view.addSubview(myButton)

// рамка
//
//        self.myButton.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
//        self.myButton.center = self.view.center
//        myLabel.text = "Page Two"
//        myLabel.frame = CGRect(x: 300, y: 300, width: 50, height: 50)
//        vc.view.backgroundColor = UIColor.white
//        vc.view.addSubview(myLabel)
//        //self.view.addSubview(myLabel)
//        myButton.backgroundColor = UIColor.brown
//        myButton.setTitle("Yes", for: .normal)
//        myButton.setTitle("Press", for: .highlighted)
//        self.view.addSubview(self.myButton)
//        self.mySwitch.addTarget(self, action: #selector(isOn(switchChanged:)), for: .valueChanged) // наблюдатель
