//
//  Vehicle.swift
//  TipCalculator
//
//  Created by Peter Helenefors on 2014-07-31.
//  Copyright (c) 2014 Generic Constructions. All rights reserved.
//

import UIKit
import CoreData

struct Vehicles {
    static var all: Array<Vehicle> = []
    static var context: NSManagedObjectContext!
    init()
    {
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        Vehicles.context = appDel.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Vehicle")
        request.returnsObjectsAsFaults = false
        var vehicles = Vehicles.context.executeFetchRequest(request, error: nil)
        for v in vehicles
        {
            var regno = v.valueForKey("regno") as String
            var fuel = v.valueForKey("fuel") as Bool
            var owner = v.valueForKey("owner") as Bool
            Vehicles.all.append(Vehicle(regno: regno, fuel: fuel, owner: owner))
        }
    }
    
    static func getManagedObjectFor(vehicle: Vehicle) -> NSManagedObject{
        let entityName = "Vehicle"
        let request : NSFetchRequest = NSFetchRequest(entityName: entityName)
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "regno = %@", vehicle.regno)
        var vehicle = Vehicles.context.executeFetchRequest(request, error: nil)
        return vehicle[0] as NSManagedObject
    }
}

class Vehicle
{
    var regno: String!
    var fuel: Bool!
    var owner: Bool!

    init(regno: String, fuel:Bool, owner: Bool)
    {
        self.regno = regno;
        self.fuel = fuel;
        self.owner = owner;
    }
}

