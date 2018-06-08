//
//  PageViewController.swift
//  secondHand
//
//  Created by ZechengLi on 5/28/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var controllers:[UIViewController]!
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        controllers = [UIViewController]()
        let subController1 = AdsViewController()
        let subController2 = AdsViewController()
        let subController3 = AdsViewController()
        controllers.append(subController1)
        controllers.append(subController2)
        controllers.append(subController3)
        subController1.loadURLRequest(urlString: "2")
        subController2.loadURLRequest(urlString: "3")
        subController3.loadURLRequest(urlString: "4")
            
        if let firstViewController = controllers.first{
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        configurePageControl()
        
    }

    
   //Data sources method
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.index(of: viewController) else {return nil}
        var previousIndex = index - 1
        if previousIndex < 0 || previousIndex >= controllers.count {
            return nil
        }
        
        return controllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.index(of: viewController) else {return nil}
        var latterIndex = index + 1
        if latterIndex < 0 || latterIndex >= controllers.count {
            return nil
        }
        return controllers[latterIndex]
    }

    //configure page control interface
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = controllers!.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    //page controller delegate method: setting up the back dots for page controller
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = controllers.index(of: pageContentViewController)!
    }


}
