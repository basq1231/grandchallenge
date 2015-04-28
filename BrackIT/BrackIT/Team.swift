//
//  Team.swift
//
//
//  Created by Michael Basquill on 4/26/15.
//
//

import Foundation
import CoreData

@objc(Team)
class Team: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var players: NSSet
    @NSManaged var tournament: Tournament
    @NSManaged var homeGames: NSSet
    @NSManaged var awayGames: Game
    @NSManaged var wins: NSSet
    
}
