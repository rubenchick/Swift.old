//
//  ViewController.swift
//  Lesson 15. UIButton
//
//  Created by Anton Rubenchik on 22.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var titleLabel = UILabel()
    var pauseButton = UIButton()
    var resetButton = UIButton()
    var time : Float = 0.0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createStartElement()
   
    }
    
    func convertedStringFrom(float: Float) -> String {
        let min =  Int(float/60)
        let sec =  Int(float) - min * 60
        let nano = Int(round((float - Float(Int(float))) * 100))
        
        return "\(min):\(sec).\(nano)"
    }
    
    func createStartElement() {
        let midX = view.frame.midX

        // add Label
        titleLabel.text = "00:00:00"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: (Int(midX - titleLabel.frame.width/2)), y: 70, width: 400, height: 70)
        view.addSubview(titleLabel)
        
        //add Buttons
        pauseButton.setTitleColor(.white, for: .normal)
        pauseButton.setTitleColor(.gray, for: .highlighted)
        pauseButton.setTitle("Start", for: .normal)
        pauseButton.backgroundColor = UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 1)
        pauseButton.frame = CGRect(x: midX - 100, y: 300, width: 200, height: 44)
        pauseButton.layer.cornerRadius = 15
        pauseButton.addTarget(self, action: #selector(pressPauseButton), for: .touchUpInside)
        view.addSubview(pauseButton)
        
        
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.setTitleColor(.gray, for: .highlighted)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.backgroundColor = UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 1)
        resetButton.frame = CGRect(x: midX - 100, y: 380, width: 200, height: 44)
        resetButton.layer.cornerRadius = 15
        resetButton.addTarget(self, action: #selector(pressResetButton), for: .touchUpInside)
        view.addSubview(resetButton)
        
    }
    
    @objc func pressPauseButton() {
        if pauseButton.titleLabel?.text == "Start" {
            pauseButton.setTitle("Pause", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerWork), userInfo: nil, repeats: true)
        }
        else {
            pauseButton.setTitle("Start", for: .normal)
            timer.invalidate()
        }
    }
    @objc func pressResetButton() {
        time = 0
        titleLabel.text = "00:00:00"
    }
    
    @objc func timerWork(){
        time += 0.01
        var currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss.SS"
        currentDate = dateFormatter.date(from: convertedStringFrom(float: time))!
        titleLabel.text = dateFormatter.string(from: currentDate)
        
    }
    



}


