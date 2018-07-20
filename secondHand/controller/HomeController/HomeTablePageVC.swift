//
//  HomeTablePageViewController.swift
//  secondHand
//
//  Created by ZechengLi on 7/2/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit

class HomeTablePageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
   
    private var controllers = [UITableViewController]()
    private var homeTableViewController1: HomeTableViewController!
    private var homeTableViewController2: HomeTableViewController!
    private var homeTableViewController3: HomeTableViewController!

    private var currentPageIndex: Int!
    private var isScrollForward: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self
        setupSubTableVC()
        currentPageIndex = 0
        isScrollForward = false
        //show first view controller
        if let firstViewController = controllers.first{
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    //MARK: - set up sub table view controllers
    private func setupSubTableVC() {
        homeTableViewController1 = HomeTableViewController()
        homeTableViewController2 = HomeTableViewController()
        homeTableViewController3 = HomeTableViewController()
        
        controllers.append(homeTableViewController1)
        controllers.append(homeTableViewController2)
        controllers.append(homeTableViewController3)
    }
    
    

    var selectTableIndactorHandler: ((Int) -> ())?
    
    //MARK: - data source method
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.index(of: viewController as! UITableViewController) else { return nil }
        let previousIndex = index - 1
        if (previousIndex < 0 || previousIndex >= controllers.count) {
            return nil
        }
        return controllers[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.index(of: viewController as! UITableViewController) else { return nil }
        let laterIndex = index + 1
        if (laterIndex < 0 || laterIndex >= controllers.count) {
            return nil
        }
        return controllers[laterIndex]
    }
    
    //MARK: - get specific controllers, based on index
    public func getControllers(index: Int) -> UITableViewController {
        return controllers[index]
    }
    
    //MARK: - delegate method
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let pendingVC = pendingViewControllers[0] as? HomeTableViewController else { return  }
        currentPageIndex = controllers.index(of: pendingVC)
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
                selectTableIndactorHandler?(currentPageIndex)
        }
    }
    
//    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
//        guard let index = controllers.index(of: pendingViewControllers as! UITableViewController)  else {return}
//        currentPageIndex = index
//
//
//    }
    
}
