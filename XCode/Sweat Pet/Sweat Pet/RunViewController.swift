import UIKit
import HealthKit
import SweatPetUtil

class RunViewController: UIViewController
{
    let healthManager = HealthManager()
        
    @IBOutlet weak var activeEnergyBurnedOutlet: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func ReadButtonAction(sender: AnyObject)
    {
        activeEnergyBurnedOutlet.text = healthManager.updateWeight()
    }
    
    @IBAction func AuthorizeButtonAction(sender: AnyObject)
    {
        
//        println("authorize healthkit")
        
        healthManager.authorizeHealthKit { (authorized,  error) -> Void in
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