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

class VehicleTableView : UITableView, UITableViewDelegate, UITableViewDataSource {
    var vehicles: NSArray = [];

    func load(){
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Vehicle")
        request.returnsObjectsAsFaults = false
        vehicles = context.executeFetchRequest(request, error: nil)
        
        self.delegate=self;
        self.dataSource=self;

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
    
    // Override to support conditional editing of the table view.
    // This only needs to be implemented if you are going to be returning NO
    // for some items. By default, all items are editable.
    func tableView(tableView:UITableView, canEditRowAtIndexPath indexPath:NSIndexPath) -> Bool {
    // Return YES if you want the specified item to be editable.
    return true;
    }
    

    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
}