//
//  AppDelegate.swift
//  Lesson 11. UITabBarController and UITabBarItem
//
//  Created by Anton Rubenchik on 18.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//1) Номер шага (1 шаг из 10)
//2) Картинка подходящая под шаг (Допустим шаг разогреть воду - картинка кастрюля)
//3) Текстовое описание шага
//4) Внизу две кнопки (1- Предыдущий шаг 2-Следующий шаг) если шаг первый 1 кнопка скрыта, если шаг последний 2 скрыта
//5) Вверху должен быть Navigation Controller с картинкой и текстом + кнопка выхода из инструкции
//6) Реализовать таб бар меню на свой вкус и с своим функционалом)

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationViewController = UINavigationController()

    // Зарускается первым в приложении
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
       // let viewController = ViewController()
        let mainViewController = MainViewController()
        // navigationViewController = UINavigationController(rootViewController: viewController)
        // Override point for customization after application launch.

        window?.rootViewController = mainViewController//self.navigationViewController
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

