////
////  HealthKitHelper.swift
////  Sweat Pet
////
////  Created by Edwon Edwon on 5/2/15.
////  Copyright (c) 2015 EDWON. All rights reserved.

// HEALTH MANAGER, a utility class that the Sweat Pet iPhone App and Watch Kit Extension can both use for getting health data

/* NOTES FOR ARTHUR

    Most of the current code is copied from http://www.raywenderlich.com/86336/ios-8-healthkit-swift-getting-started
    I understand some of it, but I'm having trouble understanding the use of completions in the code
    This is where Arthur comes in to save the day!

    In the game, I want it so you get 1 vial of sweat for every 15 minutes of exercise.
    Any exercise beyond that in one day starts to "supercharge" the sweat, which helps you level up your pet faster.

    To help users know how much they've worked out, I also have a screen where you can see the vial filling up throughout the day or while exercising.

    Exercise is not tracked using Sweat Pet, but rather any tracking app the user happens to use.
    Using Apple's HealthKit, their health data will be stored in the Health app included on every iPhone
    https://developer.apple.com/library/ios/documentation/HealthKit/Reference/HealthKit_Framework/

    Now, the hard part is figuring out how to judge what is exercise and what is not from HealthKits data.
    This get's a bit tricky as there are a few different ways exercise data is stored.

    "Active Calories" - calories burned while exercising (not just hanging out)
    "Heart Rate" - we could count anything over 100bpm as exercise 
    "Distance" - how long somebody ran or rode their bike
    "Workouts" - these are basically for apps like "Strava" and the built in Apple Watch "Workout" app, it's a collection of data related to one "workout" like a jog or a run the user specifically tracked, I can't tell whether data from Workouts is added to the main "heart rate" and "active calories" in the users health database https://developer.apple.com/library/ios/documentation/HealthKit/Reference/HKWorkout_Class/index.html#//apple_ref/doc/uid/TP40014744

    What I need is basically some high level function
    that returns the total amount of time the user has exercised on any given day, or range of days, using some sort of magic with this data to figure out whether the user was actually exercising or not.
    I want it based on time because I heard a doctor talking about the minimum exercise needed to stay healthy. It's basically 15 minutes a day above a certain heart rate (I think 100bpm or so) and your health increases dramatically. So I want people to be motivated to simply do that.

    So I'm thinking it should kinda look like this

    var userPrefsDayBeginTime:NSTime

    func getTodaysExercise (day:NSDate) -> NSTimeInterval
    {
        insert arthur magic
        return totalTimeExercised
    }

    func getMultipleDaysExercise (startDate:NSDate, endDate:NSDate) -> NSTimeInterval
    {
        insert arthur magic
        return totalTimeExercised
    }

    func exerciseTimeToMinutes (totalTimeExercise:NSTimeInterval) -> Int
    {
        insert arthur magic
        return totalMinutes
    }


    I also plan on having a setting in the app where users can set when a "day" begins and ends. 
    For instance if you want your day to begin and end at 2am because you often workout late at night. 
    Then this function should be used to help calculate the totalTimeExercised in the other functions

    func getUserDay ()
    {
        check against userPrefsDayBeginTime preference
    }

    At some point I'd also like to add a feature where users can record workouts inside the Sweat Pet app, but I imagine it's out of your scope for now.

    Thanks so much for this Arthur, and please leave comments or take me through the code when your done as I'd like to learn how this stuff works!

*/

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
    // this crashes the app right now for some reason
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