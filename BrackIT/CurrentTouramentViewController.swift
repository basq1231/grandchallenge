//
//  CurrentTouramentViewController.swift
//  BrackIT
//
//  Created by Michael Basquill on 4/12/15.
//  Copyright (c) 2015 Michael Basquill. All rights reserved.
//

import UIKit
import CoreData



class CurrentTouramentViewController: UIViewController {

    @IBOutlet weak var button_viewTeams: UIButton!
    @IBOutlet weak var button_addPlayers: UIButton!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var currentTournament: Tournament!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = currentTournament.name
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        displayTeamOrPlayersButton()
        
    }
    
    func displayTeamOrPlayersButton() {
        println("Team count \(currentTournament.teams.count)")
        println("Player count \(currentTournament.tournamentPlayers.count)")
        //Show "Add Players" only if there
        if currentTournament.teams.count == 0 {
            button_viewTeams.hidden = true
            button_addPlayers.hidden = false
        }
        else {
            button_addPlayers.hidden = true
            button_viewTeams.hidden = false
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "openSettings") {
            let destination = segue.destinationViewController as! SettingsViewController
            destination.currentTournament = self.currentTournament
        }
        if (segue.identifier == "editPlayers") {
            let destination = segue.destinationViewController as! PlayersTableViewController
            destination.currentTournament = self.currentTournament
        }
        if (segue.identifier == "viewTeamsTable") {
            let destination = segue.destinationViewController as! ViewTeamsTableViewController
            destination.currentTournament = self.currentTournament
        }
        if (segue.identifier == "openBracket") {
            let destination = segue.destinationViewController as! GamesTableViewController
            destination.currentTournament = self.currentTournament
        }
        
    }
    

}
