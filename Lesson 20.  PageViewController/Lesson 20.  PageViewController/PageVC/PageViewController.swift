//
//  PageViewController.swift
//  Lesson 20.  PageViewController
//
//  Created by Anton Rubenchik on 07.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
   // var arrayVC : [UIViewController]
    var arrayVC : [TelegramViewController] = []
    var arrayPageElements : [PageElements] = []
    let pageImage : [UIImage] = [UIImage(named: "first")!,
                                 UIImage(named: "second")!,
                                 UIImage(named: "third")!,
                                 UIImage(named: "fourth")!,
                                 UIImage(named: "fiveth")!,
                                 UIImage(named: "sixth")!]
    let pageTitle : [String] = ["Telegram","Fast","Free","Powerful","Scure","Cloud-Based"]
    let pageText  : [String] = ["The world's fastest messageing app.\nIt is free and secure",
                                "Telegram delivers messages\n faster thab any other application.",
                                "Telegram is free forever. No ads.\n No subscription fees.",
                                "Telegram has no limits on\n the size of your chats and media.",
                                "Telegram keeps your messages\n safe from hacker attacks.",
                                "Telegram lets you access your\n messages from multiple devices."]
   
    // create start Button
    var pageButton = UIButton()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self

        createAllArray()
        createButton()
        view.addSubview(pageButton)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
// MARK: - Initialization
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.view.backgroundColor = .black
        self.setViewControllers([arrayVC[0]], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func createAllArray() {
        //create array PageElements
        var temp = PageElements()
        for i in 0...(pageImage.count - 1) {
            temp = PageElements(image: pageImage[i], title: pageTitle[i], text: pageText[i])
            arrayPageElements.append(temp)
        }
        
        // create array pageVC
        for page in arrayPageElements {
            arrayVC.append(TelegramViewController(elementsWith: page))
        }
    }

    func createButton(){
        pageButton.backgroundColor = .white
        pageButton.setTitle("Start Messaging", for: .normal)
        pageButton.setTitleColor(.black, for: .normal)
        pageButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        pageButton.translatesAutoresizingMaskIntoConstraints = false
        pageButton.layer.cornerRadius = 20
        pageButton.frame = CGRect(x: view.center.x-125, y: view.frame.maxY-130, width: 250, height: 44)
    }
}

// MARK: - extantion DataSourse
extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = arrayVC.index(of: viewController as! TelegramViewController) {
            if index > 0 { return arrayVC[index - 1] }
            else { return nil }
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = arrayVC.index(of: viewController as! TelegramViewController) {
            if index != arrayVC.count - 1 { return arrayVC[index + 1] }
            else { return nil }
        }
        else {
            return nil
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int { // The number of items reflected in the page indicator.
        
        return arrayVC.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int  { // The selected item reflected in the page indicator.

        return 0
    }
}
