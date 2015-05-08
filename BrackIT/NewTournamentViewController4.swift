//
//  NewTournamentViewController4.swift
//  BrackIT
//
//  Created by Michael Basquill on 3/31/15.
//  Copyright (c) 2015 Michael Basquill. All rights reserved.
//

import UIKit
import CoreData

class NewTournamentViewController4: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var buttonSave: UIBarButtonItem!
    @IBOutlet weak var pickerPlayerCount: UIPickerView!
    @IBOutlet weak var switchAutoGenerateTeams: UISwitch!

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var newTournament: Tournament!
    
    var playerCountOptions: [Int] = [0,1,2,3,4,5,6,7,8]
    var selectedPlayerCount: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = newTournament.name
        
        pickerPlayerCount.delegate = self
        pickerPlayerCount.dataSource = self
    }
   
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

    @IBAction func savePressed(sender: AnyObject) {
        println("Save pressed")
        newTournament.teamPlayerCount = selectedPlayerCount
        var autoTeams: Bool =  switchAutoGenerateTeams.on ? true : false
        newTournament.autoCreateTeams = autoTeams
        newTournament.createdDate = NSDate()

    }
    
    //Retrieve data for player count picker
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if (row == 0){
            return "Select Player Count"
        }
        else{
            return playerCountOptions[row].description
        }

    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return playerCountOptions.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        println(playerCountOptions[row])
        selectedPlayerCount = playerCountOptions[row]
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func save() {
        var error : NSError?
        if(managedObjectContext!.save(&error)) {
            println(error?.localizedDescription)
        }
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //change this to make sure in save segue
        newTournament.teamPlayerCount = selectedPlayerCount
        newTournament.autoCreateTeams = true
        newTournament.createdDate = NSDate()
        
        save()
        
        
    }


}
