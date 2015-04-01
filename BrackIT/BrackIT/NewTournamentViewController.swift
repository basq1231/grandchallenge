//
//  NewTournamentViewController.swift
//  BrackIT
//
//  Created by Michael Basquill on 3/31/15.
//  Copyright (c) 2015 Michael Basquill. All rights reserved.
//

import UIKit
import CoreData

class NewTournamentViewController: UIViewController {

    @IBOutlet weak var pickerGameType: UIPickerView! = UIPickerView()
    @IBOutlet weak var textFieldTournamentName: UITextField! = nil
    @IBOutlet weak var pickerTeamCount: UIPickerView! = UIPickerView()
    @IBOutlet weak var pickerPlayerCount: UIPickerView! = UIPickerView()
    @IBOutlet weak var switchAutoSelectTeams: UISwitch! = UISwitch()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func continueTapped1(sender: AnyObject) {
        println("continue 1 pressed")
        //println(textFieldTournamentName.text)
            }
    @IBAction func continueTapped2(sender: AnyObject) {
        println("continue 1 pressed")
        println(textFieldTournamentName.text)
    }
    @IBAction func continueTapped3(sender: AnyObject) {
    }
    @IBAction func saveTapped(sender: AnyObject) {
println("save was pressed")
        
        
        
        //Reference app delegate
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        //Reference managed object context
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        let entity = NSEntityDescription.entityForName("Tournament", inManagedObjectContext: context)
        
        

        //Create instance of of data model an initialize
       // var asd = Tournament();//this is due to an xcode bug
        var newTournament = Tournament(entity: entity!, insertIntoManagedObjectContext: context)
        //Map properties
        newTournament.name = textFieldTournamentName.text
        newTournament.createdDate = NSDate()
        newTournament.game = "testGame";
        newTournament.teamCount = 8;
        newTournament.teamPlayerCount = 2;
        newTournament.autoCreateTeams = true;
        

        //save context
        context.save(nil)
        
        println(newTournament)
        
        println("Object saved")
        
        //nav back to root controller
        self.navigationController?.popToRootViewControllerAnimated(true)
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
