//
//  MainPageViewController.swift
//  TestPageController
//
//  Created by Anton Rubenchik on 15.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class MainPageViewController: UIPageViewController {

    var arraVC : [PromoViewController] = []
    let stringArray : [String] = ["Anton","Tatyana","Ivan","Marii"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        createArray()
    }

    func createArray(){
        for item in stringArray {
            arraVC.append(PromoViewController(label: item))
        }
    }
    
    //MARK: Initialization
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.view.backgroundColor = .blue
        self.setViewControllers([arraVC[0]], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension MainPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = arraVC.index(of: viewController as! PromoViewController) {
            if index > 0 { return arraVC[index - 1] }
            else { return nil }
        } else { return nil }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = arraVC.index(of: viewController as! PromoViewController) {
            if index != arraVC.count - 1 { return arraVC[index + 1] }
            else {return nil}
        }
        else {return nil}
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return   arraVC.count
    }
    
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
