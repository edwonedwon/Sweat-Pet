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
    let petControl = PetController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        petControl.updateAge()
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

}
