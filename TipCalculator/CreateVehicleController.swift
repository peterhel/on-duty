//
//  CreateVehicleController.swift
//  TipCalculator
//
//  Created by Peter Helenefors on 2014-07-23.
//  Copyright (c) 2014 Generic Constructions. All rights reserved.
//

import UIKit
import CoreData

class CreateVehicleController : UIViewController{
    
    var vehicle: NSManagedObject?
    
    @IBOutlet var registrationNumber : UITextField!
    @IBOutlet var drivmedel : UISegmentedControl!
    @IBOutlet var owner : UISegmentedControl!
    
    @IBAction func saveVehicle(sender:AnyObject){
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext
        
        var regNo: String = registrationNumber.text
        var drivm: Bool = drivmedel.selectedSegmentIndex == 1
        var own: Bool = owner.selectedSegmentIndex == 1

        if let vehicleToEdit = self.vehicle {
            println("Updating vehicle")
            vehicleToEdit.setValue(drivm, forKey: "fuel")
            vehicleToEdit.setValue(own, forKey: "owner")

            context.save(nil)
            
            AppContext.eventListener.fireEntityUpdated(vehicleToEdit)
            self.registrationNumber.enabled = true
            return
        }
        println("Saving vehicle")
        
        
        var vehicle = NSEntityDescription.insertNewObjectForEntityForName("Vehicle", inManagedObjectContext: context) as NSManagedObject
        
        vehicle.setValue(regNo, forKey: "regno")
        vehicle.setValue(drivm, forKey: "fuel")
        vehicle.setValue(own, forKey: "owner")
        
        context.save(nil)
        
        AppContext.eventListener.fireEntityCreated(vehicle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vehicleToEdit = self.vehicle{
            self.registrationNumber.enabled = false
            self.registrationNumber.text = vehicleToEdit.valueForKey("regno") as String
            self.drivmedel.selectedSegmentIndex = vehicleToEdit.valueForKey("fuel") as Bool ? 1 : 0
            self.owner.selectedSegmentIndex = vehicleToEdit.valueForKey("owner") as Bool ? 1 : 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewTapped(sender: AnyObject){
        registrationNumber.resignFirstResponder()
    }
}