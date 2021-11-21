//
//  AppDelegate.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/06/29.
//

import Firebase
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let notificationOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])

        UNUserNotificationCenter.current().requestAuthorization(options: notificationOptions) { _, error in
            if let error = error {
                print(#function, error)
            }
        }

        application.registerForRemoteNotifications()
        FirebaseApp.configure()

        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    /// foreground 상태일 때 push 알림 받음
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo, "👅 FOREGROUND!")

        /// 애널리틱스에 전달
        Messaging.messaging().appDidReceiveMessage(userInfo)
        completionHandler([.list, .badge, .sound, .banner])
    }

    /// background일 때
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        UIApplication.shared.applicationIconBadgeNumber = 0

        let userInfo = response.notification.request.content.userInfo
        guard (userInfo["aps"] as? [String: AnyObject]) != nil else { return }
        print(userInfo, "👅")

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            NotificationCenter.default.post(name: Notification.Name.pushPresent, object: nil)
        }

        Messaging.messaging().appDidReceiveMessage(userInfo)
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    /// 현재 등록 토큰 가져오기 (갱신 시 알림 받기)
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("🥺 [fcm token]: ", fcmToken)
        guard let token = fcmToken else { return }

        UserService.shared.registerFCMToken(token: fcmTokenRequest(pushToken: token))
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo, "💬")
        Messaging.messaging().appDidReceiveMessage(userInfo)

        completionHandler(UIBackgroundFetchResult.newData)
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        UIInterfaceOrientationMask.portrait
    }
}
