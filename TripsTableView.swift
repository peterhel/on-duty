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
    var trips: NSMutableArray?
    
    func load(trips:NSMutableArray!){
        self.delegate = self
        self.dataSource = self

        var headerView = UIView()
        var label = UILabel()
        label.text = "Trips"
        self.tableHeaderView = headerView
        
        self.trips = trips
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        if let safetrips = self.trips
        {
            return safetrips.count
        }
        return 0
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        if let safetrips = self.trips
        {
            var currentTrip: NSManagedObject = safetrips.objectAtIndex(indexPath.row) as NSManagedObject
            var date = currentTrip.valueForKey("date") as NSDate
            var formatter = NSDateFormatter()
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .NoStyle
            var dateStr = formatter.stringFromDate(date)
            var cell = UITableViewCell()
            cell.textLabel.text = dateStr
            return cell
        }
        var cell = UITableViewCell()
        cell.textLabel.text = "entripp"
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
/*            var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
            var context:NSManagedObjectContext = appDel.managedObjectContext
            
            context.deleteObject(self.vehicles.objectAtIndex(indexPath.row) as NSManagedObject)
            context.save(nil)
            
            self.vehicles.removeObjectAtIndex(indexpath.row)
            tableView.deleteRowsAtIndexPaths([indexpath], withRowAnimation: UITableViewRowAnimation.Automatic)*/
            });
        
        return [deleteRowAction];
    }

}
