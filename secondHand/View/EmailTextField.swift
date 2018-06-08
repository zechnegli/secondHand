//
//  EmailTextField.swift
//  secondHand
//
//  Created by ZechengLi on 5/22/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit

class EmailTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        var b = CALayer()
        b.frame = CGRect(x: self.frame.minX, y: self.frame.height - 1, width: self.frame.width, height: 2.0)
        b.backgroundColor = UIColor.black.cgColor
        self.layer.addSublayer(b)
        self.isSecureTextEntry = true
        self.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
    }

}
