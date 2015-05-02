//
//  WatchUtil.swift
//  Sweat Pet
//
//  Created by Edwon Edwon on 4/21/15.
//  Copyright (c) 2015 EDWON. All rights reserved.
//

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
}