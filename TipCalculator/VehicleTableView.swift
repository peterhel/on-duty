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
}