//
//  MyPageViewController.swift
//  Test 4 PageVC
//
//  Created by Anton Rubenchik on 16.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class MyPageViewController: UIPageViewController {

    var firstPromo = UIImage(named: "promo1")
    var secondPromo = UIImage(named: "promo2")
    var promoArray : [UIImage] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        promoArray.append(firstPromo!)
        promoArray.append(secondPromo!)
        print(promoArray.count)
        self.dataSource = self
    }
    
    
    // create VC
//    lazy var arrayPromoVC: [PromoViewController] = {
//        var newVC = [PromoViewController]()
//        for item in promoArray {
//            newVC.append(PromoViewController(image: item))
//        }
//        return newVC
//    }()
    lazy var arrayPromoVC : [PromoViewController] = [PromoViewController(image: UIImage(named: "promo1")!),
                                                     PromoViewController(image: UIImage(named: "promo2")!),
                                                     PromoViewController(image: UIImage(named: "promo3")!),
                                                     PromoViewController(image: UIImage(named: "promo4")!),
                                                     PromoViewController(image: UIImage(named: "promo5")!)]
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        setViewControllers([arrayPromoVC[0]], direction: .forward, animated: true, completion: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        guard let viewController = viewController as? PromoViewController else { return nil }
        if let index = arrayPromoVC.index(of: viewController) {
            if index > 0 {
                return arrayPromoVC[index - 1]
            }
        }
 
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PromoViewController else { return nil }
        if let index = arrayPromoVC.index(of: viewController) {
            if index < arrayPromoVC.count - 1 {
                return arrayPromoVC[index + 1]
            }
        }
        
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return arrayPromoVC.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}








