//
//  AppContext.swift
//  TipCalculator
//
//  Created by Peter Helenefors on 2014-07-30.
//  Copyright (c) 2014 Generic Constructions. All rights reserved.
//

import UIKit
import CoreData
/*struct AppContext {
    static func GetAppDelegate() -> AppDelegate{
        return (UIApplication.sharedApplication().delegate as AppDelegate)
    }
}*/

struct AppContext{
    static var eventListener = EventListener()
}


class EventListener {
    var entityCreatedListeners = [String: [Listener]]()
    var entityUpdatedListeners = [String: [Listener]]()
    var entityDeletedListeners = [String: [Listener]]()
    
    func addEntityCreatedListener(event: String, listener: Listener) -> Void {
        var listeners = getCreatedListenersFor(event)
        listeners.append(listener)
        entityCreatedListeners[event] = listeners
        println("Listener added for Created '\(event)'. Total \(listeners.count) listeners")
    }
    
    func addEntityDeletedListener(event: String, listener: Listener) -> Void {
        var listeners = getDeletedListenersFor(event)
        listeners.append(listener)
        entityDeletedListeners[event] = listeners
        println("Listener added for Deleted '\(event)'. Total \(listeners.count) listeners")
    }
    
    func fireEntityCreated(entity: NSManagedObject) -> Void {
        var listeners = getCreatedListenersFor(entity.entity.name)
        println("Incoming created event for '\(entity.entity.name)' going out to \(listeners.count) listeners")
        for l in listeners
        {
            println("Executing listener callback")
            l.callback(entity)
        }
    }
    
    func fireEntityDeleted(entity: NSManagedObject) -> Void {
        var listeners = getDeletedListenersFor(entity.entity.name)
        println("Incoming deleted event for '\(entity.entity.name)' going out to \(listeners.count) listeners")
        for l in listeners
        {
            println("Executing listener callback")
            l.callback(entity)
        }
    }
    
    func getCreatedListenersFor(key: String) -> [Listener]
    {
        if var listeners = entityCreatedListeners[key]{
            return listeners
        }
        else{
            var listeners = [Listener]()
            self.entityCreatedListeners[key] = listeners
            return listeners
        }
    }

    func getDeletedListenersFor(key: String) -> [Listener]
    {
        if var listeners = entityDeletedListeners[key]{
            return listeners
        }
        else{
            var listeners = [Listener]()
            self.entityDeletedListeners[key] = listeners
            return listeners
        }
    }
}