//
//  ViewController.swift
//  Lesson 14. UITextView
//
//  Created by Anton Rubenchik on 22.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var testTextView = UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func createStartElement() {
        //testTextView = UITextView(frame: self.view.bounds)
        testTextView = UITextView(frame: CGRect(x: 20, y: 100, width: view.bounds.width-40, height: view.bounds.height / 2))
        testTextView.text = "Some Text"
        testTextView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        testTextView.font = UIFont.systemFont(ofSize: 17)
        testTextView.backgroundColor = .gray
        view.addSubview(testTextView)
    }
    
    // первое касание
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        testTextView.resignFirstResponder() // убираем клавиатуру
    }
    


}

