//
//  InfoViewController.swift
//  Sweat Pet
//
//  Created by Edwon Edwon on 4/13/15.
//  Copyright (c) 2015 EDWON. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController
{
    
//    required init(coder aDecoder: NSCoder)
//    {
//        println("dipe")
//        super.init(coder: aDecoder)
//    }
    
    var timer: NSTimer?
    
    let petControl = PetController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("view did load")
    }
    
    deinit
    {

    }
    
    override func viewDidAppear(animated: Bool)
    {
        dispatch_async(dispatch_get_main_queue(),
        {
            self.startUIUpdateTimer()
        })
    }
    
    override func viewDidDisappear(animated: Bool)
    {
        timer?.invalidate()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var testLabel: UILabel!
    
    func testLabelChange ()
    {

        self.testLabel.text = "dipe"
//        println("dipetastic")
    }
    
    func startUIUpdateTimer() {
        // NOTE: For our purposes, the timer must run on the main queue, so use GCD to make sure.
        //       This can still be called from the main queue without a problem since we're using dispatch_async.
        dispatch_async(dispatch_get_main_queue())
        {
            // Start a timer that calls self.updateUI() once every tenth of a second
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector:"updateUI", userInfo: nil, repeats: true)
        }
    }
    
    func updateUI()
    {
        petControl.updateAge()
        var ageRaw = petControl.readAge()
        var ageString = petControl.stringFromTimeInterval(ageRaw)
        ageLabel.text = "Pet's Age: " + (ageString as String)
    }

}
