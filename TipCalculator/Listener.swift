//
//  Listener.swift
//  TipCalculator
//
//  Created by Peter Helenefors on 2014-07-30.
//  Copyright (c) 2014 Generic Constructions. All rights reserved.
//

import CoreData

class Listener {
    var callback:(NSManagedObject)->Void
    
    init(listener: (NSManagedObject)->Void){
        self.callback = listener
    }
}