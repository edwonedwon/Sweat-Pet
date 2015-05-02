//  AppDelegate.swift
//  Sweat Pet
//
//  Created by Macbook Steven on 9/28/14.
//  Copyright (c) 2014 EDWON. All rights reserved.
//

import UIKit
import CoreData
import SweatPetUtil

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    
    let petControl = PetController()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // IF NO PET MAKE A NEW PET
        if (!petControl.doHavePet())
        {
            petControl.newPet()
        }
        
        /* First ask the user if we are
        allowed to perform local notifications */
//        let settings = UIUserNotificationSettings(forTypes: .Alert,
//            categories: nil)
//        
//        application.registerUserNotificationSettings(settings)
        
        return true
    }
    
    // Schedule Notifications
//    func application(application: UIApplication,
//        didRegisterUserNotificationSettings
//        notificationSettings: UIUserNotificationSettings){
//            
//            if notificationSettings.types == nil{
//                /* The user did not allow us to send notifications */
//                return
//            }
//            
//            let notification = UILocalNotification()
//            
//            /* Time and timezone settings */
//            
//            notification.fireDate = NSDate(timeIntervalSinceNow: 4)
//            notification.timeZone = NSCalendar.currentCalendar().timeZone
//            
//            notification.alertBody = "A new item is downloaded"
//            
//            /* Action settings */
//            notification.hasAction = true
//            notification.alertAction = "View"
//            
//            /* Badge settings */
//            notification.applicationIconBadgeNumber++
//            
//            /* Additional information, user info */
//            notification.userInfo = [
//                "Key 1" : "Value 1",
//                "Key 2" : "Value 2"
//            ]
//            
//            /* Schedule the notification */
//            application.scheduleLocalNotification(notification)
//            
//    }

    
    // App Delegate to handle WatchKit Extension Requests
    func application(application: UIApplication,
        handleWatchKitExtensionRequest userInfo: [NSObject : AnyObject]?,
        reply: (([NSObject : AnyObject]!) -> Void)!) {
        
        NSLog("message recieved")
        
        // retrieved parameters from apple watch
        if let userInfo = userInfo, request = userInfo["string"] as? String
        {
           NSLog(request as String)
        }
        
        if let userInfo = userInfo, request = userInfo["float"] as? Float
        {
            NSLog(request.description)
        }
            
        if let userInfo = userInfo, request = userInfo["statsString"] as? String
        {
            NSLog(request as String)
        }
        
        // pass back values to Apple Watch
            var retValues =
            [
                "retVal1": "return Test 1 dipe",
                "retVal2": "return Test 2 dipe",
                "age": 200
            ]
        
        reply(retValues)

        // GET VIEW CONTROLLER
        let app = UIApplication.sharedApplication()
        var window = app.windows[0] as! UIWindow
        if let viewControllers = window.rootViewController?.childViewControllers
        {
            println("1")
            for viewController in viewControllers
            {
                if viewController.isKindOfClass(InfoViewController)
                {
                    NSLog("Found info view!!!")
                    // TODO - change the label on infoViewController to say something
                    
                    var infoViewController = viewController as! InfoViewController
                    if let testLabel = infoViewController.testLabel
                    {
                        infoViewController.testLabel.text = "dipe is soooo fresh"
                    }
                }
            }
        }
        
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }

}

