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
    var restaurantName = ""
    var cuisine = "none"
    var medium = "default"
    var lat = 41.8959273
    var lon = -87.784242
    var dlat = ""
    var dlon = ""
    
    @IBOutlet var restaurantNameLabel: UILabel!
    @IBOutlet var taglineLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        var request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:5000/recommendation/"), cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        var error: NSError?
        
        // Create some JSON data and configure the request
        let jsonString = "json=[{\"cuisine\":\"\(self.cuisine)\",\"medium\":\"\(self.medium)\",\"lat\":\"\(self.lat)\",\"lon\":\"\(self.lon)\"}]"
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
//                      self.taglineLabel.text = (jsonResult["tagline"] as String)
                        self.taglineLabel.text = ""
                        self.restaurantName = (jsonResult["name"] as String)
                        self.restaurantNameLabel.text = (jsonResult["name"] as String)

                        // Find location from result
                        var pin = jsonResult["pin"] as NSDictionary
                        var location = pin as NSDictionary
                        var geolocation = location["location"] as NSDictionary

                        self.dlon = NSString(format: "%f", geolocation["lon"] as Double)
                        self.dlat = NSString(format: "%f", geolocation["lat"] as Double)
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

    @IBAction func pressedCallButton(sender: AnyObject) {
        println("pressed call button")
        var phoneNumber = "217-974-0815"
        UIApplication.sharedApplication().openURL(NSURL.URLWithString(phoneNumber));
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
        var testURL = NSURL.URLWithString("comgooglemaps-x-callback://")
        if (UIApplication.sharedApplication().canOpenURL(testURL)) {
            var directionsRequest = "comgooglemaps-x-callback://" +
            "daddr=\(self.dlat),\(self.dlon)" +
            "&saddr=\(self.lat),\(self.lon)" +
            "&x-success=sourceapp://?resume=true&x-source=AirApp";
            var directionsURL = NSURL.URLWithString(directionsRequest);
            UIApplication.sharedApplication().openURL(directionsURL);
        } else {
            println("Can't use comgooglemaps-x-callback:// on this device.");
            UIApplication.sharedApplication().openURL(NSURL.URLWithString("http://maps.google.com/maps?daddr=\(self.dlat),\(self.dlon)" +
                "&saddr=\(self.lat),\(self.lon)" +
                "&x-success=sourceapp://?resume=true&x-source=AirApp"))
        }
    }
}
