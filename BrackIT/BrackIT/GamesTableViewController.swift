//
//  GamesTableViewController.swift
//  BrackIT
//
//  Created by Michael Basquill on 4/26/15.
//  Copyright (c) 2015 Michael Basquill. All rights reserved.
//

import UIKit
import CoreData


class GamesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var currentTournament: Tournament!
    //var teams : Array <AnyObject> = []
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController()
    
    func getFetchedResultsController() ->NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: gameFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: "round", cacheName: nil)
        return fetchedResultsController
    }
    
    func gameFetchRequest() ->NSFetchRequest {
        let request = NSFetchRequest(entityName: "Game")
        let predicate = NSPredicate(format: "tournament = %@", currentTournament)
        let sortDescriptor = NSSortDescriptor(key: "round", ascending: true)
        request.predicate = predicate
        request.sortDescriptors = [sortDescriptor]
        
        
        return request
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController = getFetchedResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
        println("total games created: /(currentTournament.games.count)")
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        println("Section count \(sectionCount)")
        return sectionCount!
    }
    
    //Set the section header as the team name
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchedResultsController.sections {
            let currentSection = sections[section] as! NSFetchedResultsSectionInfo
            return currentSection.name
        }
        return nil
    }
    
    
    //Number of rows in the section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        let sectionRowCount = fetchedResultsController.sections?[section].numberOfObjects
        return sectionRowCount!
    }
    
    
    //Populate cell in table
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("gameCell") as! UITableViewCell
        var nameTeamA: String = "TBD"
        var nameTeamB: String = "TBD"
        
        var cellData: Game = fetchedResultsController.objectAtIndexPath(indexPath) as! Game
        if let teamA = cellData.teamA as Team? {
            nameTeamA = teamA.name
        }

        if let teamB = cellData.teamB as Team? {
            nameTeamB = teamB.name
        }

        
        let cellTitle: String = nameTeamA + " vs. " + nameTeamB
        
        cell.textLabel!.text = cellTitle
        cell.detailTextLabel!.text = cellData.round.stringValue
        
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}