//
//  AppDelegate.swift
//  secondHand
//
//  Created by ZechengLi on 4/21/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import SwiftKeychainWrapper
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    //MARK: GID sigin in delegate methods
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print("Zecheng google signin failed")
            return
        }
            print("Zecheng google signin succeed")
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        //use google credential to sign in firebase
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print("Zecheng signing firebase with google failed")
                return
            } else if let user = user {
                //store firebase token
                KeychainWrapper.standard.set(user.uid, forKey: Constant().UID)
                self.setUpbasicInfo(currentUserUID: user.uid)
            }
            print("Zecheng signing firebase with google succeed")
            
            
            
           
            
           
        }
    }
    //if this is the first time that the user sigin in firebase, set up baisc info about this user in database
    func setUpbasicInfo(currentUserUID: String) {
        
        FirebaseReference.constant.databaseUsersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if  let value = snapshot.value as? [String: Any] {
                guard let currentUserRef = value[currentUserUID] as? [String: Any] else {
                    print("zecheng this is the first time that the user signin the firebase")
                    return
                }
               
            }
            print("zecheng this is not the first time that the user signin the firebase")
        }) { (error) in
            print("zecheng verfing user info in freabase database failed")
        }
    }
        
    
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    
    
    
    
    
    
    

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        return true
    }
    
//    //handle URL at the end of authentication process(Google)
//    @available(iOS 9.0, *)
//    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
//        -> Bool {
//            return GIDSignIn.sharedInstance().handle(url,
//                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
//                                                     annotation: [:])
//    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

