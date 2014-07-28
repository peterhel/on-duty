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
    var vehicles: NSMutableArray = [];

    func load(){
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Vehicle")
        request.returnsObjectsAsFaults = false
        vehicles = NSMutableArray(array: context.executeFetchRequest(request, error: nil))
        
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
        cell.selectionStyle = UITableViewCellSelectionStyle.None
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
    
    func tableView(tableView: UITableView!, editActionsForRowAtIndexPath indexPath: NSIndexPath!) ->[AnyObject]!
    {
    
/*    var moreRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "More", handler:{action, indexpath in
        println("MORE•ACTION");
    });*/
   // moreRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0);
    
    var deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler:{action, indexpath in
            var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
            var context:NSManagedObjectContext = appDel.managedObjectContext
        
            context.deleteObject(self.vehicles.objectAtIndex(indexPath.row) as NSManagedObject)
            context.save(nil)
        
            self.vehicles.removeObjectAtIndex(indexpath.row)
            tableView.deleteRowsAtIndexPaths([indexpath], withRowAnimation: UITableViewRowAnimation.Automatic)
    });
    
        return [deleteRowAction];
    }
}