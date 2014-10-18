//
//  HowFarViewController.swift
//  Yearn
//
//  Created by Mohd Irtefa on 9/23/14.
//  Copyright (c) 2014 Mohd Irtefa. All rights reserved.
//

import UIKit
import CoreLocation

class HowFarViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var seenError : Bool = false
    var locationFixAchieved : Bool = false
    var locationStatus : NSString = "Not Started"
    var lat = 0.0
    var lon = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Yearn"
        
        // Set View Related Properties
        self.howFarPromptLabel.adjustsFontSizeToFitWidth = true
        self.howFarPromptLabel.textColor = UIColor.whiteColor()
        self.howFarPromptLabel.font = UIFont(name:"HelveticaNeue-Thin", size:100)
        self.howFarPromptLabel.textAlignment = .Left
     
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
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
                cuisinesViewController.medium = "walk"
            } else if (segue.identifier == "driveSegueIdentifier") {
                cuisinesViewController.medium = "drive"
            }
            
            cuisinesViewController.lat = self.lat
            cuisinesViewController.lon = self.lon
        }
    }
    
    //MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError?) {
        locationManager.stopUpdatingLocation()
        if (error != nil) {
            print(error)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if (self.locationFixAchieved == false) {
            self.locationFixAchieved = true
            var locationArray = locations as NSArray?
            var locationObj = locationArray?.lastObject as CLLocation
            var coord = locationObj.coordinate
            
            println(coord.latitude)
            self.lat = coord.latitude
            println(coord.longitude)
            self.lon = coord.longitude
        }
    }
    
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            var shouldIAllow = false
            
            switch status {
            case CLAuthorizationStatus.Restricted:
                locationStatus = "Restricted Access to location"
            case CLAuthorizationStatus.Denied:
                locationStatus = "User denied access to location"
            case CLAuthorizationStatus.NotDetermined:
                locationStatus = "Status not determined"
            default:
                locationStatus = "Allowed to location Access"
                shouldIAllow = true
            }
            NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
            if (shouldIAllow == true) {
                NSLog("Location to Allowed")
                // Start location services
                locationManager.startUpdatingLocation()
            } else {
                NSLog("Denied access: \(locationStatus)")
            }
    }
}

