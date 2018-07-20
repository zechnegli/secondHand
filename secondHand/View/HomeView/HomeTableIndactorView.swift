//
//  HomeTableIndactorView.swift
//  secondHand
//
//  Created by ZechengLi on 6/18/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit

class HomeTableIndactorView: UIView {
    var newLabel = UILabel()
    var nearbyLabel = UILabel()
    var sliderView = UIView()
    //set up sublabels's font and fot color
    override func awakeFromNib() {
        sliderView.backgroundColor = UIColor.blue
        newLabel.text = "新鲜的"
        nearbyLabel.text = "附近的"
        newLabel.textColor = UIColor.black
        nearbyLabel.textColor = UIColor.black
        //adjust font size
        
        
    }
    
    func setLabelPosition(newLabelRect: CGRect, nearbyLabelRect: CGRect) {
        newLabel.frame = newLabelRect
        nearbyLabel.frame = nearbyLabelRect
        newLabel.backgroundColor = UIColor.blue
        nearbyLabel.backgroundColor = UIColor.black
        self.addSubview(newLabel)
        self.addSubview(nearbyLabel)
    }
    
    func setSliderPosition(sliderRect: CGRect) {
        sliderView.frame = sliderRect
        sliderView.backgroundColor = UIColor.blue
        self.addSubview(sliderView)
    }
    

    func animateSliderPosition() {
        
    }
}
