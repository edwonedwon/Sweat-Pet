import WatchKit
import Foundation

class StatsInterfaceController: WKInterfaceController
{
    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)
        println("stats")
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