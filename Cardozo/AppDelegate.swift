//
//  AppDelegate.swift
//  IOS-Base
//
//  Created by Caio Cardozo on 15/05/19.
//  Copyright © 2019 CaioCardozo. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import FirebaseMessaging
import FirebaseInstanceID

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    override init() {
        super.init()
        UIViewController.classInit
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setupFirstWindow()
        return true
    }
    
    private func setupFirstWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = HomeViewController()
        let nav = UINavigationController(rootViewController: homeViewController)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }
    
    // MARK: - Firebase
    func setupFirebase(){
        FirebaseApp.configure()
    }
    
    // MARK: - Firebase Push Notifications
    func setupFirebaseNotifications(app: UIApplication){
       
        setupFirebase()
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            app.registerUserNotificationSettings(settings)
        }
        
        app.registerForRemoteNotifications()
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

// MARK: - Firebase Messaging Delegate
extension AppDelegate : MessagingDelegate {
    func application(received remoteMessage: MessagingRemoteMessage) {
        
    }
    
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        // refresh token
    }
    
}
