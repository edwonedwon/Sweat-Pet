//
//  TestInterfaceController.swift
//  Sweat Pet
//
//  Created by Edwon Edwon on 5/2/15.
//  Copyright (c) 2015 EDWON. All rights reserved.
//

import WatchKit
import Foundation

class TestInterfaceController: WKInterfaceController
{
    
    let watchUtil = WatchUtil()
    
    @IBAction func writeDataButton()
    {
        
    }
    
    @IBAction func readDataButton()
    {
        
    }
    
    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)
    }
    
    override func willActivate()
    {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate()
    {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}