import UIKit
import SpriteKit

class PetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
}

