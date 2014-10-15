//
//  HowFarViewController.swift
//  Yearn
//
//  Created by Mohd Irtefa on 9/23/14.
//  Copyright (c) 2014 Mohd Irtefa. All rights reserved.
//

import UIKit

class HowFarViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Yearn"
        
        self.howFarPromptLabel.adjustsFontSizeToFitWidth = true
        self.howFarPromptLabel.textColor = UIColor.whiteColor()
        self.howFarPromptLabel.font = UIFont(name:"HelveticaNeue-Thin", size:100)
        self.howFarPromptLabel.textAlignment = .Left
    }
    
    @IBOutlet var howFarPromptLabel: UILabel!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier != "settings") {
            let cuisinesViewController = segue.destinationViewController as CuisinesTableViewController

            if (segue.identifier == "walkSegueIdentifier") {
                cuisinesViewController.modeOfTransportation = "walk"
            } else if (segue.identifier == "driveSegueIdentifier") {
                cuisinesViewController.modeOfTransportation = "drive"
            }
        }
    }
}

