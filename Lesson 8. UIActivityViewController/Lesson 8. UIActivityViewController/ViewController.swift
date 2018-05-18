//
//  ViewController.swift
//  Lesson 8. UIActivityViewController
//
//  Created by Anton Rubenchik on 16.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
// Повторить код из видео. Почитать в документации Apple про UIActivity(учитесь работать с докой).
//1) Потренируйтесь писать UIActivity кодом: сделайте его вызов по нажатию на кнопку, затем вызов по прокрутке UIPicker(например, в пикере 3 раздела. Переходите на 3 и вызываете UIPicker).
//Придумать свои фишки - где можно использовать UIActivity.
//2) Попробуйте шарить в facebook через UIActivity.

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    let textField = UITextField()
    
    var relaxArray = ["Ocean","Mountains","Parnter","Party","Snowboard"]
    var imageArray = [UIImage(named: "Ocean.png"),
                      UIImage(named: "Mountains.png"),
                      UIImage(named: "Partner.png"),
                      UIImage(named: "Party.png"),
                      UIImage(named: "Snowboard.png")]
    var image: UIImage?
    var activityController : UIActivityViewController? = nil
    var segmentedControl = UISegmentedControl()
    var imageView = UIImageView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        createStartElement()
    }
    var button = UIButton()
    
    //MARK: - Methods
    func createStartElement() {
        createTextField()
        createButton()
        createSegmentedController()
        createView()
    }
    
    func createTextField() {
        // create TextField
        self.textField.frame = CGRect(x: 20, y: 400, width: self.view.frame.width-40, height: 44)
        self.textField.placeholder = "Enter a message"
        self.textField.keyboardType = .default
        self.textField.borderStyle = UITextBorderStyle.roundedRect
        self.textField.delegate = self
        self.view.addSubview(textField)
    }
    
    func createButton() {
        // create Button
        self.button = UIButton(type: .roundedRect)
        self.button.frame = CGRect(x: view.frame.midX-70, y: 450, width: 140, height: 44)
//        self.button.center = self.view.center
//        self.button.backgroundColor = UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 1)
//        self.button.layer.cornerRadius = 5.0
        self.button.setTitle("Send", for: .normal)
        self.view.addSubview(self.button)
        self.button.addTarget(self, action: #selector(pressButton), for: .touchUpInside) // отпустили
    }
    
    func createSegmentedController() {
            segmentedControl = UISegmentedControl(items: relaxArray)
            segmentedControl.frame = CGRect(x: 20, y: 340, width: self.view.frame.width-40, height: 44)
            segmentedControl.selectedSegmentIndex = 0
            self.view.addSubview(segmentedControl)
        self.segmentedControl.addTarget(self, action: #selector(changedSelector), for: .valueChanged)
    }
    
    func createView() {
        imageView.frame = CGRect(x: 0, y: 20 , width: Int(view.frame.width), height: 300)
        imageView.image = imageArray[0]
        view.addSubview(imageView)
    }
    
    @objc func pressButton() {
//        let text = self.textField.text
//        if text?.count != 0 {
//            self.activityController = UIActivityViewController(activityItems: [text ?? nil], applicationActivities: nil)
//            //activityController?.popoverPresentationController?.sourceView = self.view // For working on IPad
//           // activityController?.excludedActivityTypes = [UIActivityType.copyToPasteboard] // unVisiable
//            self.present(activityController!, animated: false, completion: nil)
//        }
//
//        else {
//            let message = "Need type information"
//            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//            let alertButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
//            alertController.addAction(alertButton)
//            self.present(alertController, animated: false, completion: nil)
//        }
        image = imageArray[segmentedControl.selectedSegmentIndex]
        self.activityController = UIActivityViewController(activityItems: [self.imageView.image!], applicationActivities: nil)
        self.present(activityController!, animated: false, completion: nil)
        
    }
    @objc func changedSelector() {
        self.imageView.image = imageArray[self.segmentedControl.selectedSegmentIndex]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
    


}

