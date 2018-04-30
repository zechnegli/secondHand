//
//  ViewController.swift
//  secondHand
//
//  Created by ZechengLi on 4/21/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit
class LoginInController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    @IBAction func loginInWithFB(_ sender: UIButton) {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
       
        loginManager.logIn(withReadPermissions: ["public_profile","email","user_friends"], from: self) { (result, error) in
            if error != nil {
                print("zecheng logining in facebook failed")
            } else if (result != nil && (result?.isCancelled)!) {
                print("zecheng logining in facebook cancelled")
            } else {
                //Successfully loggedIn
            }
        }
        
    
    }

    
    @IBAction func loginInWithGoogle(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    
    @IBAction func loginInWithWechat(_ sender: UIButton) {
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
    }
    
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

