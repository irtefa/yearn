//
//  CollViewController.swift
//  Yearn
//
//  Created by Mohd Irtefa on 10/8/14.
//  Copyright (c) 2014 Mohd Irtefa. All rights reserved.
//

import UIKit

class CuisinesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    var modeOfTransportation = "default"
    var cuisineSelected = "none"

    @IBOutlet var cuisinesLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    let testCuisines = ["Indian", "American", "Asian", "Burmese", "Greek", "Israeli"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let frameWidth = self.view.frame.size.width
        var width = 0
        var left = 20 as CGFloat
        var right = 20 as CGFloat
        
        if(frameWidth == 320.0) {
            width = Int(frameWidth)/2 - 30
            left = 20
            right = 20
        } else if (frameWidth == 375.0) {
            width = Int(frameWidth)/2 - 60
            left = 49.5
            right = 0.0
        } else if (frameWidth == 414.0) {
            width = Int(frameWidth)/2 - 95
            left = 75.0
            right = 0.0
        }
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
        
        layout.itemSize = CGSize(width: width, height: 168)
        collectionView = UICollectionView(frame: self.collectionView.frame, collectionViewLayout: layout)
        collectionView!.dataSource = self
        collectionView!.delegate = self
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        self.view.addSubview(collectionView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell" as String, forIndexPath: indexPath) as CollectionViewCell
        
        cell.textLabel?.text = self.testCuisines[indexPath.row] as String
        cell.imageView?.image = UIImage(named: "CuisineTileBackground")
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!)
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell" as String, forIndexPath: indexPath) as CollectionViewCell
        
        self.cuisineSelected = self.testCuisines[indexPath.row]
        self.performSegueWithIdentifier("recommendationSegue", sender: self)
    }
    
    //MARK:- UICollectionView Delegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.testCuisines.count
    }
    
    /*
    // MARK: - Navigation
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier != "settings") {

            let recommendationCardViewController = segue.destinationViewController as RecommendationCardViewController

            recommendationCardViewController.cuisine = self.cuisineSelected
        }
    }
}
