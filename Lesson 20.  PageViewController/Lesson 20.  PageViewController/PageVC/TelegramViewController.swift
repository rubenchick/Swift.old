//
//  ViewController.swift
//  Lesson 20.  PageViewController
//
//  Created by Anton Rubenchik on 07.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
// create dinamic ViewController for any page
class TelegramViewController: UIViewController {
   
    //MARK: create Page Elements
    private let pageImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true //?
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let pageTitle : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 48)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    private let pageText : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    lazy var subView: [UIView] = [self.pageImageView,self.pageTitle,self.pageText]
    
    //MARK: Initialization
    init(elementsWith: PageElements) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .black
        edgesForExtendedLayout = [] //????? what is it
        
        pageImageView.image = elementsWith.image
        pageTitle.text      = elementsWith.title
        pageText.text       = elementsWith.text
        
        for view in subView {
            self.view.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: pageImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300),
            NSLayoutConstraint(item: pageImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200),
            NSLayoutConstraint(item: pageImageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: pageImageView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: -150),
            NSLayoutConstraint(item: pageTitle, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: pageTitle, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: pageText, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: pageText, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 100)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

