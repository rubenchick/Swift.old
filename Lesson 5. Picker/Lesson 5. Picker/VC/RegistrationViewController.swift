//
//  RegistrationViewController.swift
//  Lesson 5. Picker
//
//  Created by Anton Rubenchik on 28.04.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    let typeUser = ["-","Customer","Developer"]
    let userPicker = UIPickerView()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userPicker.center = view.center
        userPicker.dataSource = self
        userPicker.delegate   = self
        view.addSubview(userPicker)
        
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Select your type"
        label.sizeToFit()
        label.frame = CGRect(x: view.frame.midX - (label.frame.maxX-label.frame.minX)/2, y: 300, width: 10 , height: 44)
        label.sizeToFit()                                            // ширина label динамическая по тексту
        view.addSubview(label)

    }
}

extension RegistrationViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeUser.count
    }
}

extension RegistrationViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeUser[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 1: do {
            let fillingDataVC = FillingDataViewController()
            fillingDataVC.view.backgroundColor = UIColor.white
            fillingDataVC.label.text = "Customer"
            fillingDataVC.isDeveloper = false
            present(fillingDataVC, animated: false, completion: nil)
            }
            
        case 2: do {
            let fillingDataVC = FillingDataViewController()
            fillingDataVC.view.backgroundColor = UIColor.white
            fillingDataVC.label.text = "Developer"
            fillingDataVC.isDeveloper = true
            present(fillingDataVC, animated: false, completion: nil)
            }
        default:
            break
        }
    }
}


