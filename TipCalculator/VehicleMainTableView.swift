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
    var onVehicleSelected: ((vehicle:Vehicle)->())?

    override func awakeFromNib() {
        self._load()
    }
    
    func _load(){
        self.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.allowsSelection = true;
        
        self.delegate=self;
        self.dataSource=self;
        
        AppContext.eventListener.addEntityCreatedListener("Vehicle", listener: Listener (
            {
                (vehicle: AnyObject) -> Void in
                self.reloadData()
            }
        ))
        
        AppContext.eventListener.addEntityUpdatedListener("Vehicle", listener: Listener (
            {
                (vehicle: AnyObject) -> Void in
                self.reloadData()
            }
        ))
        
        AppContext.eventListener.addEntityDeletedListener("Vehicle", listener: Listener (
            {
                (vehicle: AnyObject) -> Void in
                self.reloadData()
            }
        ))
    }
    
    func tableView(tableView:UITableView!, numberOfRowsInSection section:Int)->Int
    {
        return Vehicles.all.count
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
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        if cell == nil
        {
            cell = UITableViewCell()
        }
        var vehicleData = Vehicles.all[indexPath.row]
        cell.textLabel.text = vehicleData.regno
        cell.selectionStyle = UITableViewCellSelectionStyle.Default
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        var selectedVehicle = Vehicles.all[indexPath.row]
        if let callback = self.onVehicleSelected
        {
            callback(vehicle: selectedVehicle)
        }
    }
}