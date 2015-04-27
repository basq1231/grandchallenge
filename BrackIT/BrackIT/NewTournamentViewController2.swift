//
//  NewTournamentViewController2.swift
//  BrackIT
//
//  Created by Michael Basquill on 3/31/15.
//  Copyright (c) 2015 Michael Basquill. All rights reserved.
//

import UIKit
import CoreData

class NewTournamentViewController2: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerGame: UIPickerView!

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var gameOptions: [String] = ["Select Game","Baggo","Horseshoes","Darts","Other"]
    var selectedGame: String!
    var newTournament: Tournament!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("Current tournament status")
        NSLog(newTournament.description)
        self.title = newTournament.name
        
        pickerGame.delegate = self
        pickerGame.dataSource = self
        
        
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        // Do any additional setup after loading the view.
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return gameOptions[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gameOptions.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        println(gameOptions[row])
        selectedGame = gameOptions[row]
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
        newTournament.game = selectedGame
        
        let destination = segue.destinationViewController as! NewTournamentViewController3
        destination.newTournament = self.newTournament
    }

}
