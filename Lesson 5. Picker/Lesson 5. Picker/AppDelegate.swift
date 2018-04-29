//
//  AppDelegate.swift
//  Lesson 5. Picker
//
//  Created by Anton Rubenchik on 28.04.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.

/*
1 повторить то, что было в уроке. - OK
2 Сделать пикер с выбором года, месяца, дня. Чтобы можно было выбрать дату и вывести её в label. - OK
3 Сделать пикер с выбором часов, минут, секунд. Выводить после выбора времени сообщение в alertview. - OK
4 В зависимости от выбранного года в пикере - переходим на другой контроллер и выводим там в label название: високосный это год или нет. - OK

 5 необязательное задание. Только для тех, кто хочет более глубокой прокачки навыков.

Создать шаблон регистрации нового пользователя:
1 контроллер: выбор между "клиент" и "разработчик".
Если выбран Клиент - переход на второй контроллер и заполнение 5 текстфилдов: имя, фамилия, пароль, номер банковской карты(4 любых цифры), и емейл.
+ кнопка Сохранить. После нажатия на неё вылетает alertview с сообщением
Если выбран Разработчик:
переход на второй контроллер и заполнение 7 текстфилдов: емейл, имя, фамилия, номер банковской карты, технология(к примеру ios, android, web), язык на котором пишет, опыт в годах.
+ кнопка Сохранить.
После нажатия на неё вылетает alertview с сообщением.
*/
//

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

