
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
                (vehicle: NSManagedObject) -> Void in
                    self.vehiclesList.vehicleCreated(vehicle)
                    self.navigationController.popViewControllerAnimated(true)
            }
        ))
            
        self.vehiclesList.load()
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