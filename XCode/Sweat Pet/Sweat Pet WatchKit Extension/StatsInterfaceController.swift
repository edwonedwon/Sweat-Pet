import WatchKit
import Foundation

class StatsInterfaceController: WKInterfaceController
{
    @IBOutlet weak var ageNumberLabel: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)
        println("stats")
    }
    
    func updateAgeLabel() -> String
    {
        var replyVal = Int()
        var parentValues = ["parent values poop": "statsString"]
        WKInterfaceController.openParentApplication(parentValues as [NSObject : AnyObject], reply: {(replyValues, error) -> Void in
            if let dipe = replyValues["age"] as? Int
            {
                replyVal = dipe
            }
        })

        return(replyVal.description)
    }
    
    override func willActivate()
    {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        ageNumberLabel.setText(updateAgeLabel())
    }
    
    override func didDeactivate()
    {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}