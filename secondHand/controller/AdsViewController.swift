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
    var webView: WKWebView?
    var errorImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        webView?.navigationDelegate = self
        self.view.addSubview(webView!)
        //set up a view when the web view content is not available
        
        errorImageView?.image = UIImage(named: "404.jpg")
        self.view.addSubview(errorImageView!)
        errorImageView?.isHidden = false
        self.view.backgroundColor = UIColor.black
        
    }
    
    //get the parents view controller size and set up views in the current controller
    func setSubviewSize(size: CGRect) {
        var configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), configuration: configuration)
        errorImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
    }
    
    func loadURLRequest(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
            
        }
        let requst = URLRequest(url: url)
        webView?.load(requst)
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        webView.isHidden = true
        errorImageView?.isHidden = false
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        webView.isHidden = true
        errorImageView?.isHidden = false
    }
    

 

}
