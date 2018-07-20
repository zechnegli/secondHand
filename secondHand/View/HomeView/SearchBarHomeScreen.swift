//
//  SearchBarHomeScreen.swift
//  secondHand
//
//  Created by ZechengLi on 5/26/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit

class SearchBarHomeScreen: UISearchBar {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for view in self.subviews {
            if let textField = view as? UITextField {
               textField.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.width, height: 40)
            }
        }
    }
 

}
