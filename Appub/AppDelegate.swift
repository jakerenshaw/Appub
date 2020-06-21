//
//  AppDelegate.swift
//  Appub
//
//  Created by Jake Renshaw on 20/06/2020.
//  Copyright © 2020 Jake Renshaw. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        //self.registerForAppNotifications()
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}

}

extension AppDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
       let tokenParts = deviceToken.map({ data in String(format: "%02.2hhx", data) })
       let token = tokenParts.joined()
       print("token = \(token)")
        let _ = PushNotification()
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
       print("Failed to register with error = \(error)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    
    func registerForAppNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
           guard granted else {
               return
           }
           print("permission granted")
           self.getNotificationSettings()
        }
    }

    func getNotificationSettings() {
       UNUserNotificationCenter.current().getNotificationSettings { (settings) in
           guard settings.authorizationStatus == .authorized else {
               return
           }
           DispatchQueue.main.async {
               UIApplication.shared.registerForRemoteNotifications()
           }
       }
    }
}

