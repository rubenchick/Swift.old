//
//  ViewController.swift
//  Lesson 13. UITestField
//
//  Created by Anton Rubenchik on 22.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var testTextField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTextField()
        testTextField.delegate = self
        
     //   testTextField.becomeFirstResponder() // при открывании окна, сразу курсор встает в первое поле и открывается клавиатура
        
//        // Ловит изменение . Чем то похоже на Delegate
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
        // Ставим в viewDidLoad
        // Ловит уведомление в "Центре"
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = -200
        }
//        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardDidHide, object: nil, queue: nil) { (nc) in
//            self.view.frame.origin.y = 0.0
//        }
        // Отправка уведомления в центр
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "red"), object: nil)
        
        // Ловит уведомление в "Центре"
        NotificationCenter.default.addObserver(self, selector: #selector(pressButton), name: NSNotification.Name(rawValue: "red"), object: nil)
    }
    
    @objc func pressButton() {
        print("Work")
    }
    
    // MARK: - notification // 1:N
    
    @objc func textFieldDidChange(ncParam: NSNotification) {
        print("UITextFieldDidChange \(ncParam)")
    }
    
    // MARK: - create TextField
    func createTextField() {
        testTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 31))
        testTextField.center = view.center
        testTextField.borderStyle = .roundedRect
        
        // выравнивание по вертикале
        testTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        testTextField.textAlignment = .center // по горизонатале
        
        testTextField.placeholder = "Enter"
        view.addSubview(testTextField)
    }
    // MARK: - UITextFieldDelegate - наблюдение за определенными действиями
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == testTextField {
            print("textFieldShouldBeginEditing - Можно ли редактировать поле")
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing - Внимание, началось редактировние")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //запускается перед тем, пользователь собирается уйти из поля редактирования
        print("textFieldShouldEndEditing - Внимание, закончилось редактировние")
        return true // false запред на выход
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        print("textFieldDidEndEditing")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("textField - вы ввели букву \(string)")
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("textFieldShouldClear - Вы хотите стереть информацию")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn - Хотим убрать клавиатуру}")
        self.testTextField.resignFirstResponder() // убрать клавиатуру
        //self.testTextField.becomeFirstResponder() // назначить клавиатуру
        return true
    }
    
    
    
    
    
    
    
    



}

