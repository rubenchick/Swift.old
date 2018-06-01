//
//  AppDelegate.swift
//  Lesson 19. UIProgress
//
//  Created by Anton Rubenchik on 31.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//ДЗ 19 
//1) Повторить все что было в уроке
//2) Прочитать документацию по данным темам
//
//3) Создать экран загрузки приложения:
//с использованием UIProgressView, Timer + UIImageVIew
//по мере увеличения значения UIProgressView увеличивать значение alpha у UIImageView
//(Получиться некая имитация загрузки картинки из интернета)
//Когда значение UIProgressView будет максимальным - перейти на второй экран
//
//4) Создать второй экран:
//с использованием UIImageView от 4 штук
//по нажатию на картинку, у нас в UserDefaults записывается это картинка
//и при последующем запуске приложении картинка меняется на вырбранную
//
//5) Использовать контроль доступа в каждом классе/проперти/функции такие как:
//public class SomePublicClass {}
//internal class SomeInternalClass {}
//fileprivate class SomeFilePrivateClass {}
//private class SomePrivateClass {}
//
//public var somePublicVariable = 0
//internal let someInternalConstant = 0
//fileprivate func someFilePrivateFunction() {}

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

