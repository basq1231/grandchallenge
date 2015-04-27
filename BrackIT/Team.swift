//
//  Team.swift
//  BrackIT
//
//  Created by Michael Basquill on 4/12/15.
//  Copyright (c) 2015 Michael Basquill. All rights reserved.
//

import Foundation
import CoreData

@objc(Team)
class Team: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var tournament: Tournament
    @NSManaged var players: NSSet

}
