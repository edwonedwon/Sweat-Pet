import WatchKit
import Foundation

class VileInterfaceController: WKInterfaceController
{
    override func awakeWithContext(context: AnyObject?)
    {
        // called when the watch app opens as far as I can tell
        super.awakeWithContext(context)
    }
    
    @IBAction func makeSweatButton()
    {
        
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