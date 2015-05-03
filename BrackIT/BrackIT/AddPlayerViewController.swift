//
//  AddPlayerViewController.swift
//  BrackIT
//
//  Created by Michael Basquill on 4/15/15.
//  Copyright (c) 2015 Michael Basquill. All rights reserved.
//

import UIKit
import CoreData

class AddPlayerViewController: UIViewController {
    @IBOutlet weak var textField_name: UITextField!

    @IBOutlet weak var button_save: UINavigationItem!
    @IBOutlet weak var textField_number: UITextField!

    @IBOutlet weak var button_bottomSave: UIButton!
    @IBOutlet weak var button_saveAddAnother: UIButton!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var currentTournament: Tournament!
    var newPlayer: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeSaveAddAnotherIfNecessary()

        // Do any additional setup after loading the view.
    }

    //Force keyboard to close when user touches out of it
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    //Force keyboard to close when user presses done
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField_name.resignFirstResponder()
        return true
    }
 
    
    @IBAction func savePressed(sender: AnyObject) {
        
        newPlayer = NSEntityDescription.insertNewObjectForEntityForName("Player", inManagedObjectContext: managedObjectContext!) as! Player
        newPlayer.name = textField_name.text
        newPlayer.tournament = currentTournament
        NSLog(newPlayer.description)
        save()
        if (sender as! NSObject == button_saveAddAnother) {
            textField_name.text = nil
            //textField_number.text = nil
            removeSaveAddAnotherIfNecessary()
        }
        else {
        self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func save() {
        println("Saving player")
        var error : NSError?
        if(managedObjectContext!.save(&error)) {
            println(error?.localizedDescription)
        }
        NSLog(newPlayer.description)
    }
    
    func removeSaveAddAnotherIfNecessary() {
        if currentTournament.playersSpotsRemaining() < 2 {
            button_saveAddAnother.hidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
