//
//  FillingDataViewController.swift
//  Lesson 5. Picker
//
//  Created by Anton Rubenchik on 28.04.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//Если выбран Клиент - переход на второй контроллер и заполнение 5 текстфилдов: имя, фамилия, пароль, номер банковской карты(4 любых цифры), и емейл.
//+ кнопка Сохранить. После нажатия на неё вылетает alertview с сообщением
//Developer емейл, имя, фамилия, номер банковской карты, технология(к примеру ios, android, web), язык на котором пишет, опыт в годах.

import UIKit

class FillingDataViewController: UIViewController {
    let label = UILabel()
    var isDeveloper = Bool()
    let rVC = RegistrationViewController()
    let button = UIButton()

    let customerAttribute : [(String,UIKeyboardType)]  = [("Enter a user name",.alphabet),("Enter a user surname",.alphabet),("Enter a password",.alphabet),("Enter a card number",.decimalPad),("Enter a e-mail",.emailAddress)]

    let developerAttribute : [(String,UIKeyboardType)]  = [("Enter a e-mail",.emailAddress),("Enter a user name",.alphabet),("Enter a user surname",.alphabet),("Enter a card number",.decimalPad), ("Enter a technologies (e.g. iOs, Web, Android )",.alphabet),("Enter a machine code",.alphabet),("Enter the coded time",.decimalPad)]

    var textField : [ UITextField ] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // create Label
        
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.frame = CGRect(x: (view.frame.width/2) - 50 , y: 20, width: 200 , height: 44)
        view.addSubview(label)
        
        button.frame = CGRect(x: view.frame.midX-100, y: view.frame.maxY - 200, width: 200, height: 44)
        button.backgroundColor = UIColor(red: 60/255, green: 137/255, blue: 183/255, alpha: 1)
        button.layer.cornerRadius = 15
        button.setTitle("Save", for: .normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(pressButton), for: .touchDown)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func pressButton(){
        var number = 0
        var isFull = true
        var text = ""
        while (number != textField.count) && (isFull) {
            if textField[number].text == "" { isFull = false }
            number += 1
        }
        
        if !isFull { text = "Not all data is filled out" }
        else {
            if isDeveloper {
                 text = "E-mail - \((textField[0].text)!) \n Name - \((textField[1].text)!)\n Surname - \((textField[2].text)!)\n Card number -  \((textField[3].text)!)\n Technologies - \((textField[4].text)!)\n Machine code - \((textField[5].text)!)\n Time coding - \((textField[6].text)!)"
                
            }
            else {
                text = "Name - \((textField[0].text)!)\n Surname - \((textField[1].text)!)\n Password - \((textField[2].text)!)\n Card number - \((textField[3].text)!)\n E-mail - \((textField[4].text)!)"
            }
        }
        
        let alert = UIAlertController(title: "Profile",
                                      message: text,
                                      preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Close",
                                        style: .cancel,
                                        handler: nil)
        alert.addAction(alertButton)
        present(alert, animated: false, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        chooseUser()
        
    }
    
    func chooseUser() {
  
        if isDeveloper {
            for i in 0...developerAttribute.count-1 {
                addNewTextField(numberOfItem: i, placeHolder: developerAttribute[i].0, keyboardType: developerAttribute[i].1)
            }
        }
        else {
            for i in 0...customerAttribute.count-1 {
                addNewTextField(numberOfItem: i, placeHolder: customerAttribute[i].0, keyboardType: customerAttribute[i].1)
            }
        }
    }
    
    func addNewTextField(numberOfItem:Int, placeHolder:String, keyboardType:UIKeyboardType) {
        let tempTextField = UITextField()
        textField.append(tempTextField)
            
            // create textField
        textField[numberOfItem].frame = CGRect(x: 30 , y: 70 + numberOfItem*56, width: Int(view.frame.width - 60) , height: 44)
        textField[numberOfItem].placeholder = placeHolder
        textField[numberOfItem].borderStyle = UITextBorderStyle.bezel
        textField[numberOfItem].keyboardType = keyboardType
        textField[numberOfItem].delegate = self
        view.addSubview(textField[numberOfItem])
    }
    
    // метод сокрытия клавиатуры, при нажатии вне полей ввода
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
}

extension FillingDataViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool  { // called when 'return' key pressed. return NO to ignore.
        var number = 0
        while textField != self.textField[number] {
            number += 1
        }
        if number < (self.textField.count - 1) {
            self.textField[number+1].becomeFirstResponder()
        }
        else {
            // закрытие клавиатуры после последнего поля
            self.textField[number].resignFirstResponder()
        }
        return true
    }
}


