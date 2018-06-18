//
//  PageViewController.swift
//  Test UIKit. Online shop.
//
//  Created by Anton Rubenchik on 17.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
   // need rewrite without "!"
    var imageArray: [UIImage] = [UIImage(named: "promo1")!,
                                 UIImage(named: "promo2")!,
                                 UIImage(named: "promo3")!,
                                 UIImage(named: "promo4")!,
                                 UIImage(named: "promo5")!]
    lazy var promoVCArray: [PromoViewController] = {
        var newArray = [PromoViewController]()
        var newVC : PromoViewController
        for item in imageArray {
            newVC = PromoViewController(image: item)
            newArray.append(newVC)
        }
        return newArray
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self

        // Do any additional setup after loading the view.
    }
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        if !promoVCArray.isEmpty {
        setViewControllers([promoVCArray[0]], direction: .forward, animated: true, completion: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PromoViewController else { return nil }
        if let index = promoVCArray.index(of: viewController) {
            if index > 0 {
                return promoVCArray[index - 1]
            } else { return promoVCArray.last}
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PromoViewController else { return nil  }
        if let index = promoVCArray.index(of: viewController) {
            if index != promoVCArray.count - 1 {
                return promoVCArray[index + 1]
            }
            else {return promoVCArray[0]}
        }
        return nil
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return promoVCArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
