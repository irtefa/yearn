//
//  SettingsViewController.swift
//  Yearn
//
//  Created by Mohd Irtefa on 10/19/14.
//  Copyright (c) 2014 Mohd Irtefa. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var emailAddressField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailAddressField.delegate = self
        // Do any additional setup after loading the view.
        
        // Hide keyboard when touching outside of emailAddressField
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedSaveButton(sender: UIBarButtonItem) {
        println("Pressed save button")
        self.emailAddressField.resignFirstResponder()
        println("This is your email address: \(self.emailAddressField.text)")
        
        
        
        var user = PFUser();
        
        user.username = self.emailAddressField.text.componentsSeparatedByString("@")[0]
        user.email = self.emailAddressField.text
        user.password = "nopassword"
        
        // other fields can be set just like with PFObject
        user.signUpInBackgroundWithBlock({
            (success: Bool, error: NSError!) -> Void in
            if (error != nil) {
                // Hooray! Let them use the app now.
                var currentUser = PFUser.currentUser()
                
                if (currentUser != nil) {
                    println(currentUser)
                }

            } else {
//                error.userInfo("error")
            }
        })
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
