//
//  ViewController.swift
//  Parse Test
//
//  Created by Anton Rubenchik on 17/12/2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
struct Title: Decodable {
    let type: String
}
//struct Xxx: Decodable {
//    let title: Title
//}
//
//struct Entry: Decodable {
//    let empt: Xxx
//}
//
struct Feed: Decodable {
    let title: Title
}

struct Excel2: Decodable {
//    let id: Int
//    let entry: [String]
    let encoding: String
    let feed: Feed
//    let name: String
//    let link: String
//    let imageUrl: String
    let version: String
}
class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        parseData()
//        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/course"
//        let jsonUrlString = "https://restcountries.eu/rest/v2/all"
        let jsonUrlString = "https://spreadsheets.google.com/feeds/list/1iPBhMSbmgEhlRjWpnPj5vt9-RaPigdTH7Mn-9Ku0Wpc/od6/public/basic?alt=json"

        
        guard let url = URL(string: jsonUrlString) else
        { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
           
            do {
                ////// Work version
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//                print(json)
                
                guard let item = json as? [String: AnyObject],
//                    let feed = item["version"] as? String
                    let feeds = item["feed"] as? [String: AnyObject],
                    let entrys = feeds["entry"] as? [[String: AnyObject]]
                    else {
                        return;
                }
                for entry in entrys {
                    let x = entry["title"] as? [String: AnyObject]
                    let y = x?["$t"] as? String
                    
                    let xx = entry["content"] as? [String: AnyObject]
                    var yy = xx?["$t"] as? String
//                    if entry.keys == "title" {
//                        let x = entry.values
//                    "second: week_before, third: without"
//                    "_cokwr: i_was, _cpzh4: i_am_hear"
//                    var textViewString:String = "HelloWorld2016"
//                    guard let index = yy?.characters.index(of: ":") else { return }
//                    let yyy = yy?.distance(from: index, to: (yy?.endIndex)!)
//                    let s = "hi, hello"
                    var f = yy?.split(separator: ":")
                    let yyy = f?[1].dropFirst(1)
//                    print(yyy)
//                    print(mentionPosition)
//                    let yyy = yy?.dropFirst(8)
//                    var textViewString:String = "HelloWorld2016"
//                    guard let index = textViewString.characters.index(of: "W") else { return }
//                    let mentionPosition = textViewString.distance(from: index, to: textViewString.endIndex)
//                    print(mentionPosition)
                    
//                    let text = "abc"
//                    let index2 = text.index(text.startIndex, offsetBy: 2) //will call succ 2 times
//                    let lastChar: Character = text[index2] //now we can index!
//                    
//                    let characterIndex2 = text.characters.index(text.characters.startIndex, offsetBy: 2)
//                    let lastChar2 = text.characters[characterIndex2] //will do the same as above
//                    
//                    let range: Range<String.Index> = text.range(of: "b")!
//                    let index: Int = text.distance(from: text.startIndex, to: range.lowerBound)
                    
//                    let string = "0123456789"
//                    let substring1 = string.dropLast(2)
//                    let yyy = yy?.dropFirst(8)
                    print(y!,yyy!)
//                    }
                }
                
//                for i in feeds {
//                    let x = i.value as? [[String: AnyObject]]
//                    print(x)
////                    print(i.value)
//                }
//                print("YESSSSSSSSS\n \(entrys)")
//                for feed in feeds {
//                    if feed.key == "entry" {
//                        let entry = feed.value as? [String: AnyObject]
//                        print(entry ?? "NIL")
//                    }
//                }
                
                
//                print("YESSSSSSSSS\n \(feeds.count)") //12
//                guard let feed = feeds as? [String: AnyObject],
//                    //                    let feed = item["version"] as? String
//                    let entry = feed["entry"] as? [String: AnyObject]
//                    //                    let entry = feed["entry"] as? [String: AnyObject]
//                    else {
//                        return;
//                }
//                 print("YESSSSSSSSS\n \(entry.count)")
                
//                for feed in feeds {
//                    let entry = feed["entry"] as? [String: AnyObject]
//                }
//                print("YESSSSSSSSS\n \(entry)")

//                let entry = feed["id"] as? [String: AnyObject]

//                print("YESSSSSSSSS\n \(entry)")
                
//                print("YESSSSSSSSS\n \(entry)")
                
                
                
                
                
//                2
//                let course = try JSONDecoder().decode(Excel2.self, from: data)
//                print(course.encoding)
//                print(course.version)
//                print(course.feed.title.type)

                
                
            } catch let jsonErr {
                print(jsonErr)
            }
            
            
        }.resume()
        
        
        
        
    }
    
//    func parseData() {
//        let url = "https://restcountries.eu/rest/v2/all"
////        let url = "http://www.json.org/"
//        var request = URLRequest(url: URL(string: url)!)
//        request.httpMethod = "GET"
//
//        let configuration = URLSessionConfiguration.default
//        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
//
//        let task = session.dataTask(with: request) { (data, response, error) in
//
//            if (error != nil) {
//                print("Error")
//            }
//            else {
//                do {
//                    let fetchData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
////                        as! NSArray
//                    print(fetchData)
//                }
//                catch {
//                    print("Error 2")
//                }
//            }
//        }
//        task.resume()
//    }


}

