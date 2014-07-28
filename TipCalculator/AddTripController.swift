//
//  AddTripController.swift
//  TipCalculator
//
//  Created by Peter Helenefors on 2014-07-28.
//  Copyright (c) 2014 Generic Constructions. All rights reserved.
//

import UIKit
import CoreData

class AddTripController: UIViewController {
    
    @IBOutlet var regno : UILabel!
    @IBOutlet var start : UITextField!
    @IBOutlet var end : UITextField!
    @IBOutlet var comment : UITextView!
    @IBOutlet var date : UIDatePicker!
    
    @IBAction func saveTrip(){
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext
        
        var trip = NSEntityDescription.insertNewObjectForEntityForName("Trips", inManagedObjectContext: context) as NSManagedObject
        
        trip.setValue(self.vehicle.valueForKey("regno"), forKey: "regno")
        trip.setValue((start.text as NSString).integerValue, forKey: "start")
        trip.setValue((end.text as NSString).integerValue, forKey: "end")
        trip.setValue(comment.text, forKey: "comment")
        trip.setValue(date.date, forKey: "date")
        
        context.save(nil)
        
        createdListener(trip)
    }
    
    var vehicle: NSManagedObject!
    var createdListener : ((NSManagedObject) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        regno.text = vehicle.valueForKey("regno") as String
    }
}
