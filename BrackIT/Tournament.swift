//
//  Tournament.swift
//  BrackIT
//
//  Created by Michael Basquill on 4/12/15.
//  Copyright (c) 2015 Michael Basquill. All rights reserved.
//

import Foundation
import CoreData

@objc(Tournament)
class Tournament: NSManagedObject {
    
    @NSManaged var autoCreateTeams: NSNumber
    @NSManaged var createdDate: NSDate
    @NSManaged var game: String
    @NSManaged var name: String
    @NSManaged var teamCount: NSNumber
    @NSManaged var teamPlayerCount: NSNumber
    @NSManaged var teams: NSSet
    @NSManaged var tournamentPlayers: NSSet
    @NSManaged var games: NSSet
    
    func playersRequired() ->  Int{
        
        let toReturn: Int =  teamCount.integerValue * teamPlayerCount.integerValue
        return toReturn
    }
    
    func playersSpotsRemaining() ->  Int{
        let toReturn: Int =  ((teamCount.integerValue * teamPlayerCount.integerValue) - tournamentPlayers.count)
        return toReturn
    }

}

