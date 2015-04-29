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
 
    
    @IBAction func teamASelected(sender: AnyObject) {
        if let currentWinner = currentGame.winner as Team? {
            //A winner was previously selected
            if (button_teamA.titleLabel!.text == currentWinner.name) {
                //deselect current winner. reset winner to nil
                currentGame.winner = nil
                button_teamA.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            }
                //Winner is being changed
            else {
                //select team A, deselect team B
                currentGame.winner = currentGame.teamA
                println("team A should become winner and team b should deselect")
                button_teamA.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
                button_teamB.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            }
        }
            //
        else {
            println("team a was selected as orig winner")
            currentGame.winner = currentGame.teamA
            button_teamA.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
        }
        save()
        advanceWinner(currentGame.teamA!)
    }
    
    
    @IBAction func teamBSelected(sender: AnyObject) {
        if let currentWinner = currentGame.winner as Team? {
            if (button_teamB.titleLabel?.text == currentWinner.name) {
                //deselect current winner. reset winner to nil
                println("team a was deselected")
                currentGame.winner = nil
                button_teamB.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            }
            else {
                //select team B, deselect team A
                currentGame.winner = currentGame.teamB
                println("team B should become winner and team A should deselect")
                button_teamB.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
                button_teamA.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            }
        }
        else {
            println("team B was selected as orig winner")
            currentGame.winner = currentGame.teamB
            button_teamB.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
        }
        save()
        advanceWinner(currentGame.teamB!)

    }
    
    func getNextGame() {
        
    }
    
    func advanceWinner(winner: Team) {
        println("in advance winner method")
        var nextGames = [Game]()
        nextGames = managedObjectContext?.executeFetchRequest(nextGameFetchRequest(), error: nil) as! [Game]
        if (nextGames.count == 1) {
            println("advance winner: returned one row!")
            var nextGame: Game = nextGames[0]
            if (currentGame.gameId.integerValue % 2 == 0) {
                nextGame.teamB = winner
            }
            else {
                nextGame.teamA = winner
            }
            save()
        }
        else {
            println("fetch did not return one row :(")
        }
    }
    
    func save() {
        println("Saving game winner")
        var error : NSError?
        if(managedObjectContext!.save(&error)) {
            println(error?.localizedDescription)
        }
        NSLog(currentGame.description)
    }
    
    func setWinningTeam(winningTeam: Team) {
        if winningTeam == currentGame.teamA {
            button_teamA.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
        }
        else if (winningTeam == currentGame.teamB) {
            button_teamB.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
