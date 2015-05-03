//
//  gameTableViewCell.swift
//  BrackIT
//
//  Created by Michael Basquill on 4/27/15.
//  Copyright (c) 2015 Michael Basquill. All rights reserved.
//

import UIKit
import CoreData

class gameTableViewCell: UITableViewCell, NSFetchedResultsControllerDelegate {

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    var currentGame: Game!

    
    @IBOutlet weak var button_teamA: UIButton!
    @IBOutlet weak var button_teamB: UIButton!
    
    
    func nextGameFetchRequest() ->NSFetchRequest {
        let nextRound: Int = currentGame.round.integerValue + 1
        let nextGameId: Int = currentGame.nextGameId()
        
        
        let request = NSFetchRequest(entityName: "Game")
        let predicateTournament = NSPredicate(format: "tournament = %@", currentGame.tournament)
        let predicateRound = NSPredicate(format: "round = %i", nextRound)
        let predicateGameId = NSPredicate(format: "gameId = %i", nextGameId)
        let predicate = NSCompoundPredicate.andPredicateWithSubpredicates([predicateTournament, predicateRound, predicateGameId])

        request.predicate = predicate

        return request
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
 
    
    @IBAction func teamASelected(sender: UIButton) {
        if currentGame.isMatchupSeg() {
            
        if currentGame.isChampionshipGame() {
            //The champion can always be updated since it's the last game
            if currentGame.isOver()
            {
                //Winner is being de-selected
                if currentGame.winner!.name == sender.titleLabel?.text {
                    unformatTeams()
                    currentGame.winner = nil
                }
                //Champion is being reset
                else {
                    formatWinner(sender)
                    setWinningTeam(sender, nextGame: nil)
                }
            }
            //Champion is being set for first time
            else {
                formatWinner(sender)
                setWinningTeam(sender, nextGame: nil)
            }
        }
            //Not the championship game
        else {
            let nextGame: Game = getNextGame()
            
            if (nextGame.isOver() == false) {
                if (currentGame.isOver()) {
                    //Winner is being de-selected
                    if currentGame.winner!.name == sender.titleLabel?.text {
                        undoWinner(nextGame)
                    }
                    //winner is being reset
                    else {
                        formatWinner(sender)
                        setWinningTeam(sender, nextGame: nextGame)
                    }
                }
                else {
                    //Winner is being set for first time
                    formatWinner(sender)
                    setWinningTeam(sender, nextGame: nextGame)

                }
            }
            else {
                //Do nothing. If the next game was played, you can't change history
            }
        }
        
        save()//move this. this is saving when nothing should save
        }
    }
    
    func undoWinner(nextGame: Game) {
        unformatTeams()
        currentGame.winner = nil
        
        if (currentGame.gameId.integerValue % 2 == 0) {
            nextGame.teamB = nil
            println("about to nil out teamB")
            println("Game id:  \(nextGame.gameId)")
        }
        else {
            nextGame.teamA = nil
        }
        save()//new
    }
    
    
    func formatWinner(winnerButton: UIButton) {
        
        unformatTeams()
        
        winnerButton.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
        
    }
    
    func initializeLabels() {
        if currentGame.isOver() {
            if currentGame.winner == currentGame.teamA {
                button_teamA.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)

            }
            else {
                button_teamB.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)

            }
        }
    }
    
    //Rest team labels to black text
    func unformatTeams() {
        button_teamA.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button_teamB.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    }
    
    

    
    func getNextGame() -> Game {
        var nextGames = [Game]()
        var nextGame: Game
        nextGames = managedObjectContext?.executeFetchRequest(nextGameFetchRequest(), error: nil) as! [Game]
        
        //TODO: Add more checks on the returned results
            nextGame = nextGames[0]
            return nextGame

        
        
    }
    
    func advanceWinner(winner: Team, nextGame: Game) {
            println("advancing the winner, \(winner.name) to the next round, \(nextGame.gameId)")
            //If the current game is even-numbered, the winner will be team B in next round; otherwise they will be team A
            if (currentGame.gameId.integerValue % 2 == 0) {
                println("setting teamB as winner for game id: \(nextGame.gameId)")
                
                nextGame.teamB = winner
            }
            else {
                nextGame.teamA = winner
            }
            save()//new
    }
    
    func save() {
        println("Saving game winner")
        var error : NSError?
        if(managedObjectContext!.save(&error)) {
            println(error?.localizedDescription)
        }
        //NSLog(currentGame.description)
    }
    
    //Sets the winner of the current team by the button pressed
    func setWinningTeam(winningTeam: UIButton, nextGame: Game?) {
        if winningTeam == button_teamA {
            currentGame.winner = currentGame.teamA
            if currentGame.isChampionshipGame() == false {
                advanceWinner(currentGame.teamA!, nextGame: nextGame!)
            }
        }
        else {
            currentGame.winner = currentGame.teamB
            if currentGame.isChampionshipGame() == false {
                advanceWinner(currentGame.teamB!, nextGame: nextGame!)
            }
        }
        save() //new
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
