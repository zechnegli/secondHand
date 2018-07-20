//
//  CategoryCollectionViewCell.swift
//  secondHand
//
//  Created by ZechengLi on 7/8/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit
import SnapKit
class CategoryCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView!
    var categoryLabel: UILabel!
    var categorylabelHeight: CGFloat {
        get {
            return self.contentView.frame.height / 1.7
        }
    }
    
    //MARK: set up image view
    private func setupImageView() {
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: categorylabelHeight))
        self.contentView.addSubview(imageView)
        
        //Test
        imageView.backgroundColor = UIColor.brown
    }
    
    //MARK: set up category describtion Label
    private func setupCategoryLabel() {
        categoryLabel = UILabel()
         self.contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(CategoryCollectionViewCellConstant().describtionLabelTopConstrain)
            make.left.equalTo(self.contentView.snp.left).offset(CategoryCollectionViewCellConstant().describtionLabelLeftConstrain)
            make.right.equalTo(self.contentView.snp.right).offset(CategoryCollectionViewCellConstant().describtionLabelRightConstrain)
        make.bottom.equalTo(self.contentView.snp.bottom).offset(CategoryCollectionViewCellConstant().describtionLabelBottomConstrain)
        }
       
        categoryLabel.backgroundColor = UIColor.blue
    }
    
    //MARK: - update cell UI
    public func updateCellUI(image: UIImage, describtion: String) {
        setupImageView()
        setupCategoryLabel()
        imageView.image = image
        categoryLabel.text = description
        
        
    }
    
    //Test
    public func updateCellUI() {
        setupImageView()
        setupCategoryLabel()
        
        
        
    }
    
    
}


extension CategoryCollectionViewCell {
    struct CategoryCollectionViewCellConstant {
        
        
        let describtionLabelTopConstrain: CGFloat = 0
        let describtionLabelBottomConstrain: CGFloat = 0
        let describtionLabelRightConstrain: CGFloat = 0
        let describtionLabelLeftConstrain: CGFloat = 0
    }
}
