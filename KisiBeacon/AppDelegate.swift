//
//  AppDelegate.swift
//  KisiBeacon
//
//  Created by Suyash Taneja on 04/11/17.
//  Copyright © 2017 Suyash Taneja. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LaunchScreen")
        window?.rootViewController = viewController
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LaunchScreen")
        window?.rootViewController = viewController
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
//        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "LaunchScreen")
//        window?.rootViewController?.present(viewController, animated: false, completion: nil)
//
//        Timer.scheduledTimer(withTimeInterval: 4.5, repeats: false, block: { (timer) in
//            viewController.dismiss(animated: false, completion: nil)
//        })
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        setupBeaconManager()
        
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false, block: { (timer) in
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarViewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBar")
            self.window?.rootViewController = tabBarViewController
        })
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate {
    func setupBeaconManager() {
        BeaconManager.shared.beaconInRange = { (clBeacon) in
            KisiDoorManager.shared.unlockDoor(clBeacon: clBeacon, completion: { (success, error) in
                
            })
        }
    }
}
