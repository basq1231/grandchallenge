//
//  SettingsViewController.swift
//  BrackIT
//
//  Created by Michael Basquill on 4/13/15.
//  Copyright (c) 2015 Michael Basquill. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var label_TournamentName: UILabel!
    @IBOutlet weak var textField_playerCt: UILabel!
    @IBOutlet weak var textField_autoGenerate: UILabel!
    @IBOutlet weak var textField_teamCt: UILabel!
    @IBOutlet weak var textField_createdDt: UILabel!
    @IBOutlet weak var textField_gameType: UILabel!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var currentTournament: Tournament!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        label_TournamentName.text = currentTournament.name
        textField_gameType.text = currentTournament.game
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        textField_createdDt.text = dateFormatter.stringFromDate(currentTournament.createdDate)
        textField_playerCt.text = toString(currentTournament.teamPlayerCount)
        textField_teamCt.text = toString(currentTournament.teamCount)
        var autoGenerateTeams: String = currentTournament.autoCreateTeams == true ? "Yes" : "No"
        textField_autoGenerate.text = autoGenerateTeams

        // Do any additional setup after loading the view.
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
