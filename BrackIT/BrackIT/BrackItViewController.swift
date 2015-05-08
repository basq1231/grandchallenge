//
//  ViewController.swift
//  BrackIT
//
//  Created by Michael Basquill on 3/8/15.
//  Copyright (c) 2015 Michael Basquill. All rights reserved.
//

import UIKit
import CoreData

class BrackItViewController: UIViewController {
    @IBOutlet weak var labelTournamentCount: UILabel!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    var tournamentsSaved: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest = NSFetchRequest(entityName: "Tournament")
        println("Count:")
        println(managedObjectContext!.executeFetchRequest(fetchRequest, error: nil)?.count.description)
        tournamentsSaved = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil)?.count.description
        labelTournamentCount.text = tournamentsSaved
        

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let fetchRequest = NSFetchRequest(entityName: "Tournament")

        tournamentsSaved = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil)?.count.description
        labelTournamentCount.text = tournamentsSaved
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindToMainMenu(segue: UIStoryboardSegue)
    {
        println("in unwind to main menu")
        

        //self.performSegueWithIdentifier("goToNewTournamentOne", sender: self)
    }
    
    @IBAction func unwindToMainMenuByCancel(segue: UIStoryboardSegue)
    {
        println("TOURNAMENT CANCELLED")
    }
}

