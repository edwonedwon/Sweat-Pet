import WatchKit
import Foundation

class VileInterfaceController: WKInterfaceController
{
    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)
        println("vile")
    }
    
    @IBAction func makeSweatButton()
    {
        println("pressed make sweat")
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
}