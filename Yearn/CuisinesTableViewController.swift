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
    @IBOutlet var distanceSuggestionLabel: UILabel!
    
    var testCuisines = [] as NSArray
    var distanceSuggestion = ""
    var medium = "default"
    var cuisineSelected = "American"
    var lon = 0.0
    var lat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.backgroundColor = UIColor.clearColor()
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view, typically from a nib.
        var request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:5000/cuisines/"), cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        var error: NSError?
        
        // Create some JSON data and configure the request
        let jsonString = "json=[{\"medium\":\"\(self.medium)\",\"lat\":\"\(self.lat)\",\"lon\":\"\(self.lon)\"}]"
        request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let queue:NSOperationQueue = NSOperationQueue()
        
        // Make Asynchronous request
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var err: NSError
            
            if error == nil {
                if let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.testCuisines = (jsonResult["cuisines"] as NSArray)
                        self.distanceSuggestionLabel.text = self.distanceSuggestion
                        self.tableView.reloadData()
                    });
                } else {
                    println(error)
                }
            } else {
                println("error")
            }
        })
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
        cell.textLabel?.text = (self.testCuisines[indexPath.row]) as NSString
        cell.textLabel?.font = UIFont(name:"HelveticaNeue-Thin", size:18)
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.clearColor()
        
        var bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.redColor()
        cell.selectedBackgroundView = bgColorView

        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        self.cuisineSelected = self.testCuisines[indexPath.row] as NSString
        self.performSegueWithIdentifier("recommendationSegue", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier != "settings") {
            
            let recommendationCardViewController = segue.destinationViewController as RecommendationCardViewController
            
            recommendationCardViewController.cuisine = self.cuisineSelected
            recommendationCardViewController.medium = self.medium
            recommendationCardViewController.lat = self.lat
            recommendationCardViewController.lon = self.lon
        }
    }
    
}
