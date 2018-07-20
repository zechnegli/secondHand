//
//  HomeCollectionViewCell.swift
//  secondHand
//
//  Created by ZechengLi on 7/1/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit

class HomeTableCollectionViewCell: UICollectionViewCell {
    private var imageView: UIImageView!
    
    public func upateUI(image: UIImage) {
        imageView.image = image
    }
}
