//
//  NewTournamentViewController3.swift
//  BrackIT
//
//  Created by Michael Basquill on 3/31/15.
//  Copyright (c) 2015 Michael Basquill. All rights reserved.
//

import UIKit
import CoreData

class NewTournamentViewController3: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerTeamCount: UIPickerView!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var newTournament: Tournament!
    var teamNumberOptions: [Int] = [0,2,4,8,16,32,64]
    var selectedTeamCount: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("I'm in view 3")
        println("Current tournament status")
        NSLog(newTournament.description)
        self.title = newTournament.name
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        pickerTeamCount.delegate = self
        pickerTeamCount.dataSource = self

    }

    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if (row == 0){
        return "Select Team Count"
        }
        else{
        return teamNumberOptions[row].description
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return teamNumberOptions.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        println(teamNumberOptions[row])
        selectedTeamCount = teamNumberOptions[row]
        if (row == 0)
        {
        self.navigationItem.rightBarButtonItem?.enabled = false
        }
        else{
            self.navigationItem.rightBarButtonItem?.enabled = true
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        newTournament.teamCount = selectedTeamCount
        
        let destination = segue.destinationViewController as! NewTournamentViewController4
        destination.newTournament = self.newTournament

    }

}
