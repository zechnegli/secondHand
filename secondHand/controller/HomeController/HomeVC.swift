//
//  HomeVC.swift
//  secondHand
//
//  Created by ZechengLi on 7/14/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, UIScrollViewDelegate {
    
    var pickerView: HomeLocationPickerView?
    var wrapperView: UIView?
    var statusBarView: UIView!
    var searchBar: UISearchBar!
    var locationBtn: UIButton!
    var mainScrollView: UIScrollView!
    var maskView: UIView!
    var adsPageVC: HomePageViewController!
    var categoryVC: HomeCategoryCollectionViewController!
    var tablesPageVC: HomeTablePageViewController!
    var tableIndactorCollectionVC: TableIndactorCollectionVC!
    var homeTableIndactorView: HomeTableIndactorView!
    var searchTableVC: HomeSearchTableViewController!
    
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStatusBarView()
        setupLocationBtn()
        setUpSearchBar()
        setUpScrollView()
        setUpAdsPageViewController()
        setUpCollectoinViewController()
        setUpIndactorCollectionVC()
        setUpTabelPageViewControlelr()
        setupTableVCWithSerachBar()
        setUPMaskView()
        
        setScrollPageHandler()
        setTablePageHandler()
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    //MARK: - status bar view
    private func setupStatusBarView() {
        statusBarView = UIView()
        self.view.addSubview(statusBarView)
        
        statusBarView.snp.makeConstraints { (make) in
            make.width.equalTo(statusBarWidth)
            make.height.equalTo(statusBarheight)
            make.top.equalTo(self.view.snp.top).offset(HomeViewControllerConstants().statusBarTopConstraint)
            make.left.equalTo(self.view.snp.left).offset(HomeViewControllerConstants().statusBarleftConstraint)
        }
        statusBarView.backgroundColor = UIColor.init(red: HomeViewControllerConstants().searchBarRed, green: HomeViewControllerConstants().searchBarGreen, blue: HomeViewControllerConstants().searchBarBlue, alpha: HomeViewControllerConstants().searchBarAlpha)
    }
    
    
    
   
    //MARK: - set up the table view controller with search bar
    private func setupTableVCWithSerachBar() {
        searchTableVC = HomeSearchTableViewController()
        self.addChildViewController(searchTableVC)
        searchTableVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(searchTableVC.view)
        searchTableVC.setTableViewHeaderHeight(height: searchBarHeight)
        searchTableVC.view.isHidden = true
        
    }
    
    //MARK: - set up the location button
    private func setupLocationBtn() {
        locationBtn = UIButton()
        self.view.addSubview(locationBtn)
        locationBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(UIApplication.shared.statusBarFrame.height)
            make.left.equalTo(self.view.snp.left).offset(HomeViewControllerConstants().seachLocationButtonLeftConstraint)
            make.height.equalTo(searchLocationBtnHeight)
            make.width.equalTo(searchLocationBtnWidth)
        }
        
        locationBtn.addTarget(self, action: #selector(seachBtnPressed), for: .touchUpInside)
        locationBtn.backgroundColor = UIColor.init(red: HomeViewControllerConstants().searchBarRed, green: HomeViewControllerConstants().searchBarGreen, blue: HomeViewControllerConstants().searchBarBlue, alpha: HomeViewControllerConstants().searchBarAlpha)
        locationBtn.setTitle("San Francisco ˅", for: .normal)
    }
    
    @objc private func seachBtnPressed() {
        setupWrapperView()
        let cancelButton = setupCancelButton()
        setupOkButton(cancelButton: cancelButton)
        setupPickerView(cancelButton: cancelButton)
    }
    
    //MARK: - set up cancel button
    private func setupCancelButton() -> UIButton {
        //cancel button
        let cancelButton = UIButton()
        cancelButton.setTitle("Cancel", for: .normal)
        self.wrapperView?.addSubview(cancelButton)
        if let wrapperView = wrapperView {
            cancelButton.snp.makeConstraints { (make) in
                make.top.equalTo(wrapperView.snp.top).offset(HomeViewControllerConstants().cancelButtonTopConstraint)
                make.left.equalTo(wrapperView.snp.left).offset(HomeViewControllerConstants().cancelButtonLeftConstraint)
                make.height.equalTo(barbuttonHeight)
                make.width.equalTo(barButtonWidth)
            }
        }
        cancelButton.setTitleColor(UIColor.gray, for: .normal)
        cancelButton.alpha = HomeViewControllerConstants().barButtonAlpha
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return cancelButton
    }
    
    //MARK: - cancel button action
    @objc private func cancelButtonPressed() {
        UIView.animate(withDuration: TimeInterval(HomeViewControllerConstants().pickerViewTimeDuration), delay: TimeInterval(HomeViewControllerConstants().pickerViewDelayTime) , usingSpringWithDamping: HomeViewControllerConstants().pickerViewDamping, initialSpringVelocity: HomeViewControllerConstants().pickerViewInitialVelocity, options: .curveEaseOut, animations: {
            
            self.maskView.alpha = HomeViewControllerConstants().maskViewAlphaValueBeforeAnimation
            self.wrapperView?.frame.origin = CGPoint(x:self.wrapperViewPointXAfterAnimation , y: self.wrapperViewPointYAfterAnimation)
            
        }, completion: { bool in
            self.wrapperView?.removeFromSuperview()
        })
    }
    
    //MARK: - set up ok button
    private func setupOkButton(cancelButton: UIButton) {
        let okButton = UIButton()
        okButton.setTitle("Ok", for: .normal)
        self.wrapperView?.addSubview(okButton)
        if let wrapperView = wrapperView {
            okButton.snp.makeConstraints { (make) in
                make.top.equalTo(wrapperView.snp.top).offset(HomeViewControllerConstants().okButtonTopConstraint)
                make.left.equalTo(cancelButton.snp.right).offset(HomeViewControllerConstants().okButtonLeftConstraint)
                make.height.equalTo(barbuttonHeight)
                make.right.equalTo(wrapperView.snp.right).offset(HomeViewControllerConstants().okButtonRightConstraint)
            }
        }
        okButton.setTitleColor(UIColor.green, for: .normal)
        okButton.alpha = HomeViewControllerConstants().barButtonAlpha
        okButton.addTarget(self, action: #selector(okButtonPressed(_:)), for: .touchUpInside)
        
    }
    
    
    //MARK: - ok button action
    @objc private func okButtonPressed(_ sender: UIButton) {
       
        if let selectedValue = pickerView?.selectedVlaue {
            locationBtn.setTitle(selectedValue, for: .normal)
        }
        UIView.animate(withDuration: TimeInterval(HomeViewControllerConstants().pickerViewTimeDuration), delay: TimeInterval(HomeViewControllerConstants().pickerViewDelayTime) , usingSpringWithDamping: HomeViewControllerConstants().pickerViewDamping, initialSpringVelocity: HomeViewControllerConstants().pickerViewInitialVelocity, options: .curveEaseOut, animations: {
            
            self.maskView.alpha = HomeViewControllerConstants().maskViewAlphaValueBeforeAnimation
            self.wrapperView?.frame.origin = CGPoint(x:self.wrapperViewPointXAfterAnimation , y: self.wrapperViewPointYAfterAnimation)
            
             sender.backgroundColor = UIColor.lightGray
        }, completion: { bool in
            self.wrapperView?.removeFromSuperview()
        })
    }
    
    
    
    //MARK: - create picker view
    private func setupPickerView(cancelButton: UIButton) {
        pickerView = HomeLocationPickerView()
        self.wrapperView?.addSubview(pickerView!)
        if let wrapperView = wrapperView {
            pickerView?.snp.makeConstraints { (make) in
                make.top.equalTo(cancelButton.snp.bottom).offset(HomeViewControllerConstants().pickerViewTopConstraint)
                make.left.equalTo(wrapperView.snp.left).offset(HomeViewControllerConstants().pickerViewLeftConstraint)
                make.right.equalTo(wrapperView.snp.right).offset(HomeViewControllerConstants().pickerViewRightConstraint)
                make.bottom.equalTo(wrapperView.snp.bottom).offset(HomeViewControllerConstants().pickerViewBottomConstraint)
            }
        }
        
        
        pickerView!.backgroundColor = UIColor.white
    }
    
   
    
    
    
    
    //MARK: - set up wrapper view(bar button and picker view)
    private func setupWrapperView() {
        wrapperView = UIView()
        self.view.addSubview(wrapperView!)
        wrapperView!.frame = CGRect(x: pickerViewX, y: pickerViewY, width: wrapperViewWidth, height: wrapperViewHeight)
        wrapperView!.backgroundColor = UIColor.white
        animateWrapperView(wrapperView: wrapperView!)
    }
    
   
    
    //MARK: - animate picker view
    private func animateWrapperView(wrapperView: UIView) {
        UIView.animate(withDuration: TimeInterval(HomeViewControllerConstants().pickerViewTimeDuration), delay: TimeInterval(HomeViewControllerConstants().pickerViewDelayTime) , usingSpringWithDamping: HomeViewControllerConstants().pickerViewDamping, initialSpringVelocity: HomeViewControllerConstants().pickerViewInitialVelocity, options: .curveEaseOut, animations: {
            wrapperView.isHidden = false
            wrapperView.frame = CGRect(x: 0, y: self.wrapperViewPointYBeforeAnimation, width: self.wrapperViewWidth, height: self.wrapperViewHeight)
            self.maskView.alpha = HomeViewControllerConstants().maskViewAlphaValueAfterAnimation
            
        }, completion: nil)
    }
  
    
    //MARK: - set up the search bar
    private func setUpSearchBar() {
        
        searchBar = UISearchBar()
        self.view.addSubview(searchBar)
        searchBar.delegate = self
        
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(UIApplication.shared.statusBarFrame.height)
            make.left.equalTo(self.locationBtn.snp.right).offset(HomeViewControllerConstants().searchBarLeftConstraint)
            make.right.equalTo(self.view.snp.right).offset(HomeViewControllerConstants().searchBarRightConstraint)
            make.height.equalTo(searchBarHeight)
        }
        
        searchBar.placeholder = "搜索"
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = UIColor.init(red: HomeViewControllerConstants().searchBarRed, green: HomeViewControllerConstants().searchBarGreen, blue: HomeViewControllerConstants().searchBarBlue, alpha: HomeViewControllerConstants().searchBarAlpha)
        
    }
    
   
    
    
    //MARK: - set up the main scroll views
    private func setUpScrollView() {
        mainScrollView = UIScrollView()
        mainScrollView.delegate = self
        self.view.addSubview(mainScrollView)
        
        mainScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(HomeViewControllerConstants().mainScrollViewTopConstraint)
            make.right.equalTo(self.view.snp.right).offset(HomeViewControllerConstants().mainScrollViewLeftConstraint)
            make.height.equalTo(mainScrollViewHeight)
            make.width.equalTo(mainScrollViewWidth)
        }
    
        mainScrollView.contentSize = CGSize(width: mainScrollViewContentWidth, height: mainScrollViewContentHeight)
      
    }
    
    
    
    //MARK: - set up mask view
    private func setUPMaskView() {
        maskView = UIView()
        maskView.frame = CGRect(x: HomeViewControllerConstants().maskViewOriginX, y: HomeViewControllerConstants().maskViewOriginY, width: maskViewWidth, height: maskViewHeight)
       self.view.addSubview(maskView)
        maskView.backgroundColor = UIColor.black
        maskView.alpha = HomeViewControllerConstants().maskViewAlphaValueBeforeAnimation
        addTapGestureToMaskView(maskView: maskView)
    }
    
    //MARK: - add tap gesture to mask view
    private func addTapGestureToMaskView(maskView: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        maskView.addGestureRecognizer(tapGesture)
        maskView.isUserInteractionEnabled = true
    }
    
    //MARK: - tag gesture
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        if (maskView.alpha != HomeViewControllerConstants().maskViewAlphaValueBeforeAnimation) {
            UIView.animate(withDuration: TimeInterval(HomeViewControllerConstants().pickerViewTimeDuration), delay: TimeInterval(HomeViewControllerConstants().pickerViewDelayTime) , usingSpringWithDamping: HomeViewControllerConstants().pickerViewDamping, initialSpringVelocity: HomeViewControllerConstants().pickerViewInitialVelocity, options: .curveEaseOut, animations: {
                
                self.maskView.alpha = HomeViewControllerConstants().maskViewAlphaValueBeforeAnimation
                self.wrapperView?.frame.origin = CGPoint(x:self.wrapperViewPointXAfterAnimation , y: self.wrapperViewPointYAfterAnimation)
                
            }, completion: { bool in
                self.wrapperView?.removeFromSuperview()
            })
        }
    }
   
    
    
    
    
    //MARK: - set up the ads page view controller
    private func setUpAdsPageViewController() {
        adsPageVC = HomePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.addChildViewController(adsPageVC)
         self.mainScrollView.addSubview(adsPageVC.view)
        adsPageVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(mainScrollView.snp.top).offset(HomeViewControllerConstants().adsPageViewTopConstraint)
            make.left.equalTo(mainScrollView.snp.left).offset(HomeViewControllerConstants().adsPageViewLeftConstraint)
            make.height.equalTo(adsViewHeight)
            make.width.equalTo(adsViewWidth)
        }
       
    }
    
    
    
    
    
    //MARK: - set up the category collection view controller
    private func setUpCollectoinViewController() {
        let layoutObject = UICollectionViewFlowLayout()
        layoutObject.itemSize = CGSize(width: categoryCollectionViewCellWidth, height: categoryCollectionViewCellHeight)
        layoutObject.scrollDirection =  .vertical
        layoutObject.sectionInset = UIEdgeInsets.init(top: cagtegoryCollectionViewHeight / 18, left: categoryCollectionViewWidth / 20, bottom: cagtegoryCollectionViewHeight / 20, right: categoryCollectionViewWidth / 20)
        categoryVC = HomeCategoryCollectionViewController(collectionViewLayout: layoutObject)
        self.addChildViewController(categoryVC)
        self.mainScrollView.addSubview(categoryVC.view)
        categoryVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(adsPageVC.view.snp.bottom).offset(HomeViewControllerConstants().adsPageViewTopConstraint)
            make.left.equalTo(mainScrollView.snp.left).offset(HomeViewControllerConstants().adsPageViewLeftConstraint)
            make.height.equalTo(cagtegoryCollectionViewHeight)
            make.width.equalTo(categoryCollectionViewWidth)
            
        }
        categoryVC.collectionView?.isScrollEnabled = false
        
        categoryVC.collectionView?.backgroundColor = UIColor.white
        categoryVC.collectionView?.contentSize = CGSize(width: self.view.frame.width, height: HomeViewControllerConstants().categoryCollectionVCHeight)
        
    }
    
   
    

    
    
    
    //MARK: - set up the table indactor collection view above the table
    private func setUpIndactorCollectionVC() {
        let layoutObject = UICollectionViewFlowLayout()
        layoutObject.itemSize = CGSize(width: tableIndactorCellectionCellWidth, height: tableIndactorCollectionCellHeight)
        layoutObject.scrollDirection = .horizontal
        tableIndactorCollectionVC = TableIndactorCollectionVC(collectionViewLayout: layoutObject)
        self.addChildViewController(tableIndactorCollectionVC)
        self.mainScrollView.addSubview(tableIndactorCollectionVC.view)
        tableIndactorCollectionVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(categoryVC.view.snp.bottom).offset(HomeViewControllerConstants().tableIndactorViewTopConstraint)
            make.left.equalTo(mainScrollView.snp.left).offset(HomeViewControllerConstants().tableIndactorViewLeftConstraint)
            make.height.equalTo(tableIndactorCollectionViewHeight)
            make.width.equalTo(tableIndactorCollectionViewWidth)
        }
        tableIndactorCollectionVC.collectionView?.backgroundColor = UIColor.white
        tableIndactorCollectionVC.collectionView?.showsHorizontalScrollIndicator = false
        
        
    }
    
    //MARK: - based on the table indactor, scoll page
    private func setScrollPageHandler() {
        guard let  tableIndactorVC = tableIndactorCollectionVC else { return }
        guard let  tablePageVC = tablesPageVC else { return}
        tableIndactorVC.scrollingPageHandler = {(index: Int) in
            
            tablePageVC.setViewControllers([tablePageVC.getControllers(index: index)], direction: .forward, animated: true, completion: nil)
        }
            

    }
   
   
    
    //MARK: - set up table page view controller
    func setUpTabelPageViewControlelr() {
        tablesPageVC = HomeTablePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.addChildViewController(tablesPageVC)
        mainScrollView.addSubview(tablesPageVC.view)
        tablesPageVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(tableIndactorCollectionVC.view.snp.bottom).offset(HomeViewControllerConstants().adsPageViewTopConstraint)
            make.left.equalTo(mainScrollView.snp.left).offset(HomeViewControllerConstants().pageViewLeftConstraint)
            make.height.equalTo(pageViewHeight)
            make.width.equalTo(pageViewWidth)
        }
        
    }
    
    //MARK: - scroll table indactor, based on the current page number
    private func setTablePageHandler() {
        guard let  tableIndactorVC = tableIndactorCollectionVC else { return }
        guard let  tablePageVC = tablesPageVC else { return}
            tablePageVC.selectTableIndactorHandler = {(selectedIndex) in
                    for index in 0 ..< tableIndactorVC.getCellCount() {
                        if index == selectedIndex {
                            if let cell = tableIndactorVC.collectionView?.cellForItem(at: IndexPath(item: selectedIndex, section: 0)) as? HomeTableIndactorCollectionCell {
                                if (!cell.isAnimated) {
                                    cell.animateLabel()
                                }
                                
                            }
                        } else {
                            if let cell = tableIndactorVC.collectionView?.cellForItem(at: IndexPath(item: index, section: 0)) as? HomeTableIndactorCollectionCell {
                                if (cell.isAnimated) {
                                   cell.resetLabel()
                                }
                                
                            }
                        }
                    }
            }
    }
    
    
    
    
    
    
    
//    //Scroll view Delegate methods:
//    //When user scroll to the top of the table which displays goods, anchor the top table indicator view
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        if (scrollView.contentOffset.y > self.view.frame.height - 50) {
//
//            homeTableIndactorView.frame.origin = scrollView.contentOffset
//            tablesPageVC.view.frame.origin = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y+HomeViewControllerConstants().tableIndicatorViewHeight)
//
//
//            enableScroll(isMainScrollViewScrolling: false, istablePageViewScrolling: true)
//
//        } else {
//
//            enableScroll(isMainScrollViewScrolling: true, istablePageViewScrolling: false)
//        }
//
//    }
    
    
//    //MARK: - enable scrolling or not for main scrollView and tableView
//    private func enableScroll(isMainScrollViewScrolling: Bool, istablePageViewScrolling: Bool) {
//        let controller = tablesPageVC.controllers[tablesPageVC.currentPageIndex]
//        if let tableView = controller.view as? UITableView {
//            tableView.isScrollEnabled = istablePageViewScrolling
//            mainScrollView.isScrollEnabled = isMainScrollViewScrolling
//        }
//    }
}

extension HomeViewController {
    private struct HomeViewControllerConstants {
        //status bar constant
        let statusBarTopConstraint: CGFloat = 0
        let statusBarleftConstraint: CGFloat = 0
        
        //search location button
        let seachLocationButtonLeftConstraint: CGFloat = 0
       
        //mask view
        let maskViewOriginY: CGFloat = UIApplication.shared.statusBarFrame.height
        let maskViewOriginX: CGFloat = 0
        let maskViewAlphaValueBeforeAnimation: CGFloat = 0
        let maskViewAlphaValueAfterAnimation: CGFloat = 0.5
        
        //search bar
        let searchBarTopConstraint: CGFloat = 0
        let searchBarLeftConstraint: CGFloat = 0
        let searchBarRed: CGFloat = 30/255.0
        let searchBarGreen: CGFloat = 144/255.0
        let searchBarBlue: CGFloat = 255/255.0
        let searchBarAlpha: CGFloat = 1
        let searchBarRightConstraint: CGFloat = 0
        
        //main scroll view
        let mainScrollViewTopConstraint: CGFloat = 0
        let mainScrollViewLeftConstraint: CGFloat = 0
        
        //ads page view
        let adsPageViewTopConstraint: CGFloat = 0
        let adsPageViewLeftConstraint: CGFloat = 0
        
        //category collection view
        let categoryCollectionVCHeight: CGFloat = 100
        let categoryVCTopConstraint: CGFloat = 0
        let categoryVCLeftConstraint: CGFloat = 0
        
        //table indactor view
        let tableIndactorViewTopConstraint: CGFloat = 0
        let tableIndactorViewLeftConstraint: CGFloat = 0
        let firstLabelHeight: CGFloat = 40
        let secondLabelHeight: CGFloat = 40
        let sliderPositionOffSet: CGFloat = 15
        let sliderPositionHeight: CGFloat = 7
        let sliderPositionWidth: CGFloat = 30
        
        //category collection view cell constant
        let cellHorizontalSpacing: CGFloat = 5
        let cellLeftConstraint: CGFloat = 4
        let cellRightConstraint: CGFloat = 4
        let cellVerticalSpacing: CGFloat = 5

        
        //table page view
        let pageViewTopConstraint: CGFloat = 0
        let pageViewLeftConstraint: CGFloat = 0
        
        //picker view animation constant
        let pickerViewTimeDuration: CGFloat = 0.3
        let pickerViewDelayTime: CGFloat = 0
        let pickerViewDamping: CGFloat = 3
        let pickerViewInitialVelocity: CGFloat = 0.5
        
        //bar button alpha
        let barButtonAlpha: CGFloat = 0.3
        
        //cancel button
        let cancelButtonTopConstraint: CGFloat = 0
        let cancelButtonLeftConstraint: CGFloat = 0
        
        //ok button
        let okButtonTopConstraint: CGFloat = 0
        let okButtonLeftConstraint: CGFloat = 0
        let okButtonRightConstraint: CGFloat = 0
        
        //picker view
        let pickerViewTopConstraint: CGFloat = 0
        let pickerViewRightConstraint: CGFloat = 0
        let pickerViewLeftConstraint: CGFloat = 0
        let pickerViewBottomConstraint: CGFloat = 0
        
    
    }
    
    //status bar height
    var statusBarheight: CGFloat {
        get {
            return UIApplication.shared.statusBarFrame.height
        }
    }
    
    var statusBarWidth: CGFloat {
        get {
            return self.view.frame.width
        }
    }
    
    
    //MARK: - search bar
    var searchBarWidth: CGFloat {
        get {
            return self.view.frame.width
        }
    }
    
    var searchBarHeight: CGFloat {
        get {
            return 40
        }
    }
    
    
    //location button
    var searchLocationBtnHeight: CGFloat {
        get {
            return 40
        }
    }
    
    var searchLocationBtnWidth: CGFloat {
        get {
            return self.view.frame.width / 5
        }
    }
    
    //MARK: - main scroll view
    var mainScrollViewHeight: CGFloat {
        get {
            return self.view.frame.height - searchBarHeight
        }
    }
    
    var mainScrollViewWidth: CGFloat {
        get {
            return self.view.frame.width
        }
    }
    
    //main scroll view content size
    var mainScrollViewContentWidth: CGFloat {
        return self.view.frame.width
    }
    
    var mainScrollViewContentHeight: CGFloat {
        return self.view.frame.height * 2
    }
    
    //MARK: - mask view
    var maskViewWidth: CGFloat   {
        return mainScrollViewWidth
    }
    
    var maskViewHeight: CGFloat {
        return mainScrollViewHeight
    }
    
    //MARK: - ads page view controller
    var adsViewWidth: CGFloat {
        get {
            return self.view.frame.width
        }
    }
    
    var adsViewHeight: CGFloat {
        get {
            return 200
        }
    }
    
    //MARK: - category collection view constant
    var categoryCollectionViewWidth: CGFloat {
        get {
            return self.view.frame.width
        }
    }
    
    var cagtegoryCollectionViewHeight: CGFloat {
        get {
            return self.view.frame.height / 5.9
        }
    }
    
    // MARK: - category collection cell's width and height
    private var categoryCollectionViewCellWidth: CGFloat {
        get {
            return self.view.frame.width / 5 - 4 * HomeViewControllerConstants().cellHorizontalSpacing
        }
    }
    private var categoryCollectionViewCellHeight: CGFloat {
        return HomeViewControllerConstants().categoryCollectionVCHeight / 2
    }
    
    //MARK: - table indactor cell size
    private var tableIndactorCellectionCellWidth: CGFloat {
        return tableIndactorCollectionViewWidth / 3
   
    }
    
    private var tableIndactorCollectionCellHeight: CGFloat {
        return tableIndactorCollectionViewHeight
    }
    
    //MARK: - home Table IndactorView
    var tableIndactorCollectionViewHeight: CGFloat {
        get {
            return 50
        }
    }
    
    var tableIndactorCollectionViewWidth: CGFloat {
        get {
            return self.view.frame.width
        }
    }
    
    //MARK: - page view
    var pageViewWidth: CGFloat {
        get {
            return self.view.frame.width
        }
    }
    
    var pageViewHeight: CGFloat {
        get {
            return self.view.frame.height
        }
    }
    
    //MARK: - picker view
    var pickerViewWidth: CGFloat {
        get {
            return self.view.frame.width
        }
    }
    
    
    var pickerViewX: CGFloat {
        get {
            return 0
        }
    }
    
    var pickerViewY: CGFloat {
        get {
            return self.view.frame.height
        }
    }
    
    
    
 
    //MARK: - wrapper view
    var  wrappperViewX: CGFloat {
        return 0
    }
    var wrapperViewY: CGFloat {
        return self.view.frame.height
    }
    
    var wrapperViewWidth: CGFloat {
        return self.view.frame.width
    }
    
    var wrapperViewHeight: CGFloat {
        return self.view.frame.height / 3 + self.view.frame.height / 3 / 5
    }
    
    //MARK: - bar button
    var barbuttonHeight: CGFloat {
        return wrapperViewHeight - self.view.frame.height / 3
    }
    
    var barButtonWidth: CGFloat {
        return self.view.frame.width / 2
    }
    //wrapper view before animation
    var wrapperViewPointYBeforeAnimation: CGFloat {
        get {
            return self.view.frame.height - wrapperViewHeight
        }
    }
    
    var wrapperViewPointXBeforeAnimation: CGFloat {
        return 0
    }
    
    //wrapper view after animation
    var wrapperViewPointYAfterAnimation: CGFloat {
        get {
            return self.view.frame.height + wrapperViewHeight
        }
    }
    
    var wrapperViewPointXAfterAnimation: CGFloat {
        return 0
    }
    
    
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchTableVC.view.isHidden = false
        searchTableVC.setSearchBarFirstResponder()
    }
}


