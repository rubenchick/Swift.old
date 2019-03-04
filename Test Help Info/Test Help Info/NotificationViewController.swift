//
//  NotificationViewController.swift
//  Test Help Info
//
//  Created by Anton Rubenchik on 18/01/2019.
//  Copyright © 2019 Anton Rubenchik. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationViewController: UIViewController {
//    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//        let firstLabel = UILabel(frame: CGRect(x: 100, y: 550, width: 100, height: 44))
//        firstLabel.text = "Haifa - city"
////        let scrollView = UIScrollView()
//        scrollView.frame = self.view.bounds
//        scrollView.showsVerticalScrollIndicator = true
//        scrollView.contentSize = CGSize(width: view.frame.width, height: 800)
//        scrollView.addSubview(firstLabel)
//
//        view.addSubview(scrollView)
//
        
        
    }
    
    @IBAction func pressStart(_ sender: UIButton) {
        
        
        let text = "וּ‬אבאָ"
        for i in text.utf8 {
            print(i)
        }
        print(" ")
        for i in text.utf16 {
            print(i)
        }
        print(" ")
        for i in text.unicodeScalars{
            print(i)
        }
        print(" ")
        for i in text
        {
            print(i)
        }

//        appDelegate?.schedularNotification()
        
//        let date = Date()
//        let calendar = Calendar.current
//
//        let hour = calendar.component(.hour, from: date)
//        let minutes = calendar.component(.minute, from: date)
//        let seconds = calendar.component(.second, from: date)
//        print("hours = \(hour):\(minutes):\(seconds)")
    }


}
