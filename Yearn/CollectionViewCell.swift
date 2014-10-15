//
//  CollectionViewCell.swift
//  UICollectionView
//
//  Created by Mohd Irtefa on 2014-09-04.
//  Copyright (c) 2014 Brian Coleman. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let textLabel: UILabel!
    let imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))

        contentView.addSubview(imageView)
        
        let textFrame = CGRect(x: 2, y: 50, width: frame.size.width, height: frame.size.height/3)
        textLabel = UILabel(frame: textFrame)
        textLabel.textColor = UIColor.whiteColor()
        textLabel.font = UIFont(name:"HelveticaNeue-Thin", size:18)
        textLabel.textAlignment = .Center
        contentView.addSubview(textLabel)
    }
}

