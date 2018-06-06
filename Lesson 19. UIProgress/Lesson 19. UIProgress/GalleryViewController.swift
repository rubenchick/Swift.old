//
//  galleryViewController.swift
//  Lesson 19. UIProgress
//
//  Created by Anton Rubenchik on 31.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
//MARK: - Variable
    private var firstImageView = UIImageView()
    private var secondImageView = UIImageView()
    private var thirdImageView = UIImageView()
    private var forthImageView = UIImageView()
    public var imageArray : [UIImage] = []
    public var nameImageArray : [String] = ["Mountains","Ocean","SanFrancisco","city"]

final class GalleryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createStartElements()
    }
    
    //MARK: - Methods
    private func createStartElements() {
        let imageHeight = view.frame.height / 4
        imageArray = createImageArray(nameImageArray)
        for item in 0...(imageArray.count - 1) {
            switch item {
            case 0 : createImageView(firstImageView,  imageArray[item], CGRect(x: 0, y: CGFloat(Int(imageHeight) * item), width: view.frame.width, height: imageHeight))
            case 1 : createImageView(secondImageView, imageArray[item], CGRect(x: 0, y: CGFloat(Int(imageHeight) * item), width: view.frame.width, height: imageHeight))
            case 2 : createImageView(thirdImageView,  imageArray[item], CGRect(x: 0, y: CGFloat(Int(imageHeight) * item), width: view.frame.width, height: imageHeight))
            case 3 : createImageView(forthImageView,  imageArray[item], CGRect(x: 0, y: CGFloat(Int(imageHeight) * item), width: view.frame.width, height: imageHeight))
            default: break
            }
        }
    }
    
    // Cоздание массива картинок c проверкой
    private func createImageArray(_ nameImageArray: [String]) -> [UIImage] {
        var newArray : [UIImage] = []
        for item in nameImageArray {
            if let newItem = UIImage(named: item) {
                newArray.append(newItem)
            }
        }
        return newArray
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            //test
//            print(touch.location(in: view).x,touch.location(in: view).y) // print current position
//            print(thirdImageView.frame.minY,thirdImageView.frame.maxY) // print imageView posotion
            
            // find imageView isClicked
            switch touch.location(in: view).y {
            case 0...firstImageView.frame.maxY: UserDefaults.standard.setValue("Mountains", forKey: "firstPageImage")
            case secondImageView.frame.minY...secondImageView.frame.maxY: UserDefaults.standard.setValue("Ocean", forKey: "firstPageImage")
            case thirdImageView.frame.minY...thirdImageView.frame.maxY:   UserDefaults.standard.setValue("SanFrancisco", forKey: "firstPageImage")
            case forthImageView.frame.minY...forthImageView.frame.maxY:   UserDefaults.standard.setValue("city", forKey: "firstPageImage")
            default: break
            }
        }
    }
    
    private func createImageView(_ imageView: UIImageView,_ image: UIImage,_ position:CGRect) {
        imageView.frame = position
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
    }
    

}
