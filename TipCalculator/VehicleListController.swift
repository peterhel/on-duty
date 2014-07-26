
//  VehicleListController.swift
//  TipCalculator
//
//  Created by Peter Helenefors on 2014-07-23.
//  Copyright (c) 2014 Generic Constructions. All rights reserved.
//

import UIKit
import CoreData

class VehicleListController: UIViewController, UITableViewDelegate, UITableViewDataSource
 {
    
    @IBOutlet var vehiclesList: UITableView
    var vehicles: NSArray = [];

    override func endAppearanceTransition(){
        super.endAppearanceTransition()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Vehicle")
        request.returnsObjectsAsFaults = false
        vehicles = context.executeFetchRequest(request, error: nil)
        
        self.vehiclesList.reloadData()
        
        return
        
        if(vehicles.count == 0){
            println("No vehicles found")
            return
        }
        
        self.vehiclesList.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        for result in vehicles{
            var cell = self.vehiclesList.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
            cell.textLabel.text=result.string;
            println(result)
            vehiclesList.addSubview(cell)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext

        var request = NSFetchRequest(entityName: "Vehicle")
        request.returnsObjectsAsFaults = false
        vehicles = context.executeFetchRequest(request, error: nil)

        
        self.vehiclesList.delegate=self;
        self.vehiclesList.dataSource=self;
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func createVehicle(sender: AnyObject){
        let secondViewController = self.storyboard.instantiateViewControllerWithIdentifier("CreateVehicleController") as CreateVehicleController
        
        self.navigationController.pushViewController(secondViewController, animated: true)
    }
    
    func tableView(tableView:UITableView!, numberOfRowsInSection section:Int)->Int
    {
        return vehicles.count
    }
    
    func tableView(tableView:UITableView!, heightForRowAtIndexPath indexPath:NSIndexPath)->CGFloat
    {
        return 51
    }
    
    
    
    func numberOfSectionsInTableView(tableView:UITableView!)->Int
    {
        return 1
    }
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell
    {
        var  cell = UITableViewCell()// tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        var vehicleData = vehicles[indexPath.row] as NSManagedObject
        cell.textLabel.text=vehicleData.valueForKey("regno") as String
        
        return cell
    }

}