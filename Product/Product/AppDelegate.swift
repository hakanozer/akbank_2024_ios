//
//  AppDelegate.swift
//  Product
//
//  Created by HAKAN ÖZER on 28.02.2024.
//

import UIKit
import SQLite

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    let center = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.badge, .alert, .sound]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        databaseTableCreate()
        
        center.delegate = self
        
        // Notification Permission
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                self.center.requestAuthorization (options: self.options) { accept, error in
                    if !accept {
                        print("Permission Error")
                    }else {
                        print("Permission Success")
                    }
                }
            }
        }
        
        
        return true
    }
    
    func databaseTableCreate() {
        print(Util.sqlitePath)
        let db = try! Connection(Util.sqlitePath)
        let likes = Table("likes")
        do {
            let lid = Expression<Int64>("lid")
            let pid = Expression<Int64>("pid")
            try db.run(likes.create(ifNotExists: true, block: { t in
                t.column(lid, primaryKey: true)
                t.column(pid)
            }))
        }catch {
            print(error)
        }
    }
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    /*
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        print("this line call")
    }
     */
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        center.setBadgeCount(0)
        let content = response.notification.request.content
        let dic = content.userInfo as! Dictionary<String, Any>
        print("Product: \(dic["product"]!)")
    }
     


}

