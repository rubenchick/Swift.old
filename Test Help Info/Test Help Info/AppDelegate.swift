//
//  AppDelegate.swift
//  Test Help Info
//
//  Created by Anton Rubenchik on 08/01/2019.
//  Copyright © 2019 Anton Rubenchik. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // part 1. take agree.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,]) { (autorization: Bool, error: Error? ) in
            if !autorization {
                print("App is unless because you did not allow notification")
            }
        }
        
        // Define Action
        let doneAction = UNNotificationAction(identifier: "addDone", title: "Done", options: [])
        let cancelAction = UNNotificationAction(identifier: "addCancel", title: "Cancel", options: [])
        let repeatAction = UNNotificationAction(identifier: "addRepeat", title: "Repeat from 10 min", options: [])
        
        // Add action to Catagory
        let category = UNNotificationCategory(identifier: "actionCategory", actions: [doneAction,cancelAction,repeatAction], intentIdentifiers: [], options: [])
        
        // Add category to Natification FrameWork
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        return true
    }
    
    func schedularNotification() {
        UNUserNotificationCenter.current().delegate = self
        
        
        // First Notification
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
//        let date = Date()
//        let calendar = Calendar.current
//
//        let hour = calendar.component(.hour, from: date)
//        let minutes = calendar.component(.minute, from: date)
//        let seconds = calendar.component(.second, from: date)
//        print("hours = \(hour):\(minutes):\(seconds)")
        
        
//        let x = DateComponents(minute: minutes + 1)
        let fisrtTime = DateComponents(second: 10)
        let firstTrigger = UNCalendarNotificationTrigger(dateMatching: fisrtTime, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "Пришло время ..."
        content.sound = UNNotificationSound.default
        content.body = "Полить цветы"
        content.subtitle = "Не пререлить"
        content.categoryIdentifier = "actionCategory"
        
//        guard let path = Bundle.main.path(forResource: "icon1024", ofType: "png") else {return}
//        let url = URL(fileURLWithPath: path)
//        
//        do {
//            let attachment = try UNNotificationAttachment(identifier: "logo", url: url, options: nil)
//            content.attachments = [attachment]
//        } catch {
//            print("The attechment could not loaded")
//            
//        }
//
////        let request = UNNotificationRequest(identifier: "myNotification", content: content, trigger: trigger2)
//        let firstRequest = UNNotificationRequest(identifier: "firstNotification", content: content, trigger: firstTrigger)
//
////        let req = UNNotificationRequest(identifier: "dd", content: UNNotificationContent, trigger: <#T##UNNotificationTrigger?#>)
////        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: <#T##[String]#>)
//
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//        UNUserNotificationCenter.current().add(firstRequest) { (error:Error?) in
//            if let error = error {
//                print("Error - \(error.localizedDescription)")
//            }
//        }
        
        let secondTime = DateComponents(second: 30)
        let secondTrigger = UNCalendarNotificationTrigger(dateMatching: secondTime, repeats: true)
        
        let content2 = UNMutableNotificationContent()
        content2.title = "Пришло время ..."
        content2.sound = UNNotificationSound.default
        content2.body = "Выпить таблетку"
        content2.subtitle = "За 30 минут до еды"
        content2.categoryIdentifier = "actionCategory"
        
//        guard let path2 = Bundle.main.path(forResource: "icon1024", ofType: "png") else {return}
//        let url2 = URL(fileURLWithPath: path2)
//
//        do {
//            let attachment = try UNNotificationAttachment(identifier: "logo", url: url2, options: nil)
//            content2.attachments = [attachment]
//        } catch {
//            print("The attechment could not loaded")
//
//        }

        let secondRequest = UNNotificationRequest(identifier: "secondNotification", content: content2, trigger: secondTrigger)
        
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(secondRequest) { (error:Error?) in
            if let error = error {
                print("Error - \(error.localizedDescription)")
            }
        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Start. Did")
        switch response.actionIdentifier {
        case "addDone":  print("add Done")
        case "addCancel":
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["secondNotification"])
            print("original identifier was : \(response.notification.request.identifier)")
            print("original body was : \(response.notification.request.content.body)")
        case "addRepeat":  print("add Repeat")
        default:
            return
        }
//        schedularNotification()
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Start. Will")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        print("Start. Open")
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Test_Help_Info")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

