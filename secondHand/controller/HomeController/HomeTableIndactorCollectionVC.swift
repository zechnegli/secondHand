//
//  TableIndactorCollectionVC.swift
//  secondHand
//
//  Created by ZechengLi on 7/18/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TableIndactorCollectionVC: UICollectionViewController {
    private var tableCategoryList: [TableCategory]!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(HomeTableIndactorCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        setupTableCategroyList()
        
    }
    
    
    //MARK: - set up table category list
    private func setupTableCategroyList() {
        tableCategoryList = [TableCategory]()
        let categoryOne = TableCategory(categoryName: "闲置")
        let categoryTwo = TableCategory(categoryName: "圈子")
        let categoryThree = TableCategory(categoryName: "租房")
        tableCategoryList.append(categoryOne)
        tableCategoryList.append(categoryTwo)
        tableCategoryList.append(categoryThree)
    }



    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableCategoryList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        if let cell = cell as? HomeTableIndactorCollectionCell {
            cell.updateTableCategoryNameLabel(categoryName: tableCategoryList[indexPath.row].getTableCategoryName())
            if indexPath.row == 0 {
                cell.animateLabel()
            }
        }
        return cell
    }
    
    public func getCellCount() -> Int {
        return tableCategoryList.count
    }
    
    var scrollingPageHandler: ((_ index: Int) -> ())?
    
    //MARK: UIcollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //animate the selected cell
        for index in 0 ..< tableCategoryList.count {
            if index == indexPath.row {
                if let cell = collectionView.cellForItem(at: indexPath) as? HomeTableIndactorCollectionCell {
                    if (!cell.isAnimated) {
                         cell.animateLabel()
                    }
                   
                }
            } else {
                // reset all unselected cells
                if let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? HomeTableIndactorCollectionCell {
                    if (cell.isAnimated) {
                         cell.resetLabel()
                    }
                }
            }
            
        }
        
        scrollingPageHandler?(indexPath.row)
        
    }

}
