//
//  NewTournamentViewController1.swift
//  BrackIT
//
//  Created by Michael Basquill on 3/31/15.
//  Copyright (c) 2015 Michael Basquill. All rights reserved.
//

import UIKit
import CoreData

class NewTournamentViewController1: UIViewController {
    @IBOutlet weak var textFieldTournamentName: UITextField!
    var newTournament: Tournament!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func continuePressed1(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        //Reference managed object context
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        let entity = NSEntityDescription.entityForName("Tournament", inManagedObjectContext: context)
        
        
        
        //Create instance of of data model an initialize
        // var asd = Tournament();//this is due to an xcode bug
        newTournament = Tournament(entity: entity!, insertIntoManagedObjectContext: context)
        //Map properties
        newTournament.name = textFieldTournamentName.text
        newTournament.createdDate = NSDate()
        newTournament.game = "testGame";

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
   // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        var svc = segue.destinationViewController as NewTournamentViewController2
        svc.inProgressTournament2 = newTournament
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
