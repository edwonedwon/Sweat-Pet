//
//  PetController.swift
//  Sweat Pet
//
//  Created by Edwon Edwon on 4/13/15.
//  Copyright (c) 2015 EDWON. All rights reserved.
//
import UIKit
import CoreData

class PetController
{
    
    func newPet ()
    {
        if (!doHavePet())
        {
            var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            var context:NSManagedObjectContext = appDel.managedObjectContext!

            // make a new pet entry in the core data thing
            var pet = NSEntityDescription.insertNewObjectForEntityForName("Pets", inManagedObjectContext: context) as! NSManagedObject
            pet.setValue(0, forKey: "age") // set age to 0
            pet.setValue(NSDate(), forKey: "birthday") // set birthday to now
            var format = NSDateFormatter()
            format.dateStyle = NSDateFormatterStyle.ShortStyle
            format.timeStyle = NSDateFormatterStyle.LongStyle
            
            // DEBUG
            println("Made a new pet!")
            println("my birthday is: " + format.stringFromDate(NSDate()))
            println("my age is 0!")
            var request = NSFetchRequest(entityName: "Pets")
            request.returnsObjectsAsFaults = false;
            var results:NSArray = context.executeFetchRequest(request,error: nil)!
            println("there are " + results.count.description + " pets in here!")
        }
    }
    
    func updateAge ()
    {
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        var now = NSDate()
        var timeSinceBirth = NSTimeInterval()
        
        //fetch the birthday from core data using a fetch request
        var request = NSFetchRequest(entityName: "Pets")
        request.returnsObjectsAsFaults = false;
        var birthday = NSDate()
        var results:NSArray = context.executeFetchRequest(request,error: nil)!
        for result in results
        {
            var res = results[0] as! NSManagedObject
            birthday = res.valueForKey("birthday") as! NSDate
        }
        
        // get the interval between birth and now
        timeSinceBirth = now.timeIntervalSinceDate(birthday)
        saveAge(timeSinceBirth)
    }
    
    func saveAge (age:Double)
    {
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext!

        // get pet from core data
        var request = NSFetchRequest(entityName: "Pets")
        request.returnsObjectsAsFaults = false;
        var results:NSArray = context.executeFetchRequest(request,error: nil)!
        var pet = results[0] as! NSManagedObject
        
        // set the age value on the pet
        pet.setValue(age, forKey: "age")
        context.save(nil)
        println("saving age as " + age.description)
    }
    
    func readAge ()
    {
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Pets")
        request.returnsObjectsAsFaults = false;
        var results:NSArray = context.executeFetchRequest(request,error: nil)!
        var res = results[0] as! NSManagedObject
        println ("reading age as " + (res.valueForKey("age") as! Double).description)
    }
    
    func doHavePet() -> Bool
    {
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Pets")
        request.returnsObjectsAsFaults = false;
        var results:NSArray = context.executeFetchRequest(request,error: nil)!
        if (results.count >= 1)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func stringFromTimeInterval(interval:NSTimeInterval) -> NSString {
        
        var ti = NSInteger(interval)
        
        var ms = Int((interval % 1) * 1000)
        
        var seconds = ti % 60
        var minutes = (ti / 60) % 60
        var hours = (ti / 3600)
        
        return NSString(format: "I am h: %0.2d: m: %0.2d: s: %0.2d.%0.3d old!",hours,minutes,seconds,ms)
    }
}
