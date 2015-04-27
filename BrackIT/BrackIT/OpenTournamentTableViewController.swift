//
//  OpenTournamentTableViewController.swift
//  BrackIT
//
//  Created by Michael Basquill on 4/6/15.
//  Copyright (c) 2015 Michael Basquill. All rights reserved.
//

import UIKit
import CoreData

class OpenTournamentTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    @IBOutlet var tavleView: UITableView!
    
    var tournaments : Array <AnyObject> = []
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController()
    
    func getFetchedResultsController() ->NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: tournamentFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
    
    func tournamentFetchRequest() ->NSFetchRequest {
        let request = NSFetchRequest(entityName: "Tournament")
        let sortDescriptor = NSSortDescriptor(key: "createdDate", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController = getFetchedResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
        
        
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
        return sectionCount!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        let sectionRowCount = fetchedResultsController.sections?[section].numberOfObjects
        return sectionRowCount!
    }

    
    //Populate cell in table
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TournamentCell") as! UITableViewCell

        var cellData: Tournament = fetchedResultsController.objectAtIndexPath(indexPath) as! Tournament
        cell.textLabel!.text = cellData.name
        cell.detailTextLabel!.text = cellData.game
        
        return cell
    }


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
        
        if (segue.identifier == "openTournament") {
        let destination = segue.destinationViewController as! CurrentTouramentViewController
        let currentCell = sender as! UITableViewCell
        let index = tableView.indexPathForCell(currentCell)
        let currentTournament: Tournament = fetchedResultsController.objectAtIndexPath(index!) as! Tournament
        destination.currentTournament = currentTournament
        NSLog(currentTournament.description)
        }
        
        
        

    }
    

}
