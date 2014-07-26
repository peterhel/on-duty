
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
    
    @IBOutlet var vehiclesList: VehicleTableView

    override func viewDidAppear(animated: Bool) {
        self.vehiclesList.load()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.vehiclesList.load()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func createVehicle(sender: AnyObject){
        let secondViewController = self.storyboard.instantiateViewControllerWithIdentifier("CreateVehicleController") as CreateVehicleController
        
        self.navigationController.pushViewController(secondViewController, animated: true)
    }
}