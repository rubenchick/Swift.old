//
//  ViewController.swift
//  Lesson 5. Picker
//
//  Created by Anton Rubenchik on 28.04.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    let picker = UIPickerView()
    let picker2 = UIPickerView()
    let number = [1,2,3,4,5,6,7,8,9,10]
    let sex = ["Male","Female"]
    let car = ["-","Lanser","Toureg"]
    let dataLabel = UILabel()
    let pickerDate = UIDatePicker()
    let pickerTime = UIDatePicker()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let todayDate = Date()
        
        //Устанавливаем формат даты
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        dataLabel.text = formatter.string(from: todayDate)

        // create Label
        dataLabel.frame = CGRect(x: 90, y: 50, width: 120, height: 44)
        view.addSubview(dataLabel)
        
        // create picker Date
        pickerDate.center = view.center
        pickerDate.datePickerMode = .date
        view.addSubview(pickerDate)

        // create picker Time
        pickerTime.frame = CGRect(x: view.frame.midX-150, y: view.frame.maxY-200, width: 300, height: 100)
        pickerTime.datePickerMode = .time
        view.addSubview(pickerTime)
        pickerTime.addTarget(self, action: #selector(printTimeAlert(paramDataPicker:)), for: .valueChanged)
        
        // create button Registration
        button.frame = CGRect(x: view.frame.maxX - 190, y: 50, width: 140, height: 44)
        button.backgroundColor = UIColor(red: 60/255, green: 137/255, blue: 183/255, alpha: 1)
        button.layer.cornerRadius = 15
        button.setTitle("Registration", for: .normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(pressRegistration), for: .touchDown)
        pickerDate.addTarget(self, action: #selector(dataPickerChange(paramDataPicker:)), for: .valueChanged)
        
        
        
        
        // Максимальная дата для выбора
//        var oneYearTime = TimeInterval()
//        oneYearTime = 365 * 24 * 60 * 60
//        picker3.maximumDate = todayDate.addingTimeInterval(oneYearTime)
        

        
        // Picker Learning
        
//        picker.center = view.center
//        picker2.frame = CGRect(x: view.frame.midX-150, y: view.frame.maxY-200, width: 300, height: 150)
//
//        // у self нет информации о dataSource поэтому нужно расширить класс ViewController
//        picker.dataSource = self
//        picker.delegate = self
//        picker2.dataSource = self
//        picker2.delegate = self
//        view.addSubview(picker)
//        view.addSubview(picker2)
    }
    
    @objc func dataPickerChange(paramDataPicker: UIDatePicker){
        if paramDataPicker.isEqual(self.pickerDate) { // если в параметр пришел именно наш пикер
            let formatter = DateFormatter()
            formatter.dateStyle = DateFormatter.Style.medium
            self.dataLabel.text = formatter.string(from: self.pickerDate.date)
            
            // переходим на другой контроллер
            let normalYearVC :NormalYearViewController = NormalYearViewController()
            let calendar = Calendar.current
            let year = calendar.component(.year, from: self.pickerDate.date)
     
            if (( year % 4 ) == 0 ) && (( year % 100 ) != 0) {
                    normalYearVC.label.text = "Leap year"
            }
            else {
                if (( year % 4 ) == 0 ) && (( year % 100 ) == 0) && (( year % 400 ) == 0) {
                    normalYearVC.label.text = "Leap year"
                }
                else {
                    normalYearVC.label.text = "Unleap year"
                }
            }
            present(normalYearVC, animated: false, completion: nil)
        }
    }
    
    @objc func printTimeAlert(paramDataPicker: UIDatePicker){
        if paramDataPicker.isEqual(self.pickerTime) { // если в параметр пришел именно наш пикер
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            let alert = UIAlertController(title: "Set time", message: formatter.string(from: self.pickerTime.date), preferredStyle: .actionSheet)
            let alertButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(alertButton)
            present(alert, animated: false, completion: nil)
        }
    }
    
    @objc func pressRegistration(){
        let registrationVC = RegistrationViewController()
        registrationVC.view.backgroundColor = UIColor.white
        present(registrationVC, animated: false, completion: nil)
    }
}

// Обязательные расширения
extension ViewController: UIPickerViewDataSource {
    
    //Сколько компонентов выводим
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView {
        case picker:
            return 2
        case picker2:
            return 1
        default:
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case picker: do {
            if component == 0 { return 2 }
            else             { return 10 }
        }
        case picker2: do {
             return car.count
            }

        default:
            return 1
        }
    }
    
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var result = ""
        switch pickerView {
        case picker: do {
            if component == 1 { result = String(number[row])
            }
            else { result = sex[row] }
        }
        case picker2: result = car[row]
        default:
            result = "X"
        }
        return result
    }
    
}

