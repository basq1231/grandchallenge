//
//  NewTournamentViewController4.swift
//  BrackIT
//
//  Created by Michael Basquill on 3/31/15.
//  Copyright (c) 2015 Michael Basquill. All rights reserved.
//

import UIKit

class NewTournamentViewController4: UIViewController {

    @IBOutlet weak var pickerPlayerCount: UIPickerView!
    @IBOutlet weak var switchAutoGenerateTeams: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func savePressed(sender: AnyObject) {
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
