
//  VehicleListController.swift
//  TipCalculator
//
//  Created by Peter Helenefors on 2014-07-23.
//  Copyright (c) 2014 Generic Constructions. All rights reserved.
//

import UIKit
import CoreData

class VehicleListController: UIViewController
 {
    
    @IBOutlet var vehiclesList: VehicleTableView!

    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add vehicle", style: UIBarButtonItemStyle.Plain, target: self, action: "createVehicle")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppContext.eventListener.addEntityCreatedListener("Vehicle", listener: Listener (
            {
                (entity: AnyObject!) -> Void in
                    self.navigationController.popViewControllerAnimated(true)
                    println()
            }
        ))
        
        AppContext.eventListener.addEntityUpdatedListener("Vehicle", listener: Listener (
            {
                (vehicle: AnyObject!) -> Void in
                self.navigationController.popViewControllerAnimated(true)
                println()
            }
        ))
        
        self.vehiclesList.onVehicleSelected = {
            (vehicle: AnyObject) -> Void in
            let secondViewController = self.storyboard.instantiateViewControllerWithIdentifier("CreateVehicleController") as CreateVehicleController
            
            secondViewController.vehicle = vehicle as? Vehicle
            
            self.navigationController.pushViewController(secondViewController, animated: true)

        }
        
        //self.vehiclesList.load()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func createVehicle(){
        let secondViewController = self.storyboard.instantiateViewControllerWithIdentifier("CreateVehicleController") as CreateVehicleController
        
        self.navigationController.pushViewController(secondViewController, animated: true)
    }
}