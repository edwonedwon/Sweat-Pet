//
//  CyclingViewController.swift
//  Sweat Pet
//
//  Created by Macbook Steven on 9/28/14.
//  Copyright (c) 2014 EDWON. All rights reserved.
//

import UIKit
import SpriteKit

class CyclingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dipe()
    }

    @IBOutlet weak var PetViewOutlet: SKView!
    
    func dipe () {
        let scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .ResizeFill
        PetViewOutlet.presentScene(scene)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bicycleButtonAction(sender: AnyObject) {
        GameScene().switchImage()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}

