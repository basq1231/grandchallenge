//
//  Tournament.swift
//  BrackIT
//
//  Created by Michael Basquill on 3/8/15.
//  Copyright (c) 2015 Michael Basquill. All rights reserved.
//

import Foundation
import CoreData

@objc(Tournament)
class Tournament: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var game: String
    @NSManaged var createdDate: NSDate
    @NSManaged var teamCount: NSNumber
    @NSManaged var teamPlayerCount: NSNumber
    @NSManaged var autoCreateTeams: NSNumber
    

}

