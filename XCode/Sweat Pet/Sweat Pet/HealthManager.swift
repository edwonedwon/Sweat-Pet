import Foundation
import HealthKit

class HealthManager
{
    
    let healthKitStore: HKHealthStore = HKHealthStore()
    let kUnknownString   = "Unknown"
    
    func authorizeHealthKit(completion: ((success:Bool, error:NSError!) -> Void)!)
    {
        // 1. Set the types you want to read from HK Store
        let healthKitTypesToRead = NSSet(array:[
//            HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierDateOfBirth),
//            HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBloodType),
//            HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBiologicalSex),
//            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass),
//            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight),
//            HKObjectType.workoutType()
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned)
            ])
        
        // 2. Set the types you want to write to HK Store
        let healthKitTypesToWrite = NSSet(array:[
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned)
//            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMassIndex),
//            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned),
//            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning),
//            HKQuantityType.workoutType()
            ])
        
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
        healthKitStore.requestAuthorizationToShareTypes(healthKitTypesToWrite as! Set<NSObject>, readTypes: healthKitTypesToRead as! Set<NSObject>) { (success, error) -> Void in
            
            if( completion != nil )
            {
                completion(success:success,error:error)
            }
        }
    }
    
    var energy:HKQuantitySample?
    
    var tempString = NSString()
    
    func readEnergy () -> NSString
    {
        var energyLocalizedString = NSString()
        var theKey = HKQuantityTypeIdentifierActiveEnergyBurned
        
        // 1. Construct an HKSampleType
        let sampleType = HKSampleType.quantityTypeForIdentifier(theKey)
        
        
        // 2. Call the method to read the most recent sample
        readMostRecentSample(sampleType, completion: { (mostRecentEnergy, error) -> Void in
            
            if( error != nil )
            {
                println("Error reading weight from HealthKit Store: \(error.localizedDescription)")
                return;
            }
            
            var energyLocalizedString = self.kUnknownString;
            // 3. Format the weight to display it on the screen
            self.energy = mostRecentEnergy as? HKQuantitySample;
            if let calories = self.energy?.quantity.doubleValueForUnit(HKUnit.calorieUnit()) {
                let energyFormatter = NSEnergyFormatter()
                energyLocalizedString = energyFormatter.stringFromValue(calories, unit: NSEnergyFormatterUnit.Calorie)
//                println(energyLocalizedString)
                self.tempString = energyLocalizedString
            }
            
            // 4. Update UI in the main thread
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
//            });

        });
        
        return tempString

    }
    
    func readMostRecentSample(sampleType:HKSampleType , completion: ((HKSample!, NSError!) -> Void)!)
    {
        
        // 1. Build the Predicate
        let past = NSDate.distantPast() as! NSDate
        let now   = NSDate()
        let mostRecentPredicate = HKQuery.predicateForSamplesWithStartDate(past, endDate:now, options: .None)
        
        
        // 2. Build the sort descriptor to return the samples in descending order
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        // 3. we want to limit the number of samples returned by the query to just 1 (the most recent)
        let limit = 1000
        
        // 4. Build samples query
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit: limit, sortDescriptors: [sortDescriptor])
            { (sampleQuery, results, error ) -> Void in
                
                if let queryError = error {
                    completion(nil,error)
                    return;
                }
                
                var sampleTotal = Float()
                
                // Get the first sample
                for result in results
                {
                    sampleTotal += result.value as Float
                }
                
                println(sampleTotal)
                
                let mostRecentSample = results.first as? HKQuantitySample
                
                // Execute the completion closure
                if completion != nil {
                    completion(mostRecentSample,nil)
                }
        }
        // 5. Execute the Query
        self.healthKitStore.executeQuery(sampleQuery)
    }
    
}