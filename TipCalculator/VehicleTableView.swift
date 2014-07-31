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
    var selectedVehicle : NSManagedObject!
    
    func load(){
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Vehicle")
        request.returnsObjectsAsFaults = false
        vehicles = NSMutableArray(array: context.executeFetchRequest(request, error: nil))
        self.registerClass(UMTableViewCell.self, forCellReuseIdentifier: "cell")
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.delegate=self;
        self.dataSource=self;
    }
    
    func vehicleCreated(vehicle:NSManagedObject!) -> Void{
        println("Listener callback executed!")
        self.vehicles.insertObject(vehicle, atIndex: 0)
        self.reloadData()
    }

    func vehicleUpdated(vehicle:NSManagedObject!) -> Void {
        println("Listener callback executed!")
        var index = self.vehicles.indexOfObject(self.selectedVehicle)
        self.vehicles.replaceObjectAtIndex(index, withObject: vehicle)
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
    
    var onVehicleSelected: ((NSManagedObject) -> Void)?
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        self.selectedVehicle = self.vehicles.objectAtIndex(indexPath.row) as NSManagedObject
        if let callback = self.onVehicleSelected
        {
            callback(selectedVehicle)
        }
    }

    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UMTableViewCell
        var vehicleData = vehicles[indexPath.row] as NSManagedObject
        cell.textLabel.text=vehicleData.valueForKey("regno") as String
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        //cell.setLeftUtilityButtons(self.leftButtons(), withButtonWidth: 72.0)
        //cell.setRightUtilityButtons(self.rightButtons(), withButtonWidth: 50.0)
        return cell
    }
    
    func leftButtons() -> NSArray
    {
        var buttons = Array<UIButton>()
        
        buttons.append(createButton(UIColor(red: 0.78, green: 0.78, blue: 0.8, alpha: 1.0), action: Selector("deleteRow")))
        buttons.append(createButton(UIColor(red: 0.78, green: 0, blue: 0.8, alpha: 1.0), action: Selector("deleteRow")))

        return buttons
    }
    
    func createButton(color: UIColor, action: Selector) -> UIButton
    {
        var button = UIButton()
        button.backgroundColor = color
        button.titleLabel.text = "More"
        button.titleLabel.textColor = UIColor.whiteColor()
        button.addTarget(self, action: action, forControlEvents: .TouchUpInside)
        
        return button
    }
    
    func deleteRow(){
        println("delete mottafucka!")
    }
    
    func rightButtons() -> NSArray
    {
        var buttons = Array<UIButton>()
        var button = UIButton()
//        button.buttonType = .Custom
        button.backgroundColor = UIColor(red: 0.78, green: 0.78, blue: 0.8, alpha: 1.0)
        button.titleLabel.text = "More"
        
        buttons.append(button)
        return buttons
    }
}