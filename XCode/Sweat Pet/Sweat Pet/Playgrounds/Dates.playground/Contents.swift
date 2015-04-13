import Cocoa
import Foundation

let userCal = NSCalendar.currentCalendar()
let dateC = NSDateComponents()

dateC.year = 1876
dateC.month = 3
dateC.day = 10
dateC.hour = 9
dateC.minute = 14
dateC.timeZone = NSTimeZone(name:"US/Easter")

let firstLandPhoneCallDate = userCal.dateFromComponents(dateC)

print(firstLandPhoneCallDate)

/// formatting tests

let formatter = NSDateFormatter()

// these only the show the date
formatter.dateStyle = .MediumStyle
formatter.stringFromDate(firstLandPhoneCallDate!)
formatter.dateStyle = NSDateFormatterStyle.ShortStyle
formatter.stringFromDate(firstLandPhoneCallDate!)
formatter.dateStyle = NSDateFormatterStyle.FullStyle
formatter.stringFromDate(firstLandPhoneCallDate!)
// select a timestyle to show the time as well
formatter.timeStyle = NSDateFormatterStyle.MediumStyle
formatter.stringFromDate(firstLandPhoneCallDate!)

// testing zone

var now = NSDate()
var birth = NSDate(timeIntervalSinceNow: -100000000000)

var timeSinceBirth = NSTimeInterval()
timeSinceBirth = now.timeIntervalSinceDate(birth)

func stringFromTimeInterval(interval:NSTimeInterval) -> NSString {
    
    var ti = NSInteger(interval)
    
    var ms = Int((interval % 1) * 1000)
    
    var seconds = ti % 60
    var minutes = (ti / 60) % 60
    var hours = (ti / 3600)
    
    return NSString(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
}