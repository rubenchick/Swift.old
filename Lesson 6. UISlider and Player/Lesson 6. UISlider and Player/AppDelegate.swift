//
//  AppDelegate.swift
//  Lesson 6. UISlider and Player
//
//  Created by Anton Rubenchik on 04.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
/*
 Техническое задание.
Приложение "Мой профиль".
3 экрана.

1 экран -логин.
2 textfield для ввода емейл и пароля.
1 кнопка "Войти".

2 экран - настройки.

1 label с надписью "Выбрать пол". Напротив него - picker. в пикере 3 варианта: М,Ж, unknown.
2 textfiled - имя и ник.
1 slider - нажимая на который, можно менять цвет экрана.
1 кнопка "Сохранить".

3 экран - просто label с надписью "Игрок создан".

Дополнительно:
Добавьте какие-то свои фишки. Например: почитать в google как сохранять данные так, чтобы при следующем входе они опять отображались в профиле.
 */

/*
 Попробуйте сделать плеер, о котором говорились в видео.
 🚀 Включаемся, настраиваем фантазию, делаем свои крутые фишки - улетаем к трудоустройству и высокой зарплате!
 Придумайте свои фишки в дополнение. Креатив и ios-разработка - ходят за руку!
 */

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

