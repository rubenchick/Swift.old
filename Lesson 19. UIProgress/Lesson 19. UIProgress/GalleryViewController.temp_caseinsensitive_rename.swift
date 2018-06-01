//
//  galleryViewController.swift
//  Lesson 19. UIProgress
//
//  Created by Anton Rubenchik on 31.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
//MARK: - Variable
    var firstImageView = UIImageView()
    var secondImageView = UIImageView()
    var thirdImageView = UIImageView()
    var forthImageView = UIImageView()
//    var imageArray : [UIImage] = [UIImage(named: "Mountains")!,
//                                  UIImage(named: "Ocean")!,
//                                  UIImage(named: "Party")!,
//                                  UIImage(named: "Partner")!]
    var imageArray : [UIImage] = []
    var nameImageArray : [String] = ["Mountains","Ocean","Party","Partner"]

class galleryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createStartElements()
        
        
    }
//MARK: - Methods
    func createStartElements() {
        
        imageArray = createImageArray(nameImageArray)
        for item in 0...(imageArray.count - 1) {
            switch item {
            case 0 : createImageView(firstImageView, imageArray[item], CGRect(x: 0, y: 100, width: view.bounds.midX, height: 200))
            default: break
            }
        }
    }
    
    // Проверка на корректное создание массива картинок
    func createImageArray(_ nameImageArray: [String]) -> [UIImage] {
        var newArray : [UIImage] = []
        for item in nameImageArray {
            if let newItem = UIImage(named: item) {
                newArray.append(newItem)
            }
        }
        return newArray
    }
    
    func createImageView(_ imageView: UIImageView,_ image: UIImage,_ position:CGRect) {
        imageView.frame = position
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
    }
    

}
