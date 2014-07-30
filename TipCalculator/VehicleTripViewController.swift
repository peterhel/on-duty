//
//  VehicleTripViewController.swift
//  TipCalculator
//
//  Created by Peter Helenefors on 2014-07-28.
//  Copyright (c) 2014 Generic Constructions. All rights reserved.
//

import UIKit
import CoreData

class VehicleTripViewController: UIViewController{
    var vehicle:NSManagedObject!
    
    @IBOutlet var tripsTableView : TripsTableView!
    
    var trips: NSMutableArray!
    var selectedTripIndex: Int!
    
    func onTripSelected(trip:NSManagedObject!){
        self.selectedTripIndex = self.trips.indexOfObject(trip)
        let secondViewController = self.storyboard.instantiateViewControllerWithIdentifier("AddTripController") as AddTripController
        secondViewController.vehicle = vehicle
        secondViewController.trip = trip
        secondViewController.updatedListener = self.tripUpdated
        self.navigationController.pushViewController(secondViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add trip", style: UIBarButtonItemStyle.Plain, target: self, action: "addTrip")
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Trips")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "regno = %@", vehicle.valueForKey("regno") as String)
        trips = NSMutableArray(array: context.executeFetchRequest(request, error: nil))
        
        println(trips)
        
        tripsTableView.onTripSelected = self.onTripSelected
        tripsTableView.load(trips)
    }
    
    func tripCreated(trip: NSManagedObject){
        trips.insertObject(trip, atIndex: 0)
        self.tripsTableView.reloadData()
        self.navigationController.popViewControllerAnimated(true)
    }
    
    func tripUpdated(trip: NSManagedObject){
        trips.replaceObjectAtIndex(self.selectedTripIndex, withObject: trip)
        self.tripsTableView.reloadData()
        self.navigationController.popViewControllerAnimated(true)
    }
    
    func addTrip(){
        let secondViewController = self.storyboard.instantiateViewControllerWithIdentifier("AddTripController") as AddTripController
        
        secondViewController.createdListener = self.tripCreated
        secondViewController.vehicle = self.vehicle
        self.navigationController.pushViewController(secondViewController, animated: true)
    }
}