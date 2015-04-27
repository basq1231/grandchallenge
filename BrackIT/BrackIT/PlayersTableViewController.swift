//
//  PlayersTableViewController.swift
//  BrackIT
//
//  Created by Michael Basquill on 4/15/15.
//  Copyright (c) 2015 Michael Basquill. All rights reserved.
//

import UIKit
import CoreData

class PlayersTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    @IBOutlet var playerTableView: UITableView!
    @IBOutlet weak var bottomBarLabel: UIBarButtonItem!
    @IBOutlet weak var bottomBarBrackIt: UIBarButtonItem!

    @IBOutlet weak var bottomBar: UIToolbar!

    var currentTournament: Tournament!
    var players : Array <AnyObject> = []
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController()
    
    func getFetchedResultsController() ->NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: playerFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
    
    func playerFetchRequest() ->NSFetchRequest {
        let request = NSFetchRequest(entityName: "Player")
        let predicate = NSPredicate(format: "tournament = %@", currentTournament)
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.predicate = predicate
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("in the player table view controller")
        fetchedResultsController = getFetchedResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
        
        for x in currentTournament.teams {
            println(x.name)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateBottomBar()
    }
    
    func updateBottomBar() {
        if (currentTournament.teams.count == 0)
        {
        println("Team count: \(currentTournament.teams.count)")
        //Set player count label
        let playersRequired: Int = currentTournament.playersRequired()
        let label: String = "\(currentTournament.tournamentPlayers.count) of \(playersRequired) Entered"
        //let label: String = "\(currentTournament.tournamentPlayers.count) of \(currentTournament.playersRequired()) Entered"
        bottomBarLabel.title = label
        if (currentTournament.playersSpotsRemaining() > 0) {
            bottomBarBrackIt.enabled = false
            bottomBarLabel.tintColor = UIColor.redColor()
        }
        else {
            //No more players should be added
            self.navigationItem.rightBarButtonItem?.enabled = false
            bottomBarLabel.tintColor = UIColor.greenColor()
            bottomBarBrackIt.enabled = true
        }
        }
        else {
            self.navigationItem.rightBarButtonItem?.enabled = false
            bottomBar.hidden = true
        }
    }

    @IBAction func brackItPressed(sender: AnyObject) {
        println("brackit pressed")
        createRandomTeams()
        createMatchups()
        
        
    }
    
    func createRandomTeams() {
        var teams = [Team]()
        for index in 1...currentTournament.teamCount.integerValue {
            var newTeam: Team = NSEntityDescription.insertNewObjectForEntityForName("Team", inManagedObjectContext: managedObjectContext!) as! Team
            newTeam.name = "Team \(index)"
            newTeam.tournament = currentTournament
            teams.append(newTeam)
            save()
            updateBottomBar()
        }
        
        var players = [Player]()
        for currentPlayer in currentTournament.tournamentPlayers {
            players.append(currentPlayer as! Player)
        }
        
        
        var OrderedPlayers = [Player]()
        
        for index in 1...currentTournament.tournamentPlayers.count {
            var maxNum: UInt32 = UInt32(players.count)
            var randomInt: Int = Int(arc4random_uniform(maxNum))
            OrderedPlayers.append(players.removeAtIndex(randomInt))
        }
        
        for team in teams{
            for index in 1...currentTournament.teamPlayerCount.integerValue{
                OrderedPlayers.first?.playersTeam = team
                OrderedPlayers.removeAtIndex(0)
            }
        }
        println("about to save teams and players")
        save()
        println("finished saving teams and players!!!!!!")

    }
    
    func createMatchups() {
        var newGame: Game = NSEntityDescription.insertNewObjectForEntityForName("Team", inManagedObjectContext: managedObjectContext!) as! Game
    }
    
    func save() {
        println("Saving players and teams")
        var error : NSError?
        if(managedObjectContext!.save(&error)) {
            println(error?.localizedDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Called when the Fetched Results Controller changes
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        let sectionCount = fetchedResultsController.sections?.count
        return sectionCount!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        let sectionRowCount = fetchedResultsController.sections?[section].numberOfObjects
        return sectionRowCount!
    }
    
    
    //Populate cell in table
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell") as! UITableViewCell
        
        var cellData: Player = fetchedResultsController.objectAtIndexPath(indexPath) as! Player
        cell.textLabel!.text = cellData.name
        if let x = cellData.playersTeam as Team? {
            cell.detailTextLabel!.text = cellData.playersTeam.name
            
        }
        else {
            cell.detailTextLabel?.text = "No team"
        }
        NSLog(cellData.description)
        return cell
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! AddPlayerViewController
        destination.currentTournament = self.currentTournament
    }
    

}
