//
//  ViewController.swift
//  Lesson 1. Alert
//
//  Created by Anton Rubenchik on 24.04.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var CountryLabel: UILabel!
    @IBOutlet weak var SurnameLabel: UILabel!
    @IBOutlet weak var AgeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func alertMessage(title: String, text: String, style: UIAlertControllerStyle, label: UILabel){
        //создаем контроллер
        let alertController = UIAlertController(title: title, message: text, preferredStyle: style)
        //создаем кнопки
        let alertButtonOne = UIAlertAction(title: "Сохранить", style: .default, handler: { (text) in
            // добавляем в контроллер текстовое поле
            label.text = alertController.textFields?.first?.text
        } )
        let alertButtonTwo = UIAlertAction(title: "Отмена", style: .default, handler: { (text) in
        } )

        // добавляем в контроллер кнопки
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(alertButtonOne)
        alertController.addAction(alertButtonTwo)
        
        // Запускаем контроллер
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func ButtonPress(_ sender: Any) {
        alertMessage(title: NameLabel.text!, text: "Правильное имя:", style: .alert, label: NameLabel)
    }
    
    @IBAction func ChangeSurname(_ sender: Any) {
        alertMessage(title: SurnameLabel.text!, text: "Правильная фамилия:", style: .alert, label: SurnameLabel)
    }
    
    @IBAction func ChangeCountry(_ sender: Any) {
        alertMessage(title: CountryLabel.text!, text: "Правильная страна:", style: .alert, label: CountryLabel)
    }
    
    
    @IBAction func ChangeAge(_ sender: Any) {
        alertMessage(title: AgeLabel.text!, text: "Правильный возраст :", style: .alert, label: AgeLabel)
    }

    
    
}


