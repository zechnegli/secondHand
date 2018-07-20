//
//  HomeTableIndactorCollectionCell.swift
//  secondHand
//
//  Created by ZechengLi on 7/18/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit

class HomeTableIndactorCollectionCell: UICollectionViewCell {
    var defacultFontSize: CGFloat?
    var tableCategoryNameLabel: UILabel!
    var isAnimated = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableCategoryNameLabel()
        defacultFontSize = tableCategoryNameLabel.font.pointSize
    }
    
    //MARK: - set up table category name label
    private func setupTableCategoryNameLabel() {
        tableCategoryNameLabel = UILabel()
        self.addSubview(tableCategoryNameLabel)
        
        tableCategoryNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(HomeTableIndactorCollectionCellConstant().tableCategoryNameLabelTopConstraint)
            make.left.equalTo(self.snp.left).offset(HomeTableIndactorCollectionCellConstant().tableCategoryNameLabelLeftConstraint)
            make.right.equalTo(self.snp.right).offset(HomeTableIndactorCollectionCellConstant().tableCategoryNameLabelRightConstraint)
            make.bottom.equalTo(self.snp.bottom).offset(HomeTableIndactorCollectionCellConstant().tableCategoryNameLabelBottomConstraint)
        }
        tableCategoryNameLabel.textColor = UIColor.lightGray
        tableCategoryNameLabel.textAlignment = .center
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - update table category label
    public func updateTableCategoryNameLabel(categoryName: String?) {
        if let categoryName = categoryName {
            tableCategoryNameLabel.text = categoryName
        }
        
    }
    
    //MARK: - highlight label
    public func animateLabel() {
        isAnimated = true
        UIView.animate(withDuration: TimeInterval(HomeTableIndactorCollectionCellConstant().animationDuration)) {
            self.tableCategoryNameLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.tableCategoryNameLabel.textColor = UIColor.black
            
        }
    }
    
    //MARK: - reset label
    public func resetLabel() {
        isAnimated = false
        UIView.animate(withDuration: TimeInterval(HomeTableIndactorCollectionCellConstant().animationDuration)) {
            self.tableCategoryNameLabel.textColor = UIColor.lightGray
            self.tableCategoryNameLabel.transform = CGAffineTransform.identity
            
        }
    }
    
    

    
}

extension HomeTableIndactorCollectionCell {
    private struct HomeTableIndactorCollectionCellConstant {
        let tableCategoryNameLabelTopConstraint: CGFloat = 0
        let tableCategoryNameLabelLeftConstraint: CGFloat = 0
        let tableCategoryNameLabelRightConstraint: CGFloat = 0
        let tableCategoryNameLabelBottomConstraint: CGFloat = 0
        
        
        //animation constant
        let fontSizeAfterAnimation: CGFloat = 22
        let animationDuration: CGFloat = 0.2
    }
    
    
    
}
