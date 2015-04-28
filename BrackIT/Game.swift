//
//  Game.swift
//  
//
//  Created by Michael Basquill on 4/26/15.
//
//

import Foundation
import CoreData

@objc(Game)
class Game: NSManagedObject {

    @NSManaged var gameId: NSNumber
    @NSManaged var round: NSNumber
    @NSManaged var tournament: Tournament
    @NSManaged var teamA: Team?
    @NSManaged var teamB: Team?
    @NSManaged var winner: Team?

}
