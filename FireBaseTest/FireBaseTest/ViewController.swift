//
//  ViewController.swift
//  FireBaseTest
//
//  Created by Anton Rubenchik on 07.10.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    let nameTable = "users"
    var ref: DatabaseReference!
    let wordArray :[(String,String,String,String,Int,Int)] = [("table","стол","table","тэйбл",2,5),("home","дом","house","хоум",3,7)]
    let nameFieldArray = ["foreign","original","image","simple","level","date"]

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // create
//        Auth.auth().createUser(withEmail: "299550@gmail.com", password: "123456") { (result, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                print("error")
//            } else {
//                print(result?.user.email)
//            }
//        }
        // create end
        
        //  singIn
//        Auth.auth().signIn(withEmail: "299550@gmail.com", password: "123456") { (user, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                print("error")
//            }
//            else {
//                print("All right. Connection")
//                self.writeToFireBase()
//            }
//        }
        //  singIn end
//
//        let userID = Auth.auth().currentUser?.uid
//        print("User === ",userID)
////        try! Auth.auth().signOut()
        readFromFireBase()
        print("exit")
    }
    
    func readFromFireBase() {
        let userID = Auth.auth().currentUser?.uid
        ref.child(nameTable).child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
//            let username = value?["username"] as? String ?? ""
//            let user = User(username: username)
//            print(value)
            for item in (value?.allValues)! {
                let x = item as? NSDictionary
                let y = x!["original"] as? String ?? ""
                print(y)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func writeToFireBase() {
        let userID = Auth.auth().currentUser?.uid
        if userID != nil {
            // each elements of wordArray
            for item in wordArray {
                // create tuple with information about word
                var wordDict = [String : Any]()
                for i in 0...nameFieldArray.count-1 {
                    switch i {
                        case 0: wordDict[nameFieldArray[i]] = item.0
                        case 1: wordDict[nameFieldArray[i]] = item.1
                        case 2: wordDict[nameFieldArray[i]] = item.2
                        case 3: wordDict[nameFieldArray[i]] = item.3
                        case 4: wordDict[nameFieldArray[i]] = item.4
                        case 5: wordDict[nameFieldArray[i]] = item.5
                    default:
                        return
                    }
                }
                self.ref.child(nameTable).child(userID!).child(item.2).setValue(wordDict) { (error, dataResult) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("Write ",dataResult)
                    }
                }
            }
        } else {
            print("userID - nil")
        }
        print("exit")
//        self.ref.child("users").child(userID!).setValue(["username": "Ivan"], withCompletionBlock: { (error, dataResult) in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                print(dataResult)
//            }
//        })
    }
    


}

