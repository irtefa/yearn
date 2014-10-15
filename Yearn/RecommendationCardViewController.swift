//
//  RecommendationCardViewController.swift
//  Yearn
//
//  Created by Mohd Irtefa on 9/23/14.
//  Copyright (c) 2014 Mohd Irtefa. All rights reserved.
//
import Foundation
import UIKit
class RecommendationCardViewController: UIViewController {
    var cuisine = "none"

    @IBOutlet var restaurantNameLabel: UILabel!
    @IBOutlet var taglineLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        var request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:5000/recommendation/"), cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        var error: NSError?
        
        // create some JSON data and configure the request
        let jsonString = "json=[{\"cuisine\":\"American\",\"medium\":\"walk\"}]"
        request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let queue:NSOperationQueue = NSOperationQueue()

        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var err: NSError
            var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary

            dispatch_async(dispatch_get_main_queue(), {
                self.taglineLabel.text = (jsonResult["tagline"] as String)
                self.restaurantNameLabel.text = (jsonResult["name"] as String)
            });

        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressedCallButton(sender: AnyObject) {
        println("pressed call button")
        var uuid = NSUUID.UUID().UUIDString
        println(uuid)
    }
    @IBAction func pressedMapsButton(sender: UIButton) {
        // Add Event
        var request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:5000/add-event/"), cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        var error: NSError?
        
        let jsonString = "json=[{\"user_email\":\"fake@fake\",\"medium\":\"walk\",\"restaurant_id\":\"99\", \"event_type\":\"went\" }]"
        request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let queue:NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var err: NSError
            println(response)
        })

        // Button pressed event
        println("Pressed Tick Button")
        UIApplication.sharedApplication().openURL(NSURL.URLWithString("http://maps.google.com/maps?q=india"))
    }
}
