// Playground - noun: a place where people can play

import UIKit
import HealthKit

let degCUnit = HKUnit.degreeCelsiusUnit()
let degFUnit = HKUnit.degreeFahrenheitUnit()
let degCUnitFromStr = HKUnit(fromString: "degC")
let degFUnitFromStr = HKUnit(fromString: "degF")
let kiloCaloriesUnit = HKUnit.gramUnitWithMetricPrefix(HKMetricPrefix.Kilo)
let poundsUnit = HKUnit.poundUnit()
let ouncesPerLiter = HKUnit(fromString: "oz/L")

let bodyTemperature1 = HKQuantity(unit: degCUnit, doubleValue: 30)
let bodyTemperature2 = HKQuantity(unit: degFUnit, doubleValue: 95)
println(bodyTemperature1.description)
println(bodyTemperature2.description)

if bodyTemperature1.isCompatibleWithUnit(degFUnit)
{
    println("Temperature #1 in Fahrenheit degrees: \(bodyTemperature1.doubleValueForUnit(degFUnit))")
}

if bodyTemperature2.isCompatibleWithUnit(degFUnit)
{
    println("Temperature #2 in Fahrenheit degrees: \(bodyTemperature2.doubleValueForUnit(degFUnit))")
}

let bodyTemperature2InDegC = HKQuantity(unit: degCUnit, doubleValue: bodyTemperature2.doubleValueForUnit(degCUnit))

let comparisonResult = bodyTemperature1.compare(bodyTemperature2)
switch comparisonResult
{
    case NSComparisonResult.OrderedDescending:
        println("Temperature #1 is greater than #2")
    case NSComparisonResult.OrderedAscending:
        println("Temperature #2 is greater than #1")
    case NSComparisonResult.OrderedSame:
        println("Temperature #1 is equal to Temperature #2")
}

