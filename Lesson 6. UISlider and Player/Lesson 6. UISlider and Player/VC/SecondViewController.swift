//
//  SecondViewController.swift
//  Lesson 6. UISlider and Player
//
//  Created by Anton Rubenchik on 14.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
/*
2 экран - настройки.

1 label с надписью "Выбрать пол". Напротив него - picker. в пикере 3 варианта: М,Ж, unknown.
2 textfiled - имя и ник.
1 slider - нажимая на который, можно менять цвет экрана.
1 кнопка "Сохранить".*/

import UIKit
import Foundation

class SecondViewController: UIViewController {
    let titleLabel = UILabel()
    let genderLabel = UILabel()
    let genderPicker = UIPickerView()
    let gender = ["Male","Female","unknown"]
    let nameTextField = UITextField()
    let nickTextField = UITextField()
    let saveButton = UIButton()
    let redSlider = UISlider()
    let greenSlider = UISlider()
    let blueSlider = UISlider()
    let redLabel = UILabel()
    let greenLabel = UILabel()
    let blueLabel = UILabel()
    var email = String()
    var numberGender = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.white
        
        //Сохраненные даннеы
        if UserDefaults.standard.value(forKey: "name") != nil {
            nameTextField.text = UserDefaults.standard.value(forKey: "name") as! String
        }
        
        if UserDefaults.standard.value(forKey: "nick") != nil {
            nickTextField.text = UserDefaults.standard.value(forKey: "nick") as! String
        }
        
        // add Title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.text = "Setting"
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: view.frame.midX - (titleLabel.frame.maxX - titleLabel.frame.minX)/2, y: 80, width: 10 , height: 44)
        titleLabel.sizeToFit()                      // ширина label динамическая по тексту
        view.addSubview(titleLabel)
        
        // add sexLabel
        genderLabel.text = "Select a gender"
        genderLabel.frame = CGRect(x: 60, y: 210, width: 200, height: 44)
        genderLabel.sizeToFit()
        view.addSubview(genderLabel)
        
        // add genderPicker
        genderPicker.frame = CGRect(x: 200 , y: 120, width: 150, height: 200)
        genderPicker.dataSource = self
        genderPicker.delegate = self
        // Ранее введенное значение
        if UserDefaults.standard.integer(forKey: "gender") != nil {
            genderPicker.selectRow(UserDefaults.standard.integer(forKey: "gender"), inComponent: 0, animated: false)
        }
        view.addSubview(genderPicker)
        
        // add TextField
        nameTextField.frame = CGRect(x: 30, y: 310, width: view.frame.width - 60, height: 44)
        nameTextField.placeholder = "Enter your Name"
        nameTextField.borderStyle = .bezel
        nameTextField.delegate = self
        view.addSubview(nameTextField)
        
        nickTextField.frame = CGRect(x: 30, y: 380, width: view.frame.width - 60, height: 44)
        nickTextField.placeholder = "Enter your Nickname"
        nickTextField.borderStyle = .bezel
        nickTextField.delegate = self
        view.addSubview(nickTextField)
        
        
        // add Sliders
        //red
        redSlider.frame = CGRect(x: 80, y: 440, width: view.frame.width - 110 , height: 44)
        if UserDefaults.standard.float(forKey: "red") != nil {
            redSlider.setValue(UserDefaults.standard.float(forKey: "red"), animated: true)
        }
        else { redSlider.setValue(1, animated: true) }
        view.addSubview(redSlider)
        redSlider.addTarget(self, action: #selector(changedSlider(_:)), for: .valueChanged)
        
        //green
        greenSlider.frame = CGRect(x: 80, y: 490, width: view.frame.width - 110 , height: 44)
        if UserDefaults.standard.float(forKey: "green") != nil {
            greenSlider.setValue(UserDefaults.standard.float(forKey: "green"), animated: true)
        }
        else { greenSlider.setValue(1, animated: true) }
        
        
        view.addSubview(greenSlider)
        greenSlider.addTarget(self, action: #selector(changedSlider(_:)), for: .valueChanged)
        
        //blue
        blueSlider.frame = CGRect(x: 80, y: 540, width: view.frame.width - 110 , height: 44)
        if UserDefaults.standard.float(forKey: "blue") != nil {
            blueSlider.setValue(UserDefaults.standard.float(forKey: "blue"), animated: true)
        }
        else { blueSlider.setValue(1, animated: true) }
        
        view.addSubview(blueSlider)
        blueSlider.addTarget(self, action: #selector(changedSlider(_:))  , for: .valueChanged)
        
        view.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
        // add sexLabels
        redLabel.text = "Red"
        redLabel.frame = CGRect(x: 30, y: 450, width: 200, height: 44)
        redLabel.sizeToFit()
        view.addSubview(redLabel)
        
        greenLabel.text = "Green"
        greenLabel.frame = CGRect(x: 30, y: 500, width: 200, height: 44)
        greenLabel.sizeToFit()
        view.addSubview(greenLabel)
        
        blueLabel.text = "Blue"
        blueLabel.frame = CGRect(x: 30, y: 550, width: 200, height: 44)
        blueLabel.sizeToFit()
        view.addSubview(blueLabel)
        
        // add Button
        saveButton.frame = CGRect(x: view.frame.midX - 70, y: 586, width: 140 , height: 44)
        saveButton.backgroundColor = UIColor(red: 60/255, green: 137/255, blue: 183/255, alpha: 1)
        saveButton.setTitle("Save", for: .normal)
        saveButton.layer.cornerRadius = 15
        view.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(pressSave), for: .touchDown)
        
        
       
    }
    
    @objc func pressSave() {
        // сохранение данных
        UserDefaults.standard.setValue(nameTextField.text, forKey: "name")
        UserDefaults.standard.setValue(nickTextField.text, forKey: "nick")
        UserDefaults.standard.set(numberGender, forKey: "gender")
        UserDefaults.standard.set(redSlider.value, forKey: "red")
        UserDefaults.standard.set(greenSlider.value, forKey: "green")
        UserDefaults.standard.set(blueSlider.value, forKey: "blue")
        UserDefaults.standard.synchronize()
        
        let endViewController = EndViewController()
        present(endViewController, animated: false, completion: nil)
    }
    @objc func changedSlider(_ slider: UISlider) {
        view.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
    }
    
    // метод сокрытия клавиатуры, при нажатии вне полей ввода
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
}
// опционально
extension SecondViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField { nickTextField.becomeFirstResponder() }
        else { nickTextField.resignFirstResponder()}
        return true
    }
}
extension SecondViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }

}

extension SecondViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberGender = row
    }
}

// Возврат RGB
extension UIColor {
    
    func rgb() -> (red:Int, green:Int, blue:Int, alpha:Int)? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)
            
            return (red:iRed, green:iGreen, blue:iBlue, alpha:iAlpha)
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
}

extension UIColor {
    var colorComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        guard let components = self.cgColor.components else { return nil }
        
        return (
            red: components[0],
            green: components[1],
            blue: components[2],
            alpha: components[3]
        )
    }
}
