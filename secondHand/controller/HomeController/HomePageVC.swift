//
//  PageViewController.swift
//  secondHand
//
//  Created by ZechengLi on 5/28/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit

class HomePageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var controllers:[UIViewController]!
    var pageControl = UIPageControl()
    var subController1: AdsViewController!
    var subController2: AdsViewController!
    var subController3: AdsViewController!
    var currentVCIndex: Int?
    weak var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.dataSource = self
        self.delegate = self
        controllers = [UIViewController]()
        subController1 = AdsViewController()
        subController2 = AdsViewController()
        subController3 = AdsViewController()
        controllers.append(subController1)
        controllers.append(subController2)
        controllers.append(subController3)
       
        subController1.loadURLRequest(urlString: "2")
        subController2.loadURLRequest(urlString: "3")
        subController3.loadURLRequest(urlString: "4")
        
        //show first view controller
        if let firstViewController = controllers.first{
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
            currentVCIndex = 1
        }
        
        
        setupTimer()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        configurePageControl(viewSize: self.view.frame)
    }
    
    //MARK: - set up timer#12    0x0000000115027955 in start ()

    private func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(repeatScrolling), userInfo: nil, repeats: true)
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(repeatScrolling), userInfo: nil, repeats: true)
    }
    
    
    //MARK: - repeat scrolling
    @objc private func repeatScrolling() {
        if let currentIndex = currentVCIndex {
            if currentIndex >= 0 && currentIndex < controllers.count - 1 {
                // move to the next page
                gotoNextPage(currentIndex: currentIndex)
                updatePageControl(currentIndex: currentIndex)
            } else if (currentIndex == controllers.count - 1) {
                //move to the first page
                backToFirstPage(currentIndex: currentIndex)
                updatePageControl(currentIndex: currentIndex)
            }
        }
    }
    
    //MARK: - go to next page
    private func gotoNextPage(currentIndex: Int) {
        let currentVC = controllers[currentIndex]
        guard let nextVC = dataSource?.pageViewController(self, viewControllerAfter: currentVC) else { return }
        currentVCIndex = currentVCIndex! + 1
        self.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
        
    }
    
    //MARK: - back to the first page
    private func backToFirstPage(currentIndex: Int) {
        let firstVC = controllers[0]
        currentVCIndex = 0
        self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
    }
    
    
    
    
    //configure page control interface
    func configurePageControl(viewSize: CGRect) {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl()
        self.view.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(pageControlBottomConstraint)
            make.left.equalTo(self.view.snp.left).offset(pageConstrolLeftConstraint)
            make.right.equalTo(self.view.snp.right).offset(pageControlRightConstraint)
            make.height.equalTo(pageControlHeightConstraint)
        }
        self.pageControl.numberOfPages = controllers!.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        
    }
    
    //MARK: - update page control
    private func updatePageControl(currentIndex: Int) {
        self.pageControl.currentPage = currentIndex
    }
    
 
   //Data sources method
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.index(of: viewController) else {return nil}
        let previousIndex = index - 1
        if previousIndex < 0 || previousIndex >= controllers.count {
            return nil
        }
        currentVCIndex = index
        resetTimer()
        return controllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.index(of: viewController) else {return nil}
         currentVCIndex = index
        resetTimer()
        if index == controllers.count - 1 {
            return controllers[0]
        } else {
            let latterIndex = index + 1
           
            if latterIndex < 0 || latterIndex >= controllers.count {
                
                return nil
            }
            
            return controllers[latterIndex]
        }
        
    }

    
    
    //page controller delegate method: setting up the back dots for page controller
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = controllers.index(of: pageContentViewController)!
       
    }

}

extension HomePageViewController {
    struct  HomePageViewControllerConstant{
        //pageControl
        
    }
    
    var pageControlBottomConstraint: CGFloat {
        get {
            return 0
        }
    }
    
    var pageConstrolLeftConstraint: CGFloat {
        get {
            return 0
        }
    }
    
    var pageControlRightConstraint: CGFloat {
        get {
            return 0
        }
    }
    
    var pageControlHeightConstraint: CGFloat {
        get {
            return 20
        }
    }
    
    
    
    
    
}
