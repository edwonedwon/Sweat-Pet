import UIKit
import SpriteKit
import SweatPetUtil

class PetViewController: UIViewController
{
    
    let petControl = PetController()
    
    @IBOutlet weak var ageNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ageNumberLabel.text = petControl.readAgeDaysString()
        ageNumberLabel.sizeToFit() // make the age label resize if the number gets longer
        sceneSetup()        
    }

    @IBOutlet weak var PetViewOutlet: SKView!
    
    func sceneSetup () {
        let scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .ResizeFill
        PetViewOutlet.presentScene(scene)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func vialButtonAction(sender: AnyObject)
    {
        println("touched vial")
        NSLog("touched vial nslog")
//        petController.birth()
    }
    
}

