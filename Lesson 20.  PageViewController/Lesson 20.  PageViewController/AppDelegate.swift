//
//  AppDelegate.swift
//  Lesson 20.  PageViewController
//
//  Created by Anton Rubenchik on 07.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//1) Повторить что было в уроке

//2) Прочитать официальную документацию Apple
//UIPageViewController —- https://developer.apple.com/documentation/uikit/uipag..
//Lazy Stored Properties —- https://developer.apple.com/library/content/documenta..
//
//3) Создать экран приветствия "Инструкция по приложению" (За пример можно взять телеграмм, для просмотра необходимо выйти из своего аккаунта)
//
//4) Сделать верстку под все экраны, с помощью constrraints в коде! (выложить скрины 4s, SE, 8, 8 plus, X)
//
//5) Добавить анимацию на каждом этапе инструкции
//
//Дополнительно: Написать как лучше листать картинки через UIPageViewController / UIScrollVIew, какой способ удобней и чем. Можно ли использовать let weak ? Почему можно/нельзя ? Когда лучше использовать lazy ?

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // create PageViewController
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = PageViewController()
  
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

