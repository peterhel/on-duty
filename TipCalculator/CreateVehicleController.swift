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
    
    var vehicle: Vehicle?
    
    @IBOutlet var registrationNumber : UITextField!
    @IBOutlet var drivmedel : UISegmentedControl!
    @IBOutlet var owner : UISegmentedControl!
    @IBOutlet var btnSave : UIButton!
    @IBOutlet var btnDelete : UIButton!
    
    @IBAction func deleteVehicle(sender:AnyObject){
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext
        
        if let vehicleToEdit = self.vehicle {
            context.deleteObject(Vehicles.getManagedObjectFor(vehicleToEdit))

            AppContext.eventListener.fireEntityDeleted("Vehicle", entity: vehicleToEdit)
            
            context.save(nil)
            
            self.registrationNumber.enabled = true
            return
        }
    }
    
    @IBAction func saveVehicle(sender:AnyObject){
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext
        
        var regNo: String = registrationNumber.text
        var drivm: Bool = drivmedel.selectedSegmentIndex == 1
        var own: Bool = owner.selectedSegmentIndex == 1

        if let vehicle = self.vehicle {
            println("Updating vehicle")
            var vehicleToEdit = Vehicles.getManagedObjectFor(vehicle)
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
        
        var v = Vehicle(regno: regNo, fuel: drivm, owner: own)
        Vehicles.all.append(v)
        context.save(nil)
        
        AppContext.eventListener.fireEntityCreated("Vehicle", entity: v)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnDelete.enabled = false
        
        var tapBackground = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapBackground)

        if let vehicle = self.vehicle{
            self.registrationNumber.enabled = false
            self.btnDelete.enabled = true
            self.registrationNumber.text = vehicle.regno
            self.drivmedel.selectedSegmentIndex = vehicle.fuel ? 1 : 0
            self.owner.selectedSegmentIndex = vehicle.owner ? 1 : 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard(){
        registrationNumber.resignFirstResponder()
    }
}