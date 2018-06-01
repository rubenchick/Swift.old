//
//  ViewController.swift
//  Lesson 19. UIProgress
//
//  Created by Anton Rubenchik on 31.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    //MARK: - Varitable
    private var mainProgress = UIProgressView()
    private var mainTimer = Timer()
    private var mainImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createProgressView(mainProgress)
        createStartElements()
        mainTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changeProgressView), userInfo: nil, repeats: true)
    }

    // MARK: - Function
    public func createProgressView(_ progress:UIProgressView) {
        progress.frame = CGRect(x: view.center.x - 100, y: view.center.y, width: 200, height: 50)
        progress.progress = 0.0
        progress.trackTintColor = UIColor.blue
        progress.tintColor = .red
        view.addSubview(progress)
    }
    
    private func createStartElements() {
        var mainImage = UIImage()
        if UserDefaults.standard.value(forKey: "firstPageImage") != nil {
            if let testImage = UIImage(named:  UserDefaults.standard.value(forKey: "firstPageImage") as! String) {
                mainImage = testImage
            }
        }
        else {
            if let testImage = UIImage(named:  "Snowboard") {
              mainImage = testImage
            }
           // mainImage = UIImage(named:  "Snowboard")!
        }
        mainImageView = UIImageView(frame: CGRect(x: 0, y: 50, width: view.bounds.width, height: 300))
        mainImageView.image = mainImage
        mainImageView.contentMode = .scaleAspectFit
        mainImageView.alpha = 0.25
        view.addSubview(mainImageView)
        
    }
    
    @objc func changeProgressView() {
        if mainProgress.progress != 1.0 {
            mainProgress.progress += 0.04
            mainImageView.alpha += 0.03
        }
        else {
            UIView.animate(withDuration: 1, animations: {
                self.mainTimer.invalidate()
                let galleryVC = GalleryViewController()
                self.present(galleryVC, animated: true, completion: nil)
            })
        }
    }
}

