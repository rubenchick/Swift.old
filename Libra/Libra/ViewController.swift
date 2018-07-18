//
//  ViewController.swift
//  Libra
//
//  Created by Anton Rubenchik on 15.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import AudioToolbox
//var isPut: Bool?
class ViewController: UIViewController {

    @IBOutlet weak var scalarView: ScalaView!
    @IBOutlet weak var weightLabel: UILabel!
    var isPlaySound = true
    
    let circleView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    
    var isUpdate = true {
        didSet {
            if isUpdate == false {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.isUpdate = oldValue
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        isPut = false
        weightLabel.text = "0 грамм"
        
        circleView.layer.cornerRadius = 40
        circleView.alpha = 0.3
        circleView.backgroundColor = UIColor.red
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            circleView.center = touch.location(in: view)
            view.addSubview(circleView)
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if #available(iOS 9.0, *) {
                // поддерживает ли экран 3D
                if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                    if touch.force <= touch.maximumPossibleForce {
                        let randomIntFrom0To10 = Int(arc4random_uniform(UInt32(10)))
                        if randomIntFrom0To10 == 2 {
                            let force = (touch.force / touch.maximumPossibleForce) * 100
                            let grams = Int(force * 385 / 100)
                            weightLabel.text = "\(grams) грамм"
                            isPlaySound = true
                            
                            if isUpdate {
                                circleView.transform = CGAffineTransform.init(scaleX: CGFloat(1 + (grams / 5) / 20), y: CGFloat(1 + (grams / 5) / 20))
                                isUpdate = false
                            }
                        }
                    } else {
                        weightLabel.text = "385 грамм"
                        if isPlaySound {
                            AudioServicesPlaySystemSound(1519)
                            isPlaySound = false
                        }
                    }
                }
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        weightLabel.text = "0 грамм"
        circleView.removeFromSuperview()
        circleView.transform = .identity
//        isPut = false
    }



}

