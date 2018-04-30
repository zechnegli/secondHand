//
//  Constants.swift
//  secondHand
//
//  Created by ZechengLi on 4/27/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
let databaseRootRef = Database.database().reference()
let storageRootRef = Storage.storage().reference()
class FirebaseReference {
    //skeleton
    static var constant = FirebaseReference()
    let databaseUsersRef = databaseRootRef.child("Users")
    
    
    var currentUserInfoRef: DatabaseReference!
    private var currentUID: String!
    
    
    func setCurrentUID(id: String) {
        currentUID = id
        
    }
    func setCurrentUserInfoRef(id: String) {
        currentUserInfoRef = databaseUsersRef.child(id)
    }
    
    func getCurrentUID() -> String? {
       return currentUID
    }
    
    
    
    
    
    
    
    
    
}
