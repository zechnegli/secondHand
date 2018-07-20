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
import SwiftKeychainWrapper

class LoginInController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var userNameTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    //whether this user has already loggoed in 
    
    //email and password sign in
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        if let userName = userNameTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: userName, password: password) { (user, error) in
                if let error = error {
                    //handle error of signing in
                    print("zecheng logining in firebase with password and acoount failed")
                    if let errorCode = AuthErrorCode(rawValue: (error as NSError).code) {
                        self.giveAlert(with: self.convertErrorCodeToMessage(with: errorCode))
                    }
                } else if let user = user {
                    //store the firebase token
                    print("zecheng logining in firebase with password and acoount succeed")
                    KeychainWrapper.standard.set(user.user.uid, forKey:Constant().UID)
                }
                
            }
        }
    }
    
    
    //give an alert when there is error
    func giveAlert(with errorDiscribtion: String) {
        let alertVC = UIAlertController(title: "Error", message: errorDiscribtion, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: true, completion: {
            self.passwordTextfield.text = nil
            
        })
    }
    //login in facebook and firebase
    @IBAction func loginInWithFB(_ sender: UIButton) {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
       
        loginManager.logIn(withReadPermissions: ["public_profile","email","user_friends"], from: self) { (result, error) in
            if error != nil {
                print("zecheng logining in facebook failed")
            } else if (result != nil && (result?.isCancelled)!) {
                print("zecheng logining in facebook cancelled")
            } else {
                print("zecheng logining in facebook succeed")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                
                //login in firebase
                Auth.auth().signIn(with: credential, completion: { (user, error) in
                    if error != nil {
                        print("zecheng logining in firebase with facebook failed ")
                    } else if let user = user {
                        print("zecheng logining in firebase with facebook succeed ")
                        KeychainWrapper.standard.set(user.uid, forKey: Constant().UID)
                        
                    }
                })
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
    
    //return error message based on the specifice error code
    func convertErrorCodeToMessage(with errorCode: AuthErrorCode) -> String {
        switch errorCode {
            case .invalidEmail:
                return "The email format is invaild, please enter it again"
            
            case .userNotFound:
                return "create"
            case .emailAlreadyInUse:
                return "The email addreass has already existed."
            
            case .wrongPassword:
                return "Wrong password, please enter it again"
            default:
                return "unknown error"
        }
    }
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

