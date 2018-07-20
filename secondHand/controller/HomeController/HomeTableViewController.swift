//
//  HomeTableTableViewController.swift
//  secondHand
//
//  Created by ZechengLi on 6/2/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    let reuseIdentifier = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
       self.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.tableView.rowHeight = HomeTableViewCellConstants().cellHeight
        tableView.allowsSelection = false
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y <= HomeTableViewCellConstants().cellHeight - 50 {
//          scrollView.isScrollEnabled = false
//            if let mainScrollView = scrollView.superview?.superview?.superview?.superview as? UIScrollView {
//                mainScrollView.isScrollEnabled = true
//
//
//            }
//
//        } else {
//            scrollView.isScrollEnabled = true
//            if let mainScrollView = scrollView.superview?.superview?.superview?.superview as? UIScrollView {
//                mainScrollView.isScrollEnabled = false
//
//
//            }
//        }
//    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        if let cell = cell as? HomeTableViewCell {
            cell.setCellSize(size: CGSize(width: self.view.frame.width, height: HomeTableViewCellConstants().cellHeight))
        }
        
        return cell!
        
    }
    
    
  
  

   
}

extension HomeTableViewController {
    struct HomeTableViewCellConstants {
        let cellHeight: CGFloat = 200
    }
}
