import WatchKit
import Foundation
import SweatPetUtil

class PetInterfaceController: WKInterfaceController
{
    
    let petControl = PetController()
    
    var isDrinking = false
    
    @IBOutlet weak var petImage: WKInterfaceGroup!
    
    @IBOutlet weak var vialImage: WKInterfaceImage!
    
    @IBOutlet weak var ageLabel: WKInterfaceLabel!
    
    @IBAction func feedButtonAction()
    {
        if (!isDrinking)
        {
            isDrinking = Bool(true)
            animatePet("pet_drink_begin_", length: 21, duration: 0.9, repeatCount: 1)
            animateVial("vial_pour_", length: 111, duration: 3.5, repeatCount: 1)
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
        
        // IF NO PET MAKE A NEW PET
        if (!petControl.doHavePet())
        {
            petControl.newPet()
        }
    }

    override func willActivate()
    {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        // UPDATE AGE LABEL
        let ageString = petControl.readAgeDaysString()
        self.ageLabel.setText(ageString)
    }

    override func didDeactivate()
    {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func buttonClean()
    {
        // ANIMATE PET EAT
        idleAnim()
    }
    
    func animateVial(animName: String, length: Int, duration:Float, repeatCount:Int)
    {
        self.vialImage.setImageNamed(animName)
        var durationTI = NSTimeInterval(duration)
        self.vialImage.startAnimatingWithImagesInRange(NSMakeRange(Int(0), length), duration: durationTI, repeatCount: repeatCount)
    }

    
    func animatePet(animName: String, length: Int, duration:Float, repeatCount:Int)
    {
        self.petImage.setBackgroundImageNamed(animName)
        var durationTI = NSTimeInterval(duration)
        self.petImage.startAnimatingWithImagesInRange(NSMakeRange(Int(0), length), duration: durationTI, repeatCount: repeatCount)
    }
}
