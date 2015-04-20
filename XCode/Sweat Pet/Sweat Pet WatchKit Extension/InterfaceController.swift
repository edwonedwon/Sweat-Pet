//
//  InterfaceController.swift
//  Sweat Pet WatchKit Extension
//
//  Created by Edwon Edwon on 4/17/15.
//  Copyright (c) 2015 EDWON. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
//    let sharedDefaults = NSUserDefaults(suiteName: "group.com.Edwon.Sweat-Pet.Sweat-Pet")

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func getDataFromParentApp(image: String)
    {
        let dictionary = ["Desired Word":image]
        WKInterfaceController.openParentApplication(dictionary) {
            (replyInfo, error) -> Void in
            println("dipe")
        }
    }

    @IBAction func buttonAction()
    {
        println("watch button!")
        
//        var parentValues = Dictionary<String,String>()
//        parentValues["testVal1"] = "parent Test 1"
//        parentValues["testVal2"] = "parent Test 2"
        
        var tempString = "it worked, and I hate life so much right now"
        var parentValues = NSDictionary(objects: [tempString], forKeys: ["type"])
        
        WKInterfaceController.openParentApplication(parentValues as [NSObject : AnyObject], reply: {(replyValues, error) -> Void in
            println(replyValues?["retVal1"])
            println(replyValues?["retVal2"])
        })
        
    }
    
}
