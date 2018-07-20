//
//  Category.swift
//  secondHand
//
//  Created by ZechengLi on 7/18/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import Foundation
import UIKit
class TableCategory {
    private var tableCategoryName: String?
    
    
    init(categoryName: String) {
        tableCategoryName = categoryName
    }
    
    public func getTableCategoryName() -> String? {
        return tableCategoryName
    }
    
}
