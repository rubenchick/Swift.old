//
//  SecondViewController.swift
//  TestForDocumentation
//
//  Created by Anton Rubenchik on 18.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    var image = UIImage()
    var imageView = UIImageView()
    var text = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createStartElements()

    }
    
    fileprivate func createStartElements() {
        // createTitleImage
        let helpImageView = UIImageView()
        helpImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        helpImageView.contentMode = .scaleAspectFit
        let helpImage = UIImage(named: "rubik_small")
        helpImageView.image = helpImage
        self.navigationItem.titleView = helpImageView
        
//        // create Image
//        image = UIImage(named: "rubik_big")!
//        imageView.image = image
//        imageView.frame = CGRect(x: view.frame.midX - 128, y: view.frame.midY - 128, width: 256, height: 256)
//        view.addSubview(imageView)
        // add TextView
        text.text = "Расшифровка формулы:\n\nCтороны:\n\nФ - Фасад\nП - Правая сторона\nЛ - Левая сторона\nН - Низ\nВ - Верх\n\nПовороты:\n\nП - по часовой стрелке правую сторону\nП' - против часовой стрелка правую\nП'' - повернуть правую на 180 градусов"
        text.frame = CGRect(x: 20, y: 80, width: view.frame.maxX-40, height: view.frame.height - 160)
        text.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(text)
        
    }


}
/*
 //        let txt    = "Этапы сборки:\n1. крест в первом слое;\n2. углы первого слоя;\n\3. рёбра среднего слоя;\n4. крест в последнем слое;\n        5. расстановка рёбер последнего слоя;\n6. расстановка углов последнего слоя;\n7. разворот углов последнего слоя.\n\n Формулы:\n\nCтороны:\n\nФ - Фасад\nП - Правая сторона\nЛ - Левая сторона\nН - Низ\nВ - Верх\n\nПовороты:\n\nП - по часовой стрелке правую сторону\nП' - против часовой стрелка правую\nП'' - повернуть правую на 180 градусов"
 */
