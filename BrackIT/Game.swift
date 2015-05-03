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
    
    
    func isChampionshipGame() -> Bool {
        var isChampionship: Bool
        //A tournament will have a total number of games equal to the number of teams minus 1
        if (self.gameId.integerValue == (tournament.teamCount.integerValue - 1)) {
            isChampionship = true
        }
        else {
            isChampionship = false
        }
        return isChampionship
    }
    
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
    
    func isMatchupSeg() -> Bool {
        var matchupSet: Bool = false
        if let firstTeam: Team = self.teamA as Team? {
            if let secondTeam: Team = self.teamB {
                matchupSet = true
            }
        }
        
        return matchupSet
    }
    
    func isOver() -> Bool {
        var gameOver: Bool
        
        if let thisWinner: Team = self.winner as Team? {
            gameOver = true
        }
        else {
            gameOver = false
        }
        if self.gameId.integerValue == 7 {
            println("Game 7 is over: \(gameOver)")
        }
        return gameOver
        
    }

}
