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
    
    //Returns the ID of the game that the winner of the current game would play in next
    func nextGameId() ->Int {
        var nextGameId: Int
        var currentGameId: Int = gameId.integerValue
        
        if currentGameId % 2 == 1 {
            nextGameId = (currentGameId + 1) / 2 + (self.tournament.teamCount.integerValue/2)
        }
        else {
            nextGameId = (currentGameId / 2) + (self.tournament.teamCount.integerValue/2)
        }
        return nextGameId
        
    }

}
