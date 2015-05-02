////
////  PetController.swift
////  Sweat Pet
////
////  Created by Edwon Edwon on 4/13/15.
////  Copyright (c) 2015 EDWON. All rights reserved.
////
//import UIKit
//import CoreData
//
//class PetController
//{
//    // App Group ID for shared data between phone and watch apps
//    let appGroupID = "group.com.Edwon.Sweat-Pet"
//    
//    func doHavePet() -> Bool
//    {
//        let defaults = NSUserDefaults(suiteName: appGroupID)
//        if let birthday = defaults?.objectForKey("birthday") as? NSDate
//        {
//            return true
//        }
//        return false
//    }
//    
//    func newPet ()
//    {
//        // write data to the shared data for phone and watch apps
//        if let defaults = NSUserDefaults(suiteName: appGroupID)
//        {
//            defaults.setValue(0, forKey: "age") // set age to 0
//            defaults.setObject(NSDate(), forKey: "birthday") // set birthday to now
//            var format = NSDateFormatter()
//            format.dateStyle = NSDateFormatterStyle.ShortStyle
//            format.timeStyle = NSDateFormatterStyle.LongStyle
//
//            // DEBUG
//            println("Made a new pet!")
//            println("my birthday is: " + format.stringFromDate(NSDate()))
//            println("my age is 0!")
//
//        }
//    }
//    
//    func readAge () -> Double?
//    {
//        updateAge()
//        let defaults = NSUserDefaults(suiteName: appGroupID)
//        if let age = defaults?.doubleForKey("age")
//        {
//            println(age)
//            return age
//        }
//        return nil
//    }
//    
//    func readAgeDaysString () -> String?
//    {
//        let formatter = NSNumberFormatter()
//        formatter.maximumFractionDigits = 0;
//        let age = readAge()!
//        let ageDays = daysFromTimeInterval(age)
//        let ageString = formatter.stringFromNumber(ageDays)
//        return(ageString)
//    }
//    
//    private func updateAge ()
//    {
//        if let defaults = NSUserDefaults(suiteName: appGroupID)
//        {
//            var now = NSDate()
//            var timeSinceBirth = NSTimeInterval()
//            
//            //fetch the birthday from shared data
//            if let birthday = defaults.objectForKey("birthday") as? NSDate
//            {
//                println("birthday: " + birthday.description)
//                // get the interval between birth and now
//                timeSinceBirth  = now.timeIntervalSinceDate(birthday)
//                saveAge(timeSinceBirth)
//            }
//        }
//    }
//    
//    func saveAge (age:Double)
//    {
//        // set the age value on the pet
//        if let defaults = NSUserDefaults(suiteName: appGroupID)
//        {
//            defaults.setValue(age, forKey: "age")
//        }
//    }
//    
//    func daysFromTimeInterval(interval:NSTimeInterval) -> Int
//    {
//        var ti = NSInteger(interval)
//        return (ti / 86400)
//    }
//    
//    func stringFromTimeInterval(interval:NSTimeInterval) -> NSString {
//        
//        var ti = NSInteger(interval)
//        
//        var ms = Int((interval % 1) * 1000)
//        
//        var seconds = ti % 60
//        var minutes = (ti / 60) % 60
//        var hours = (ti / 3600)
//        var days = (ti / 86400)
//        
//        return NSString(format: "D:%0.2d: H:%0.2d: M:%0.2d: S:%0.2d.%0.3d",days,hours,minutes,seconds,ms)
//    }
//
//}
