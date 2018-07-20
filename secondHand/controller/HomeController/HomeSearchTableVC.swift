//
//  HomeSearchTableViewController.swift
//  secondHand
//
//  Created by ZechengLi on 7/9/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit

class HomeSearchTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    
    var searchVC: UISearchController!
    var tableViewHeaderHeight: CGFloat! {
        didSet {
            setupSearchVC()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setTableViewHeaderHeight(height: CGFloat) {
        tableViewHeaderHeight = height
    }
    
    //MARK: - set up search viewcontroller
    private func setupSearchVC() {
       searchVC = UISearchController(searchResultsController: nil)
        searchVC.searchResultsUpdater = self
        searchVC.dimsBackgroundDuringPresentation = false
        self.tableView.tableHeaderView = searchVC.searchBar
       searchVC.searchBar.delegate = self
        searchVC.searchBar.showsCancelButton = true
        
    }
    
    func setSearchBarFirstResponder() {
        searchVC.searchBar.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewHeaderHeight
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    //MARK: - UISearchResultsUpdating method
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    //MARK: - UISearchBarDelegate method
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.isHidden = true
        
    }
    
    
   

    
}
