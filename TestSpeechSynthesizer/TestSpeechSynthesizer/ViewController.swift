//
//  ViewController.swift
//  TestSpeechSynthesizer
//
//  Created by Anton Rubenchik on 20.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
// ru-RU
//en-US
//he-IL

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        for voice in (AVSpeechSynthesisVoice.speechVoices()) {
//            print(voice)
//        }
        let speakTalk   = AVSpeechSynthesizer()
//        let speakMsg    = AVSpeechUtterance(string: "Hello Word I can speak")
//        let speakMsg    = AVSpeechUtterance(string: "Привет, меня зовут Антон")
        let speakMsg    = AVSpeechUtterance(string: "שלום")
        speakMsg.voice  = AVSpeechSynthesisVoice(language: "he-IL")
        speakMsg.pitchMultiplier = 1.2
        speakMsg.rate   = 0.5
        
        speakTalk.speak(speakMsg)
        
    }



}

