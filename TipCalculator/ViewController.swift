//
//  ViewController.swift
//  TipCalculator
//
//  Created by Peter Helenefors on 2014-07-22.
//  Copyright (c) 2014 Generic Constructions. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet var vehiclesList: VehicleMainTableView!

    func onVehicleSelected(vehicle:NSManagedObject!){
        let secondViewController = self.storyboard.instantiateViewControllerWithIdentifier("VehicleTripViewController") as VehicleTripViewController
        secondViewController.vehicle = vehicle
        self.navigationController.pushViewController(secondViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.vehiclesList.onVehicleSelected = onVehicleSelected
        self.vehiclesList.load()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

