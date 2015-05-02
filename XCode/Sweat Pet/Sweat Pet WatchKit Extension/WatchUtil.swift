//
//  WatchUtil.swift
//  Sweat Pet
//
//  Created by Edwon Edwon on 4/21/15.
//  Copyright (c) 2015 EDWON. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class WatchUtil
{
    let appGroupID = "group.com.Edwon.Sweat-Pet"

    func writeSharedData ()
    {
        if let defaults = NSUserDefaults(suiteName: appGroupID)
        {
            defaults.setValue(String("sodipeinhere"), forKey: "dipeString")
        }
    }
    
    func readSharedData ()
    {
        let defaults = NSUserDefaults(suiteName: appGroupID)
        if let dipe = defaults?.stringForKey("dipeString") 
        {
            println(dipe)
        }
    }
    
    func readAge () -> Double?
    {
        updateAge()
        let defaults = NSUserDefaults(suiteName: appGroupID)
        if let age = defaults?.doubleForKey("age")
        {
            println(age)
            return age
        }
        return nil
    }
    
    func updateAge ()
    {
        if let defaults = NSUserDefaults(suiteName: appGroupID)
        {
            var now = NSDate()
            var timeSinceBirth = NSTimeInterval()
            
            //fetch the birthday from shared data
            if let birthday = defaults.objectForKey("birthday") as? NSDate
            {
                println("birthday: " + birthday.description)
                // get the interval between birth and now
                timeSinceBirth  = now.timeIntervalSinceDate(birthday)
                saveAge(timeSinceBirth)
            }
        }
    }
    
    func saveAge (age:Double)
    {
        // set the age value on the pet
        if let defaults = NSUserDefaults(suiteName: appGroupID)
        {
            defaults.setValue(age, forKey: "age")
        }
    }
}