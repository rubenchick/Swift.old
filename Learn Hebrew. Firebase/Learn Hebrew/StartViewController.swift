//
//  StartViewController.swift
//  Learn Hebrew
//
//  Created by Anton Rubenchik on 10.10.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class StartViewController: UIViewController {

    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var chooseUserPicker: UIPickerView!
//    let users = ["---","Anton","Ivan","Anton(new)","Ivan(new)"]
    let users = ["---","Main","Verb + adverb","new Main","new Verb"]
    let emails = ["","anton.rubenchik@gmail.com","299550@gmail.com","tatyana.rubenchik@gmail.com","maria.rubenchik@gmail.com"]
    let passwords = ["","123456","123456","123456","123456"]
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        chooseUserPicker.dataSource = self
        chooseUserPicker.delegate   = self
        lookForCurrentUser()
        
    }
    func lookForCurrentUser() {
        let emailCurrentUser = Auth.auth().currentUser?.email
//        print(emailCurrentUser)
        if emailCurrentUser != nil {
            var i = 0
            while (emailCurrentUser)! != emails[i] {
//                print(emailCurrentUser,emails[i],i)
                i += 1
                if i > emails.count {
                    chooseUserPicker.selectRow(0, inComponent: 0, animated: false)
                    break
                }
            }
            chooseUserPicker.selectRow(i, inComponent: 0, animated: false)
            nameUserLabel.text = users[chooseUserPicker.selectedRow(inComponent: 0)]

        } else {
            chooseUserPicker.selectRow(0, inComponent: 0, animated: false)
        }
        
    }
    
    @IBAction func changeUserButton(_ sender: UIButton) {
        chooseUserPicker.isHidden = false
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        let vc = ViewController()
        let currentUser = Auth.auth().currentUser?.uid
        if currentUser != nil {
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    func singIn() {
        let userEmail = Auth.auth().currentUser?.email
        if userEmail != nil {
            if userEmail == emails[chooseUserPicker.selectedRow(inComponent: 0)] {
                return
            } else {
                try! Auth.auth().signOut()
            }
        }
        Auth.auth().signIn(withEmail: emails[chooseUserPicker.selectedRow(inComponent: 0)], password: passwords[chooseUserPicker.selectedRow(inComponent: 0)]) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                print("!!!!!!! error !!!!!!!")
            }
            else {
                print("All right. Connection. \(String(describing: user?.user.email))")
            }
        }
    }
    
}

extension StartViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users.count
    }
}

extension StartViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return users[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameUserLabel.text = users[row]
        chooseUserPicker.isHidden = true
        singIn()
    }
}
