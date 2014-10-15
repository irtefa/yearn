//
//  CuisinesTableViewController.swift
//  Yearn
//
//  Created by Mohd Irtefa on 10/14/14.
//  Copyright (c) 2014 Mohd Irtefa. All rights reserved.
//

import UIKit

class CuisinesTableViewController: UIViewController, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!

    let testCuisines = ["Indian", "American", "Asian", "Burmese", "Greek", "Israeli"]
    
    var modeOfTransportation = "default"
    var cuisineSelected = "American"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.backgroundColor = UIColor.clearColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.testCuisines.count;
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell

        // Cell Style and Text
        cell.textLabel?.text = self.testCuisines[indexPath.row]
        cell.textLabel?.font = UIFont(name:"HelveticaNeue-Thin", size:18)
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.clearColor()
        
        var bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.redColor()
        cell.selectedBackgroundView = bgColorView

        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You selected \(self.testCuisines[indexPath.row])!")
        self.cuisineSelected = self.testCuisines[indexPath.row]
        self.performSegueWithIdentifier("recommendationSegue", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier != "settings") {
            
            let recommendationCardViewController = segue.destinationViewController as RecommendationCardViewController
            
            recommendationCardViewController.cuisine = self.cuisineSelected
        }
    }
    
}
