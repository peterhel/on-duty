
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

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vehiclesList.load()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func vehicleCreated(vehicle:NSManagedObject!) -> Void{
        println("Listener callback executed!")
        self.vehiclesList.vehicles.insertObject(vehicle, atIndex: 0)
        self.vehiclesList.reloadData()
    }

    
    @IBAction func createVehicle(sender: AnyObject){
        let secondViewController = self.storyboard.instantiateViewControllerWithIdentifier("CreateVehicleController") as CreateVehicleController
        
        secondViewController.setCreatedListener(self.vehicleCreated)

        self.navigationController.pushViewController(secondViewController, animated: true)
    }
}