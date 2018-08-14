//
//  AppDelegate.swift
//  Basic Example
//
//  Created by Jonathan McCaffrey on 2018-08-14.
//  Copyright © 2018 Jonathan McCaffrey. All rights reserved.
//

import UIKit
import BrainCloud


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var bc: BrainCloudWrapper = BrainCloudWrapper();
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        AppDelegate.bc = BrainCloudWrapper()
        AppDelegate.bc.getBCClient().enableLogging(true)
        
        AppDelegate.bc.initialize("https://sharedprod.braincloudservers.com/dispatcherv2",
                                  secretKey: "921d9acc-e286-4b37-91b6-a394f4e6ff4f",
                                  gameId: "12049",
                                  gameVersion: "1.0.0",
                                  companyName: "brainCloud",
                                  gameName: "Basic - Swift")
        
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

