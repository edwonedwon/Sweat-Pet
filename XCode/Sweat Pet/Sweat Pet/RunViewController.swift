import UIKit
import HealthKit

class RunViewController: UIViewController
{
    
    let healthManager:HealthManager = HealthManager()
    
    @IBOutlet weak var activeEnergyBurnedOutlet: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func ReadButtonAction(sender: AnyObject) {
        println(healthManager.readEnergy())
        self.activeEnergyBurnedOutlet.text = healthManager.readEnergy() as? String
    }
    
    @IBAction func AuthorizeButtonAction(sender: AnyObject) {
                
        healthManager.authorizeHealthKit{ (authorized,  error) -> Void in
            if authorized {
                println("HealthKit authorization received.")
            }
            else
            {
                println("HealthKit authorization denied!")
                if error != nil {
                    println("\(error)")
                }
            }
        }
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