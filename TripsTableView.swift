//
//  TripsTableView.swift
//  TipCalculator
//
//  Created by Peter Helenefors on 2014-07-28.
//  Copyright (c) 2014 Generic Constructions. All rights reserved.
//

import UIKit
import CoreData

class TripsTableView : UITableView, UITableViewDelegate, UITableViewDataSource
{
    var trips = NSMutableArray()
    var onTripSelected: ((trip:NSManagedObject)->())?

    func load(trips:NSMutableArray!){
        self.delegate = self
        self.dataSource = self

        self.registerClass(TripsTableViewCell.self, forCellReuseIdentifier: "TripCell")

        self.trips = trips
    }
    
    func tableView(tableView:UITableView!, heightForRowAtIndexPath indexPath:NSIndexPath)->CGFloat
    {
        return 51
    }
    
    func numberOfSectionsInTableView(tableView:UITableView!)->Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.trips.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let safetrips = self.trips
            var currentTrip: NSManagedObject = safetrips.objectAtIndex(indexPath.row) as NSManagedObject
            var date = currentTrip.valueForKey("date") as NSDate
            var formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            var dateStr = formatter.stringFromDate(date)
            var cell = tableView.dequeueReusableCellWithIdentifier("TripCell") as TripsTableViewCell

            cell.textLabel.text = dateStr
            cell.detailTextLabel.text = currentTrip.valueForKey("Comment") as String
            return cell

        
    }

    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool
    {
        return true;
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
let safetrips = self.trips
            var selectedTrip = safetrips.objectAtIndex(indexPath.row) as NSManagedObject
            if let callback = self.onTripSelected
            {
                callback(trip: selectedTrip)
            }
    }
    
    func tableView(tableView: UITableView!, editActionsForRowAtIndexPath indexPath: NSIndexPath!) ->[AnyObject]!
    {
/*        var deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Delete", handler:{action, indexpath in
            var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
            var context:NSManagedObjectContext = appDel.managedObjectContext
            
            if let safetrips = self.trips
            {
                context.deleteObject(safetrips.objectAtIndex(indexPath.row) as NSManagedObject)
                context.save(nil)
                
                safetrips.removeObjectAtIndex(indexpath.row)
            }
            tableView.deleteRowsAtIndexPaths([indexpath], withRowAnimation: UITableViewRowAnimation.Automatic)
            });
        
        return [deleteRowAction];*/
        var moreRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "More", handler:{action, indexpath in
            println("MORE•ACTION");
            });
        moreRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0);
        
        var deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler:{action, indexpath in
            println("DELETE•ACTION");
            });
        
        return [deleteRowAction, moreRowAction];

    }

}
