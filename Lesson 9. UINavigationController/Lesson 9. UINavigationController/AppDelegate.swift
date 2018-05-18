//
//  AppDelegate.swift
//  Lesson 9. UINavigationController
//
//  Created by Anton Rubenchik on 17.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//1+ Повторить то что было в уроке.
//2+ Создать полностью кастомный нав бар.
//3+ barButtonItem тоже сделать кастомным .
//4. При скроле вверх сделать UINavigationConroller прозрачным.
//5+ А во втором VC по умолчанию сделать прозрачным.
//6+ Сделать так что б status bar в одном VC был белый а в другом черный.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? //Первое окно, на него все накладывается
    var navigationController = UINavigationController()

    // запуск приложения в этом методе
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // create rootViewController - первый обязательно должен быть
        let viewController = ViewController()
        self.navigationController = UINavigationController(rootViewController: viewController)
        // color item navigation bar
        UINavigationBar.appearance().tintColor = UIColor(red:   63/255, green: 129/255, blue:  198/255, alpha: 1)
        // Color Title Navigation bar
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

        // background
        UINavigationBar.appearance().barTintColor = UIColor(red:   41/255, green: 43/255, blue:  53/255, alpha: 1)
        

        
        // привязываем NavigationController к Window
        self.window = UIWindow(frame: UIScreen.main.bounds) // UIScreen - ствойства аппаратного дисплея main - наш девайс (IPhone6/5/8) bounds - размеры экрана девайся. Чтобы не высчитывать maxX и maxY
        self.window?.rootViewController = self.navigationController    // корневой контроллер для окна, с которого он запускается
        self.window?.backgroundColor = UIColor.darkGray
        self.window?.makeKeyAndVisible() // Аналог present для ViewController

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

