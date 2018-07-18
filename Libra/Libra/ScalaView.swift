//
//  ScalaView.swift
//  Libra
//
//  Created by Anton Rubenchik on 15.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

@IBDesignable
class ScalaView: UIView {
    var weight: Int = 0
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext() // получаем контекст гда будем рисовать
        context?.setStrokeColor(UIColor.red.cgColor) //цвет
        context?.setLineWidth(14.0)// ширина
        context?.addArc(center: CGPoint(x: self.bounds.width / 2,y: self.bounds.height / 2), radius: self.bounds.width / 2 - 14, startAngle: 0, endAngle: 2 * CGFloat(M_PI), clockwise: true)
        
        context?.strokePath() // Выводим на экран
        
        context?.setLineWidth(1.0)
        context?.setStrokeColor(UIColor.lightGray.cgColor)
        context?.addArc(center: CGPoint(x: self.bounds.width / 2,y: self.bounds.height / 2), radius: self.bounds.width / 4, startAngle: 0, endAngle: 2 * CGFloat(M_PI), clockwise: true)
        //        context?.setStrokeColor(UIColor.blue.cgColor) //цвет
        //        context?.addRect(CGRect(x: 10, y: 10, width: 100, height: 100))
        context?.strokePath() // Выводим на экран
        if weight > 0 {
            print("true")
            context?.setLineWidth(1.0)
            context?.setStrokeColor(UIColor.blue.cgColor) //цвет
            context?.addRect(CGRect(x: 10, y: 10, width: 100, height: 100))
            context?.strokePath() // Выводим на экран
        }
        else {
            print("false")
        }
    }
}
