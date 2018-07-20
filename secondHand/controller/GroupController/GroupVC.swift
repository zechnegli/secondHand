//
//  GroupVC.swift
//  secondHand
//
//  Created by ZechengLi on 7/11/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit
import SnapKit
class GroupVC: UIViewController {
    var titleLabel: UILabel!
    var searchButton: UIButton!
    var describtionLabel: UILabel!
    var mainScrollView: UIScrollView!
    var groupCollectionVC: GroupCollecionVC!
    var adsPageVC: GroupPageVC!
    var groupTableVC: GroupTableVC!
    
    
    //MARK: - title label width
    var titleWidth: CGFloat {
        get {
            return self.view.frame.width / 6 * 5.5
        }
    }
    
    //MARK: - describtion label width
    var describtionWidth: CGFloat {
        get {
            return self.view.frame.width
        }
    }
    
    //main scroll view
    //MARK: - main scroll view width
    var mainScrollViewWidth: CGFloat {
        get {
            return self.view.frame.width
        }
    }
    
    //MARK: - main scroll view height
    var mainScrollViewHeight: CGFloat {
        get {
            return self.view.frame.height * 3 / 2
        }
    }
    
    //MARK: - group Collection view height
    var collectionHeight: CGFloat {
        get {
            return self.view.frame.height / 5.5
        }
    }
    
    //MARK: group collection view width
    var collectionWidth: CGFloat {
        get {
            return self.view.frame.width
        }
    }
    
    
    //MARK: - group collection view cell width
    var collectionViewCellWidth: CGFloat {
        get {
            return self.view.frame.width / 4
        }
    }
    
    
    //MARK: - group collection view cell height
    var collectionViewCellHeight: CGFloat {
        get {
            return self.collectionHeight - GroupVCConstants().collectionViewTopPadding - GroupVCConstants().collectionViewBottomPadding
        }
    }
    
    //MARK: - ads page view height
    var adsPageViewHeight: CGFloat {
        get {
            return self.view.frame.height / 8
        }
    }
    
    //MARK: - ad page view width
    var adsPageViewWidth: CGFloat {
        get {
            return self.view.frame.width
        }
    }
    
    //MARK: - table view height
    var tableViewHeight: CGFloat {
        get {
            return mainScrollViewHeight - GroupVCConstants().describtionLabelHeight - collectionHeight - adsPageViewHeight
        }
    }
    
    //MAKR: - table view width
    var tableViewWidth: CGFloat {
        get {
            return self.view.frame.width
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleLabel()
        setupSearchButton()
        setupMainScrollView()
        setupDescribiotnLabel()
        setupGroupCollectionVC()
        setupAdsVC()
        setupGroupTableVC()
        
    }
    //MARK: - set up the title label
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = " 圈子"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: GroupVCConstants().titleLabelFontSize)
        self.view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(GroupVCConstants().titleLeftConstraint)
            make.top.equalTo(self.view.snp.top).offset(GroupVCConstants().titleTopConstraint)
            make.height.equalTo(GroupVCConstants().titleHeight)
            make.width.equalTo(titleWidth)
            
        }
        
        titleLabel.backgroundColor = UIColor.blue
        
    }
    
    //MARK: - set up the seach button
    private func setupSearchButton() {
        searchButton = UIButton()
        self.view.addSubview(searchButton)
        
        searchButton.setBackgroundImage(UIImage(named: "search.png"), for: .normal)
        
        searchButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(GroupVCConstants().searchButtonTopConstraint)
            make.left.equalTo(titleLabel.snp.right).offset(GroupVCConstants().searchButtonLeftconstraint)
            make.right.equalTo(self.view.snp.right).offset(GroupVCConstants().searchButtonRightConstraint)
            make.height.equalTo(GroupVCConstants().searchButtonHeight)
        }
    }
    
    //MARK: - set up main scroll view
    private func setupMainScrollView() {
        mainScrollView = UIScrollView()
        self.view.addSubview(mainScrollView)
        
        mainScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(GroupVCConstants().mainScrollViewTopConstraint)
            make.bottom.equalTo(self.view.snp.bottom).offset(GroupVCConstants().mainScrollViewBottomConstraint)
            make.right.equalTo(self.view.snp.right).offset(GroupVCConstants().mainScrollViewRightConstraint)
                make.left.equalTo(self.view.snp.left).offset(GroupVCConstants().mainScrollViewLeftConstraint)
        }
//        mainScrollView.contentSize = CGSize(width: mainScrollViewWidth, height: mainScrollViewHeight)
        mainScrollView.backgroundColor = UIColor.orange
        
    }
    
    
    
    
    
    //MARK: - set up describtion label
    private func setupDescribiotnLabel() {
        describtionLabel = UILabel()
        describtionLabel.text = "你可能感兴趣的圈子"
        describtionLabel.font = UIFont(name: describtionLabel.font.fontName, size: GroupVCConstants().describiotnLabelFontSize)
        self.mainScrollView.addSubview(describtionLabel)
        describtionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.mainScrollView.snp.top).offset(GroupVCConstants().describtionTopConstraint)

            make.height.equalTo(GroupVCConstants().describtionLabelHeight)

            make.width.equalTo(mainScrollViewWidth)
        }
        
        describtionLabel.backgroundColor = UIColor.brown
        
        
    }
    
    //MARK: - set up group image collection view controller
    private func setupGroupCollectionVC() {
        let layoutObject = UICollectionViewFlowLayout()
        layoutObject.sectionInset = UIEdgeInsets(top: GroupVCConstants().collectionViewTopPadding, left: GroupVCConstants().collectionViewLeftPadding, bottom: GroupVCConstants().collectionViewBottomPadding, right: GroupVCConstants().collectionViewRightPadding)
        layoutObject.scrollDirection = .horizontal
        layoutObject.itemSize = CGSize(width: collectionViewCellWidth, height: collectionViewCellHeight)
        groupCollectionVC = GroupCollecionVC(collectionViewLayout: layoutObject)
        self.addChildViewController(groupCollectionVC)
        self.mainScrollView.addSubview(groupCollectionVC.view)
        groupCollectionVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(describtionLabel.snp.bottom).offset(GroupVCConstants().collectionViewTopConstraint)
            make.left.equalTo(mainScrollView.snp.left).offset(GroupVCConstants().collectionViewLeftConstraint)
            make.width.equalTo(collectionWidth)
            make.height.equalTo(collectionHeight)
        }
        
        groupCollectionVC.view.backgroundColor = UIColor.blue
    }
    
    
    //MARK: - set up ads page view controller
    private func setupAdsVC() {
        adsPageVC = GroupPageVC(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.addChildViewController(adsPageVC)
        self.mainScrollView.addSubview(adsPageVC.view)
        
        adsPageVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(groupCollectionVC.view.snp.bottom).offset(GroupVCConstants().adsPageViewTopConstraint)
            make.left.equalTo(mainScrollView.snp.left).offset(GroupVCConstants().adsPageViewLeftConstraint)
            make.width.equalTo(adsPageViewWidth)
            make.height.equalTo(adsPageViewHeight)
        }

        
    }
    
    //MARK: - set up group table view controller
    private func setupGroupTableVC() {
        groupTableVC = GroupTableVC()
        self.addChildViewController(groupTableVC)
        self.mainScrollView.addSubview(groupTableVC.view)
        
        groupTableVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(adsPageVC.view.snp.bottom).offset(GroupVCConstants().tableViewTopConstraint)
            make.left.equalTo(mainScrollView.snp.left).offset(GroupVCConstants().tableViewLeftConstraint)
            make.width.equalTo(tableViewWidth)
            make.height.equalTo(tableViewHeight)
            
        }
        
        groupTableVC.view.backgroundColor = UIColor.brown
    }
    
    
    

   
    



}

extension GroupVC {
    struct GroupVCConstants {
        //status bar
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        
        //title label
        let titleHeight: CGFloat = 40
        let titleLeftConstraint: CGFloat = 0
        let titleRightConstraint: CGFloat = 0
        let titleTopConstraint: CGFloat = UIApplication.shared.statusBarFrame.height
        let titleLabelFontSize: CGFloat = 30
        
        //search button
        let searchButtonHeight: CGFloat = 40
        let searchButtonRightConstraint: CGFloat = 0
        let searchButtonLeftconstraint: CGFloat = 0
        let searchButtonTopConstraint: CGFloat  = UIApplication.shared.statusBarFrame.height
        
        //main scroll view
        let mainScrollViewTopConstraint: CGFloat = 0
        let mainScrollViewRightConstraint: CGFloat = 0
        let mainScrollViewBottomConstraint: CGFloat = 0
        let mainScrollViewLeftConstraint: CGFloat = 0
        
        //describtion label
        let describiotnLabelFontSize:CGFloat = 20
        let describtionLabelHeight:CGFloat = 30
        let describtionTopConstraint:CGFloat = 0
        let describtionRightConstraint:CGFloat = 0
        let describtionLeftConstraint:CGFloat = 0
        
        //collection view
        let collectionViewTopConstraint:CGFloat = 0
        let collectionViewRightConstraint:CGFloat = 0
        let collectionViewLeftConstraint:CGFloat = 0
        let collectionViewTopPadding:CGFloat = 10
        let collectionViewLeftPadding:CGFloat = 10
        let collectionViewRightPadding:CGFloat = 10
        let collectionViewBottomPadding:CGFloat = 10
        
        //ads page view
        let adsPageViewTopConstraint:CGFloat = 0
        let adsPageViewRightConstraint:CGFloat = 0
        let adsPageViewLeftConstraint:CGFloat = 0
        
        //group table view
        let tableViewTopConstraint:CGFloat = 0
        let tableViewRightConstraint:CGFloat = 0
        let tableViewLeftConstraint:CGFloat = 0
        let tableViewBottomConstraint:CGFloat = 0
        
        
    }
}
