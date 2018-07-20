//
//  HomeCategoryCollectionViewController.swift
//  secondHand
//
//  Created by ZechengLi on 7/8/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "collectionCell"

class HomeCategoryCollectionViewController: UICollectionViewController {
    var collections:[HomeCollection]!
//    var  collectionsRef:[String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        setupCollectionArray()
     
    }
    
    
    //MARK: - fetch Collections object and set up collections array
    private func setupCollectionArray() {
       collections = [HomeCollection]()
        collections.append(HomeCollection())
        collections.append(HomeCollection())
        collections.append(HomeCollection())
        collections.append(HomeCollection())
        collections.append(HomeCollection())
        collections.append(HomeCollection())
        collections.append(HomeCollection())
        collections.append(HomeCollection())
        collections.append(HomeCollection())
        collections.append(HomeCollection())
        
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        if let collectionCell = cell as? CategoryCollectionViewCell {
            collectionCell.updateCellUI()
        }
        return cell
    }


}
