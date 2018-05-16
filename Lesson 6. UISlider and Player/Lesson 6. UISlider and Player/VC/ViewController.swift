//
//  ViewController.swift
//  Lesson 6. UISlider and Player
//
//  Created by Anton Rubenchik on 04.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//1 экран -логин.
//2 textfield для ввода емейл и пароля.
//1 кнопка "Войти".

import UIKit

class ViewController: UIViewController {
    var loginLabel = UILabel()
    var emailTextField = UITextField()
    var passwordField = UITextField()
    var enterButton = UIButton()
    var pleerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        //Удаление сохраненных данных
     //   UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
     //   UserDefaults.standard.synchronize()
        
        // красивый цвет
        //view.backgroundColor = UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 1)
        
        // Проверяем вводились ли уже данные
        if UserDefaults.standard.value(forKey: "email") != nil {
            emailTextField.text = UserDefaults.standard.value(forKey: "email") as! String
        }
        // add label
        loginLabel.font = UIFont.boldSystemFont(ofSize: 36)
        loginLabel.text = "Login"
        loginLabel.sizeToFit()
        loginLabel.frame = CGRect(x: view.frame.midX - (loginLabel.frame.maxX - loginLabel.frame.minX)/2, y: 80, width: 10 , height: 44)
        loginLabel.sizeToFit()                                            // ширина label динамическая по тексту
        view.addSubview(loginLabel)
        
        // add TextField

        emailTextField.frame = CGRect(x: 30 , y: 180 , width: Int(view.frame.width - 60) , height: 44)
        emailTextField.placeholder = "Enter a e-mail"
        emailTextField.borderStyle = UITextBorderStyle.bezel
        emailTextField.keyboardType = .emailAddress
        emailTextField.delegate = self
        view.addSubview(emailTextField)
        
        passwordField.frame = CGRect(x: 30 , y: 250 , width: Int(view.frame.width - 60) , height: 44)
        passwordField.placeholder = "Enter a password"
        passwordField.isSecureTextEntry = true
        passwordField.borderStyle = UITextBorderStyle.bezel
        passwordField.keyboardType = .default
        passwordField.delegate = self
        view.addSubview(passwordField)
        
        // add button
        enterButton.frame = CGRect(x: view.frame.midX - 70, y: 350, width: 140, height: 44)
        enterButton.backgroundColor = UIColor(red: 60/255,
                                              green: 137/255,
                                              blue: 183/255,
                                              alpha: 1)
        enterButton.layer.cornerRadius = 15
        enterButton.setTitle("Enter", for: .normal)
        view.addSubview(enterButton)
        enterButton.addTarget(self, action: #selector(pressEnter), for: .touchDown)
        
        pleerButton.frame = CGRect(x: view.frame.midX - 70, y: 650, width: 140, height: 44 )
        pleerButton.backgroundColor = UIColor(red: 60/255,
                                              green: 137/255,
                                              blue: 183/255,
                                              alpha: 1)
        pleerButton.layer.cornerRadius = 15
        pleerButton.setTitle("Pleer", for: .normal)
        pleerButton.addTarget(self, action: #selector(pressPleer), for: .touchDown)
        view.addSubview(pleerButton)
        
        }
    
    @objc func pressEnter() {
        let secondViewController = SecondViewController()
        if emailTextField.text != "" && passwordField.text != "" {
            UserDefaults.standard.setValue(emailTextField.text, forKey: "email")
            UserDefaults.standard.synchronize()
            present(secondViewController, animated: false, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Attantion",
                                          message: "Not all data is filled out",
                                          preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "Close",
                                            style: .cancel,
                                            handler: nil)
            alert.addAction(alertButton)
            present(alert, animated: false, completion: nil)
        }
        
    }
    
    // метод сокрытия клавиатуры, при нажатии вне полей ввода
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    
    @objc func pressPleer() {

    }
}

// Расширение . Делегат. Что делать при нажатии return
extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool  { // called when 'return' key pressed. return NO to ignore.
        if textField == emailTextField { passwordField.becomeFirstResponder() }
        else { self.passwordField.resignFirstResponder() }
        return true
    }
}

