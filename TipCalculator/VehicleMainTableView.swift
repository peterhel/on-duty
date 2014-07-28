//
//  VehicleTableView.swift
//  TipCalculator
//
//  Created by Peter Helenefors on 2014-07-26.
//  Copyright (c) 2014 Generic Constructions. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class VehicleMainTableView : UITableView, UITableViewDelegate, UITableViewDataSource {
    var vehicles: NSMutableArray = [];

    var onVehicleSelected: ((vehicle:NSManagedObject)->())?
    
    func load(){
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Vehicle")
        request.returnsObjectsAsFaults = false
        vehicles = NSMutableArray(array: context.executeFetchRequest(request, error: nil))
        
        self.allowsSelection = true;
        
        self.delegate=self;
        self.dataSource=self;
    }
    
    func vehicleCreated(vehicle:NSManagedObject!) -> Void{
        println("Listener callback executed!")
        self.vehicles.insertObject(vehicle, atIndex: 0)
        self.reloadData()
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
        cell.selectionStyle = UITableViewCellSelectionStyle.Default
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        var selectedVehicle = self.vehicles.objectAtIndex(indexPath.row) as NSManagedObject
        if let callback = self.onVehicleSelected
        {
            callback(vehicle: selectedVehicle)
        }
    }
}