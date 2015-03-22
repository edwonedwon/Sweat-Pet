// Playground - noun: a place where people can play

import UIKit
import HealthKit

var calories = "100"
var caloriesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
caloriesLabel.text = calories

HKHealthStore.isHealthDataAvailable()

let store = HKHealthStore()
let unit = HKUnit.degreeFahrenheitUnit()
let quantity = HKQuantity(unit: unit, doubleValue: 100)

let calendar = NSCalendar.currentCalendar()
let startDate = NSDate()
let startComponents = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: startDate)
let hour = startComponents.hour
let minutes = startComponents.minute

let endDate = NSDate()
let endComponents = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: endDate)

let sampleType = HKQuantitySample(type: HKQuantityTypeIdentifierActiveEnergyBurned, quantity: quantity, startDate: startDate, endDate: endDate)

let sq = HKSampleQuery(sampleType: HKQuantityTypeIdentifierActiveEnergyBurned, predicate: <#NSPredicate!#>, limit: <#Int#>, sortDescriptors: <#[AnyObject]!#>, resultsHandler: <#((HKSampleQuery!, [AnyObject]!, NSError!) -> Void)!##(HKSampleQuery!, [AnyObject]!, NSError!) -> Void#>)
store.executeQuery(query: HKQuery!)


