////
////  HealthKitHelper.swift
////  Sweat Pet
////
////  Created by Edwon Edwon on 5/2/15.
////  Copyright (c) 2015 EDWON. All rights reserved.


import Foundation
import HealthKit

public class HealthManager
{
    let healthKitStore = HKHealthStore()
    
    var height, weight: HKQuantitySample?

    public init ()
    {
        
    }
    
    // GET WEIGHT AS STRING
    
    public func updateWeight () -> String
    {
        // 1. Construct an HKSampleType for weight
        let sampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
        
        // 2. Call the method to read the most recent weight sample
        self.readMostRecentSample(sampleType, completion:
            { (mostRecentWeight, error) -> Void in
                
                if( error != nil )
                {
                    println("Error reading weight from HealthKit Store: \(error.localizedDescription)")
                    return;
                }
                
                var weightLocalizedString = String()
                // 3. Format the weight to display it on the screen
                self.weight = mostRecentWeight as? HKQuantitySample;
                if let kilograms = self.weight?.quantity.doubleValueForUnit(HKUnit.gramUnitWithMetricPrefix(.Kilo))
                {
                    let weightFormatter = NSMassFormatter()
                    weightFormatter.forPersonMassUse = true;
                    weightLocalizedString = weightFormatter.stringFromKilograms(kilograms)
                }
                
                // 4. Update UI in the main thread
                dispatch_async(dispatch_get_main_queue(),
                    { () -> Void in
                        return weightLocalizedString
                        //                self.updateBMI()
                });
        });
        return "Something is wrong with getting the weight sample, you need to fix it Edwon!"
    }
    
    
    // READ MOST RECENT SAMPLE
    // sort of a utility function
    public func readMostRecentSample(sampleType:HKSampleType, completion: ((HKSample!, NSError!) -> Void)!)
    {
        // 1. Build the Predicate
        let past = NSDate.distantPast() as! NSDate
        let now = NSDate()
        let mostRecentPredicate = HKQuery.predicateForSamplesWithStartDate(past, endDate: now, options: .None)
        
        // 2. Build the sort descriptor to return the samples in descending order
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        
        // 3. we want to limit the number of samples returned by the query to just 1 (the most recent)
        let limit = 1
        
        // 4. Build samples query
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit: limit,
            sortDescriptors: [sortDescriptor])
            { (sampleQuery, results, error ) -> Void in
                
                if let queryError = error {
                    completion(nil, error)
                    return;
                }
                
                // Get the first sample
                let mostRecentSample = results.first as? HKQuantitySample
                
                // Execute the completion closure
                if completion != nil
                {
                    completion(mostRecentSample, nil)
                }
        }
        
        // 5. Execute the Query
        self.healthKitStore.executeQuery(sampleQuery)
    }
    
    
    // AUTHORIZE HEALTH KIT
    // this should only need to happen once
    public func authorizeHealthKit(completion: ((success:Bool, error:NSError!) -> Void)!)
    {
        // 1. Set the types you want to read from HK Store
        let healthKitTypesToRead = NSSet(array:[
            HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierDateOfBirth),
            HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBloodType),
            HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBiologicalSex),
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass),
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight),
            HKObjectType.workoutType()
            ]) as Set
        
        // 2. Set the types you want to write to HK Store
        let healthKitTypesToWrite = NSSet(array:[
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMassIndex),
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned),
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning),
            HKQuantityType.workoutType()
            ]) as Set
        
        // 3. If the store is not available (for instance, iPad) return an error and don't go on.
        if !HKHealthStore.isHealthDataAvailable()
        {
            let error = NSError(domain: "com.raywenderlich.tutorials.healthkit", code: 2, userInfo: [NSLocalizedDescriptionKey:"HealthKit is not available in this Device"])
            if( completion != nil )
            {
                completion(success:false, error:error)
            }
            return;
        }
        
        // 4.  Request HealthKit authorization
        healthKitStore.requestAuthorizationToShareTypes(healthKitTypesToWrite, readTypes: healthKitTypesToRead) { (success, error) -> Void in
            
            if( completion != nil )
            {
                completion(success:success,error:error)
            }
        }
    }
    

    
}