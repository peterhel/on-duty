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
    
    var vehicle: NSManagedObject!
    var trip: NSManagedObject?
    var createdListener : ((NSManagedObject) -> Void)!
    var updatedListener : ((NSManagedObject) -> Void)!
    
    @IBOutlet var regno : UILabel!
    @IBOutlet var start : UITextField!
    @IBOutlet var end : UITextField!
    @IBOutlet var comment : UITextView!
    @IBOutlet var date : UIDatePicker!
    
    @IBAction func saveTrip(){
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext
        
        if let selectedTrip = self.trip {

            selectedTrip.setValue(self.vehicle.valueForKey("regno"), forKey: "regno")
            selectedTrip.setValue((start.text as NSString).integerValue, forKey: "start")
            selectedTrip.setValue((end.text as NSString).integerValue, forKey: "end")
            selectedTrip.setValue(comment.text, forKey: "comment")
            selectedTrip.setValue(date.date, forKey: "date")
            
            context.save(nil)

            updatedListener(selectedTrip)
            return;
        }
        
        var trip = NSEntityDescription.insertNewObjectForEntityForName("Trips", inManagedObjectContext: context) as NSManagedObject
        
        trip.setValue(self.vehicle.valueForKey("regno"), forKey: "regno")
        trip.setValue((start.text as NSString).integerValue, forKey: "start")
        trip.setValue((end.text as NSString).integerValue, forKey: "end")
        trip.setValue(comment.text, forKey: "comment")
        trip.setValue(date.date, forKey: "date")
        
        context.save(nil)
        
        createdListener(trip)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tapBackground = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapBackground)
        regno.text = vehicle.valueForKey("regno") as String
        
        if let selectedTrip = self.trip
        {
            start.text = String((selectedTrip.valueForKey("start") as NSNumber).integerValue)
            end.text = String((selectedTrip.valueForKey("end") as NSNumber).integerValue)
            comment.text = selectedTrip.valueForKey("comment") as String
            date.setDate(selectedTrip.valueForKey("date") as NSDate, animated: false)
        }
    }
    
    func dismissKeyboard() {
        println("dismiss keyboard")
        //start.resignFirstResponder()
        //end.resignFirstResponder()
        //comment.resignFirstResponder()
        self.view.endEditing(true)
    }
}
