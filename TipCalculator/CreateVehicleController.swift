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
    
    @IBOutlet var registrationNumber : UITextField
    @IBOutlet var drivmedel : UISegmentedControl
    @IBOutlet var owner : UISegmentedControl
    
    @IBAction func saveVehicle(sender:AnyObject){
        println("Saving vehicle")
        
        var regNo: String = registrationNumber.text
        var drivm: Bool = drivmedel.selectedSegmentIndex == 1
        var own: Bool = owner.selectedSegmentIndex == 1
        
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext
        
        var vehicle = NSEntityDescription.insertNewObjectForEntityForName("Vehicle", inManagedObjectContext: context) as NSManagedObject
        
        vehicle.setValue(regNo, forKey: "regno")
        vehicle.setValue(drivm, forKey: "fuel")
        vehicle.setValue(own, forKey: "owner")
        
        context.save(nil)
        
        println(vehicle)
        println("Vehicle saved")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewTapped(sender: AnyObject){
        registrationNumber.resignFirstResponder()
    }
}