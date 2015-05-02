import WatchKit
import Foundation


class PetInterfaceController: WKInterfaceController
{
    
    var isDrinking = false
    
//    let sharedDefaults = NSUserDefaults(suiteName: "group.com.Edwon.Sweat-Pet.Sweat-Pet")
    
    @IBOutlet weak var petImage: WKInterfaceGroup!
    
    @IBAction func feedButtonAction()
    {
        if (!isDrinking)
        {
            isDrinking = Bool(true)
            animatePet("pet_drink_begin_", length: 21, duration: 0.9, repeatCount: 1)
            var timer = NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: Selector("drinkAnim1"), userInfo: nil, repeats: false)
        }
    }
    
    func drinkAnim1()
    {
        animatePet("pet_drink_", length: 50, duration: 1.6, repeatCount: 2)
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.6, target: self, selector: Selector("drinkAnim2"), userInfo: nil, repeats: false)
    }
    
    func drinkAnim2()
    {
        animatePet("pet_drink_finish_", length: 46, duration: 1.5, repeatCount: 0)
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: Selector("idleAnim"), userInfo: nil, repeats: false)
    }
    
    func idleAnim ()
    {
        petImage.setBackgroundImageNamed("pet_idle_16")
//        animatePet("pet_idle_", length: 50, duration: 1.5, repeatCount: 0)
        isDrinking = Bool(false)
    }
    
    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)

        // ANIMATE PET IDLE
        idleAnim()
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
        
//         ANIMATE PET IDLE
//        animatePet("pet_idle_", length: 50, duration: 1.5, repeatCount: 0)
    }
    
    @IBAction func buttonClean()
    {
        // ANIMATE PET EAT
        idleAnim()
    }
    
    func animatePet(animName: String, length: Int, duration:Float, repeatCount:Int)
    {
        self.petImage.setBackgroundImageNamed(animName)
        var durationTI = NSTimeInterval(duration)
        self.petImage.startAnimatingWithImagesInRange(NSMakeRange(Int(0), length), duration: durationTI, repeatCount: repeatCount)
    }
}
