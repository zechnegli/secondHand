//
//  AdsViewController.swift
//  secondHand
//
//  Created by ZechengLi on 5/28/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit
import WebKit
class AdsViewController: UIViewController, WKNavigationDelegate {
    var webView = WKWebView()
    var errorImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setupErrorImageView()
        
        webView.navigationDelegate = self
        
    }
    
    
    
    
    //MARK: - set up web view(Ads)
    private func setupWebView() {

        self.view.addSubview(webView)
        
        webView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view.snp.top).offset(AdsViewControllerConstants().webViewTopConstraint)
            make.bottom.equalTo(self.view.snp.bottom).offset(AdsViewControllerConstants().webViewBottomConstraint)
            make.left.equalTo(self.view.snp.left).offset(AdsViewControllerConstants().webViewLeftConstraint)
            make.right.equalTo(self.view.snp.right).offset(AdsViewControllerConstants().webViewRightConstraint)
        })
    }
    
    //MARK: - set up error message view
     //display a error view when the web view content is not available
    private func setupErrorImageView() {
        errorImageView.image = UIImage(named: "ad.jpg")
        self.view.addSubview(errorImageView)
        errorImageView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view.snp.top).offset(AdsViewControllerConstants().errorImageViewTopConstraint)
            make.bottom.equalTo(self.view.snp.bottom).offset(AdsViewControllerConstants().errorImageViewBottomConstraint)
            make.left.equalTo(self.view.snp.left).offset(AdsViewControllerConstants().errorImageViewLeftConstraint)
            make.right.equalTo(self.view.snp.right).offset(AdsViewControllerConstants().errorImageViewRightConstraint)
        })
        errorImageView.isHidden = false
    }
    
    
    func loadURLRequest(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
            
        }
        let requst = URLRequest(url: url)
        webView.load(requst)
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        webView.isHidden = true
        errorImageView.isHidden = false
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        webView.isHidden = true
        errorImageView.isHidden = false
    }
}

extension AdsViewController {
    struct AdsViewControllerConstants {
        //web view
        let webViewTopConstraint: CGFloat = 0
        let webViewLeftConstraint: CGFloat = 0
        let webViewRightConstraint: CGFloat = 0
        let webViewBottomConstraint: CGFloat = 0
        
        
        //error message view
        let errorImageViewTopConstraint: CGFloat = 0
        let errorImageViewBottomConstraint: CGFloat = 0
        let errorImageViewLeftConstraint: CGFloat = 0
        let errorImageViewRightConstraint: CGFloat = 0
    }
   
}
