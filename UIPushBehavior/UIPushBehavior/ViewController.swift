//
//  ViewController.swift
//  UIPushBehavior
//
//  Created by Anton Rubenchik on 07.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // UICollisionBehavior - обнаружение столкновений
    // UIGravityBehavior - обеспечивает тяготение
    // UIPushBehavior - реагирует на толчки
    // UISnapBehavior - крепим view  к определенной точке.
    
    // create dynamic elements
    var squareView = UIView()
    var squareViews = [UIDynamicItem]()
    var pushBehavior = UIPushBehavior()
    var animator = UIDynamicAnimator() // всегда присутствует. Любые view превращает в динамические элементы

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        createPush()
        //createTwoViewsWithGravitationAndCollision() // Придаем столкновению анимациию
        //createDynamicSquare()
    }
    
    fileprivate func createPush() {
        // create Push
        createGesture()
        createSquare()
        createCollisionAndPush()
    }
    
    func createSquare(){
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        squareView.backgroundColor = .green
        squareView.center = view.center
        view.addSubview(squareView)
    }
    
    // жест
    func createGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGesture) // сообщаем View что нужно реагировать на жест
    }
    
    @objc func tap(paramTap: UITapGestureRecognizer){
        let tapPoint = paramTap.location(in: view)

//          move view to tap position
//        squareView.center.x = tapPoint.x
//        squareView.center.y = tapPoint.y
        
        // Получаем угол куда двигаться. Между view.center и tap
        let squareViewCenterPoint: CGPoint = squareView.center
        let deltaX: CGFloat = tapPoint.x - squareViewCenterPoint.x
        let deltaY: CGFloat = tapPoint.y - squareViewCenterPoint.y
        let angle: CGFloat = atan2(deltaY,deltaX)
        // Придаем угол движения
        pushBehavior.angle = angle
        
        let distanseBeetwinPoints : CGFloat = sqrt(pow(tapPoint.x - squareViewCenterPoint.x, 2.0) + pow(tapPoint.y - squareViewCenterPoint.y,2.0))
        // скорость полета, зависит от растояния между объектами
        pushBehavior.magnitude = distanseBeetwinPoints / 200
        
        
    }
    
    // create collision and push  view
    func createCollisionAndPush() {
        animator = UIDynamicAnimator(referenceView: view)
        let collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        pushBehavior = UIPushBehavior(items: [squareView], mode: .continuous)
        animator.addBehavior(collision)
        animator.addBehavior(pushBehavior)
    }
   
    fileprivate func createDynamicSquare() {
        //созадаем квадрат
        squareView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        squareView.backgroundColor = .green
        squareView.center = view.center
        view.addSubview(squareView)
        
        //создаем аниматор тяготения
        animator = UIDynamicAnimator(referenceView: view) // заставляем анимироваться нашу view
        let gravity = UIGravityBehavior(items: [squareView])
        animator.addBehavior(gravity)
    }
    
    fileprivate func createTwoViewsWithGravitationAndCollision() {
        // create views
        
        let numberOfViews = 2
        squareViews.reserveCapacity(numberOfViews) //
        var colors = [UIColor.red,UIColor.blue]
        var currentCenterPoint: CGPoint = view.center
        let eachViewSize = CGSize(width: 100, height: 100)
        
        
        for i in 0...numberOfViews - 1 {
            let newView = UIView()
            newView.backgroundColor = colors[i]
            newView.frame = CGRect(x: 0, y: 0, width: eachViewSize.width, height: eachViewSize.height)
            newView.center = currentCenterPoint
            currentCenterPoint.y -= eachViewSize.height + 250
            //   currentCenterPoint.x -= 90
            view.addSubview(newView)
            squareViews.append(newView)
        }
        
        // create dynamic
        animator = UIDynamicAnimator(referenceView: view) // делаем view анимированной
        
        // создаем тяготение
        let gravitation = UIGravityBehavior(items: squareViews) // придаем массиву View гравитацию
        animator.addBehavior(gravitation) // Придаем гравитации анимациию
        
        // реализуем столкновения. друг с другом и c bounds
        
        let collision = UICollisionBehavior(items: squareViews) // придаем массиву View анализ солкновений
        collision.translatesReferenceBoundsIntoBoundary = true // не вываливаться за край экрана
        // меняем границу "земли"
        collision.addBoundary(withIdentifier: "footerLine" as NSCopying,
                              from: CGPoint(x: 0, y: view.bounds.height - 100),
                              to: CGPoint(x: view.bounds.width, y: view.bounds.height - 100))
        
        collision.collisionDelegate = self
        animator.addBehavior(collision)
    }
   
}
extension ViewController: UICollisionBehaviorDelegate {
    // что делать при столкновении
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        
        let newIdentifier = identifier as? String
        let oldIdentifier = "footerLine"
        
        if newIdentifier == oldIdentifier {
            UIView.animate(withDuration: 1.0,
                           animations: {
                            let view = item as? UIView
                            view?.backgroundColor = UIColor.green
                            view?.alpha = 0.0
                            view?.transform = CGAffineTransform(scaleX: 0.7, y: 2.0)
                            }) { (finished) in
                                let view = item as? UIView
                                behavior.removeItem(item) // удаляем динамику у view
                                 view?.removeFromSuperview() // удаляем view
                            }
        }
    }
}

