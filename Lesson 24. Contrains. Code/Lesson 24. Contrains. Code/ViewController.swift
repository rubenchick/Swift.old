//
//  ViewController.swift
//  Lesson 24. Contrains. Code
//
//  Created by Anton Rubenchik on 08.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let mainView: UIView = {
        let view = UIView()
        // иначе не будут работать констрейны
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        view.backgroundColor = .green
        return view
    }()
    let subView: UIView = {
        let view = UIView()
        // иначе не будут работать констрейны
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        view.backgroundColor = .red
        return view
    }()
    
    let viewRed: UIView = {
        let view = UIView()
        // иначе не будут работать констрейны
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    let viewBlue: UIView = {
        let view = UIView()
        // иначе не будут работать констрейны
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        

        
        //Way 1. Classic way - don't use
//        view.addSubview(mainView)
//        view.addSubview(subView)
//        createMainViewContrainToSide()
//        createMainViewContrainToCenter()
//        createSubMainViewContrainToCenter()
        
        
        // Way 2. VFL
        view.addSubview(viewRed)
        view.addSubview(viewBlue)
    //  way2VFL()
        
        // Way 3. Anchor - main WAY.
        viewRed.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        viewRed.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        viewRed.heightAnchor.constraint(equalToConstant: 100).isActive = true
        viewRed.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        viewBlue.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        viewBlue.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        viewBlue.heightAnchor.constraint(equalToConstant: 100).isActive = true
        viewBlue.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    fileprivate func way2VFL() {
        let viewVFL = ["viewRed":viewRed,"viewBlue":viewBlue]
        let metrics = ["height": 100,"width": view.bounds.size.width / 3,"top": view.bounds.size.height / 2]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[viewRed(width)]-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: viewVFL))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[viewBlue(width)]-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: viewVFL))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[viewRed(width)]-(50)-[viewBlue(width)]-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: viewVFL))
    }
    
    func createMainViewContrainToSide() {
        NSLayoutConstraint(item: mainView,
                           attribute: .trailingMargin,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .trailingMargin,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: mainView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .leadingMargin,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: mainView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .topMargin,
                           multiplier: 1,
                           constant: 88).isActive = true
        NSLayoutConstraint(item: mainView,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: mainView,
                           attribute: .width,
                           multiplier: 1,
                           constant: 0).isActive = true
    }
    
    func createMainViewContrainToCenter() {
        NSLayoutConstraint(item: mainView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: mainView,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerY,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: mainView,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 100).isActive = true
        NSLayoutConstraint(item: mainView,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 100).isActive = true
    }
    
    func createSubMainViewContrainToCenter() {
        NSLayoutConstraint(item: subView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: mainView,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: subView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: mainView,
                           attribute: .top,
                           multiplier: 1,
                           constant: -10).isActive = true
        NSLayoutConstraint(item: subView,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 50).isActive = true
        
        NSLayoutConstraint(item: subView,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 50).isActive = true
    }
    

}
    
    




