//
//  Player.swift
//  BrackIT
//
//  Created by Michael Basquill on 4/12/15.
//  Copyright (c) 2015 Michael Basquill. All rights reserved.
//

import Foundation
import CoreData

@objc(Player)
class Player: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var phone: String
    @NSManaged var playersTeam: Team
    @NSManaged var tournament: Tournament

}
