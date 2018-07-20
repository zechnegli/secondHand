//
//  HomeTableViewCell.swift
//  secondHand
//
//  Created by ZechengLi on 6/22/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit
import SnapKit
class HomeTableViewCell: UITableViewCell {
    //TODO: adujust height
    private var userImageView = UIImageView()
    private var userNamelabel = UILabel()
    private var groupLocationLabel = UILabel()
    private var priceLabel = UILabel()
    private var locationLabel = UILabel()
    private var describtionLabel = UILabel()
    private var imagesURL = [String]()
    private var infoView = UIView()
    private var textStackView = UIStackView()
    private var imagesCollectionView: UICollectionView!
    private var numberOfLikesLabel = UILabel()
    private var bottomStackView = UIStackView()
    
    private let resuseCollectionCellString = "collectionCell"
    //the user's picture height, info hight, price height, describtion label height
    private var infoHeight: CGFloat! {
        get {
            return cellSize.height / 6
            
        }
    }
    //the width of info view
    private var infoWidth: CGFloat! {
        get {
            return cellSize.width / 2
        }
    }
    
    private var describtionLeftConstraint: CGFloat! {
        get {
            return homeTabelViewCellSubViewSizeConstraint().stackViewLeftConstraint + homeTabelViewCellSubViewSizeConstraint().textStackViewleftConstraint + infoHeight
        }
    }
    
    private var imagesCollectionViewLeftConstraint: CGFloat! {
        get {
            return homeTabelViewCellSubViewSizeConstraint().stackViewLeftConstraint + homeTabelViewCellSubViewSizeConstraint().textStackViewleftConstraint + infoHeight
        }
    }
    
    
    
    private var bottomStackViewLeftConstraint: CGFloat! {
        get {
            return homeTabelViewCellSubViewSizeConstraint().stackViewLeftConstraint + homeTabelViewCellSubViewSizeConstraint().textStackViewleftConstraint + infoHeight
        }
    }
    
    private var imagesCollectionViewHeight: CGFloat! {
        get {
            return cellSize.height / 1.8
        }
    }
    
    private var onePictureWidth: CGFloat! {
        get {
            return cellSize.height / 5
        }
    }
    
    private var onePictureHeight: CGFloat! {
        get {
            return cellSize.height / 2
        }
    }
    
 
    

    //MARK: initialize the cell
    private var cellSize: CGSize! {
        didSet {
            
            self.setUptextStackView(cellSize: cellSize)
            self.setUpinfoView(cellSize: cellSize)
            self.setUpPriceLabel(cellSize: cellSize)
            self.setUpdescribtionLabel(cellSize: cellSize)
            self.setUpImagesCollectionView()
            self.setUpBottomStackView()
            
            imagesCollectionView.register(HomeTableCollectionViewCell.self, forCellWithReuseIdentifier: resuseCollectionCellString)
         
        }
    }
    
    private var goodsID: String! {
        didSet {
            getImagesURL()
        }
    }
    
    public func setGoodsID(id: String) {
        goodsID = id
    }
    
    
    
    

    
    //MARK: - set up cell size
    //get size from home controller and set up the cell size
    func setCellSize(size: CGSize) {
        
        self.cellSize = size
        
    }
    
    //MARK: - set up user's image view and constrain
    private func setUpImageView (cellSize: CGSize) {
        userImageView.backgroundColor = UIColor.blue
        userImageView.snp.makeConstraints { (make) in
            make.size.width.equalTo(infoHeight)
            make.size.height.equalTo(infoHeight)
            make.left.equalTo(infoView).offset(0)
            make.top.equalTo(infoView).offset(0)
            make.bottom.equalTo(infoView).offset(0)
        }
    }
   
    
    //MARK: - the stack veiw of user's name, user's group location and constrains
    private func setUptextStackView(cellSize: CGSize) {
        
        textStackView.addArrangedSubview(userNamelabel)
        textStackView.addArrangedSubview(groupLocationLabel)
        textStackView.axis = .vertical
        textStackView.distribution = .fillEqually
        
        self.contentView.addSubview(textStackView)
        userNamelabel.backgroundColor = UIColor.black
        groupLocationLabel.backgroundColor = UIColor.brown
        
    }
    
    private func setUpConstrainOfTextStackView() {
        textStackView.snp.makeConstraints { (make) in
            make.left.equalTo(userImageView.snp.right).offset(homeTabelViewCellSubViewSizeConstraint().textStackViewleftConstraint)
            make.top.equalTo(infoView).offset(0)
            make.bottom.equalTo(infoView).offset(0)
            make.right.equalTo(infoView).offset(0)
        }
    }
    
    //MARK: - the stack view of the user's image, user's name, user's group location
    private func setUpinfoView(cellSize: CGSize) {
        self.contentView.addSubview(infoView)
        
     
        infoView.addSubview(userImageView)
        infoView.addSubview(textStackView)
        
        self.setUpImageView(cellSize: cellSize)
        self.setUpConstrainOfTextStackView()
       
        infoView.snp.makeConstraints { (make) in
            make.height.equalTo(infoHeight)
            make.width.equalTo(infoWidth)
            make.top.equalTo(self.contentView.snp.top).offset(homeTabelViewCellSubViewSizeConstraint().stackViewTopConstraint)
            make.left.equalTo(self.contentView.snp.left).offset(homeTabelViewCellSubViewSizeConstraint().stackViewLeftConstraint)

        }
    
    }
    
    //MARK: - set up the price label
    private func setUpPriceLabel(cellSize: CGSize) {
        self.contentView.addSubview(priceLabel)
        priceLabel.backgroundColor = UIColor.cyan
        priceLabel.snp.makeConstraints { (make) in
            make.height.equalTo(infoHeight)
            make.top.equalTo(self.contentView.snp.top).offset(homeTabelViewCellSubViewSizeConstraint().stackViewTopConstraint)
            make.left.equalTo(infoView.snp.right).offset(homeTabelViewCellSubViewSizeConstraint().priceLabelLeftConstraint)
            make.right.equalTo(self.contentView.snp.right).offset(homeTabelViewCellSubViewSizeConstraint().priceLabelRightConstraint)
            
        }
    }
    
    //MARK: - set up the describtion Label
    private func setUpdescribtionLabel(cellSize: CGSize) {
        describtionLabel.backgroundColor = UIColor.green
        self.contentView.addSubview(describtionLabel)
        describtionLabel.snp.makeConstraints { (make) in
            make.height.equalTo(infoHeight)
            make.left.equalTo(describtionLeftConstraint)
            make.right.equalTo(homeTabelViewCellSubViewSizeConstraint().describtionRightConstraint)
        make.top.equalTo(textStackView.snp.bottom).offset(homeTabelViewCellSubViewSizeConstraint().describtionTopConstraint)
            
        }
    }
    
    //MARK: - set up the collection view
    private func setUpImagesCollectionView() {
        //TODO: setup scroll view
        let layoutObject = UICollectionViewFlowLayout()
        layoutObject.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: homeTabelViewCellSubViewSizeConstraint().imageCollectionViewInnerRightConstraint)
        layoutObject.scrollDirection = .horizontal
        layoutObject.itemSize = CGSize(width: onePictureWidth, height: onePictureHeight)
        imagesCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layoutObject)
        imagesCollectionView.backgroundColor = UIColor.blue
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        self.contentView.addSubview(imagesCollectionView)
        
        
        imagesCollectionView.snp.makeConstraints { (make) in
            make.height.equalTo(self.imagesCollectionViewHeight)
            make.left.equalTo(self.contentView.snp.left).offset(self.imagesCollectionViewLeftConstraint)
            make.right.equalTo(self.contentView.snp.right).offset(homeTabelViewCellSubViewSizeConstraint().imageCollectionViewRightConstraint)
            make.top.equalTo(self.textStackView.snp.bottom).offset(homeTabelViewCellSubViewSizeConstraint().imageCollectionViewTopConstraint)
        }
    }

    //MARK: - set up location label
    private func setUpLocationLabel() {
        locationLabel.backgroundColor = UIColor.gray
        
    }
    
    //MARK: - set up bottom stack view
    private func setUpBottomStackView() {
        bottomStackView.backgroundColor = UIColor.green
         locationLabel.backgroundColor = UIColor.orange
        numberOfLikesLabel.backgroundColor = UIColor.purple
        bottomStackView.addArrangedSubview(self.locationLabel)
        bottomStackView.addArrangedSubview(self.numberOfLikesLabel)
        bottomStackView.distribution = .fillEqually
        self.contentView.addSubview(bottomStackView)
        
        bottomStackView.snp.makeConstraints { (make) in
            make.top.equalTo(self.imagesCollectionView.snp.bottom).offset(homeTabelViewCellSubViewSizeConstraint().bottomStackViewTopConstraint)
            make.right.equalTo(self.contentView.snp.right).offset(homeTabelViewCellSubViewSizeConstraint().bottomStackViewRightConstraint)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(homeTabelViewCellSubViewSizeConstraint().bottomStackViewBottomConstraint)
                make.left.equalTo(self.contentView.snp.left).offset(bottomStackViewLeftConstraint)
            
            
        }
    }
    
    //MARK: - get goods's all images url
    private func getImagesURL() {
        //TODO: get images and populate to the images array
    }
    

    
   
}

extension HomeTableViewCell {
    struct homeTabelViewCellSubViewSizeConstraint {
        let stackViewLeftConstraint: CGFloat = 10
        let stackViewRightConstraint: CGFloat = 10
        let stackViewTopConstraint: CGFloat = 10
        
        let priceLabelLeftConstraint: CGFloat = 0
        let priceLabelRightConstraint: CGFloat = -10
        
        let textStackViewleftConstraint: CGFloat = 6
 
        let describtionRightConstraint: CGFloat = -10
        let describtionTopConstraint: CGFloat = 7
        
        let imageCollectionViewTopConstraint: CGFloat = 7
        let imageCollectionViewRightConstraint: CGFloat = 0
        let imageCollectionViewInnerRightConstraint: CGFloat = 10
        
        let bottomStackViewTopConstraint: CGFloat = 7
        let bottomStackViewBottomConstraint: CGFloat = -10
        let bottomStackViewRightConstraint: CGFloat = -10
        
        let picturesOffset: CGFloat = 4
        let picturesRightOffset: CGFloat = 10
        
        
        
    }
    
}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - collection view data scource method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.resuseCollectionCellString, for: indexPath)
        if let cell = cell as? HomeTableCollectionViewCell {
            fetchImage(imageURLString: imagesURL[indexPath.row]) { (image) in
                DispatchQueue.main.async {
                    cell.upateUI(image: image)
                }
            }
        }
        return cell
    }
    
    //MARK: - fetch image from firebase asyn based on their url
    private func fetchImage(imageURLString: String, updateCellComplectionHandler: (_ image: UIImage) -> Void ) {
        
    }

    
}





















