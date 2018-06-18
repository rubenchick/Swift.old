//
//  PageViewController.swift
//  Test PageVC 3
//
//  Created by Anton Rubenchik on 16.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    var vcArray : [PromoViewController] = []
    let imageArray : [UIImage] = [ UIImage(named: "promo1")!,UIImage(named: "promo2")!,UIImage(named: "promo3")!,UIImage(named: "promo4")!,UIImage(named: "promo5")!] //"!" bad. need [String] and other UIImage whit check. May be late
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.delegate = self
        self.dataSource = self
        // create vcArray
        createArray()
        self.setViewControllers([vcArray[0]], direction: .forward, animated: true, completion: nil)

    }
    
    func createArray() {
        for item in imageArray {
            vcArray.append(PromoViewController(image: item))
        }
        print(vcArray.count)
    }
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        print(vcArray.count)
//        self.setViewControllers([vcArray[0]], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // init




}
extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return vcArray[0]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return vcArray[1]    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func  presentationCount(for pageViewController: UIPageViewController) -> Int {
        return vcArray.count
    }
    
    
}
