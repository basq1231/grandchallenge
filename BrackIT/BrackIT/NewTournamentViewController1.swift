//
//  NewTournamentViewController1.swift
//  BrackIT
//
//  Created by Michael Basquill on 3/31/15.
//  Copyright (c) 2015 Michael Basquill. All rights reserved.
//

import UIKit
import CoreData

class NewTournamentViewController1: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldTournamentName: UITextField!

    //Get managedObjectContext from app delegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var newTournament: Tournament!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("in view 1")
        
        newTournament = NSEntityDescription.insertNewObjectForEntityForName("Tournament", inManagedObjectContext: managedObjectContext!) as! Tournament
        
        println("Current tournament status")
        NSLog(newTournament.description)

        textFieldTournamentName.delegate = self
        
        
        //self.navigationController?.navigationBarHidden = false
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Force keyboard to close when user touches out of it
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    //Force keyboard to close when user presses done
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textFieldTournamentName.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if (textFieldTournamentName.text != ""){
            self.navigationItem.rightBarButtonItem?.enabled = true
        }
        else{
            self.navigationItem.rightBarButtonItem?.enabled = false
        }
    }
    

    
   // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        //The user cancelled the creation of the tournament
        if let destination = segue.destinationViewController as? BrackItViewController {
            managedObjectContext?.deleteObject(newTournament)
        }
        else{
        //User is advancing to screen 2 of wizard
        newTournament.name = textFieldTournamentName.text
        let destination = segue.destinationViewController as! NewTournamentViewController2
        destination.newTournament = self.newTournament
        }

    }


}
