import WatchKit
import Foundation


class PetInterfaceController: WKInterfaceController
{
    
//    let sharedDefaults = NSUserDefaults(suiteName: "group.com.Edwon.Sweat-Pet.Sweat-Pet")
    
//    @IBOutlet weak var petImage: WKInterfaceImage!
    @IBOutlet weak var petImage: WKInterfaceGroup!

    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)
        
        // ANIMATE PET IDLE
        animatePet("pet_idle_", length: 50, duration: 1.5, repeatCount: 0)
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
    
    @IBAction func buttonFeed()
    {
        println("watch button!")
        
        var stringToSend = "the string"
        var floatToSend = Float(100)
        var parentValues = NSDictionary(objects: [stringToSend, floatToSend], forKeys: ["string", "float"])
        
        WKInterfaceController.openParentApplication(parentValues as [NSObject : AnyObject], reply: {(replyValues, error) -> Void in
            println(replyValues?["retVal1"])
            println(replyValues?["retVal2"])
        })
        
        // ANIMATE PET IDLE
        animatePet("pet_idle_", length: 50, duration: 1.5, repeatCount: 0)
    }
    
    @IBAction func buttonClean()
    {
        // ANIMATE PET EAT
        animatePet("pet_eat_", length: 33, duration: 0.8, repeatCount: 0)
    }
    
    func animatePet(animName: String, length: Int, duration:Float, repeatCount:Int)
    {
        self.petImage.setBackgroundImageNamed(animName)
        var durationTI = NSTimeInterval(duration)
        self.petImage.startAnimatingWithImagesInRange(NSMakeRange(Int(0), length), duration: durationTI, repeatCount: repeatCount)
    }
}
