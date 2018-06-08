//
//  SignUpController.swift
//  secondHand
//
//  Created by ZechengLi on 5/20/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit
import Firebase
class SignUpController: UIViewController {

    @IBOutlet weak var accountEmailTextfield: UITextField!
    
    
    @IBOutlet weak var passwordTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        if let email = accountEmailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    if let errorCode = AuthErrorCode(rawValue: (error as NSError).code) {
                        self.giveAlert(with: self.convertErrorCodeToString(with: errorCode))
                    }
                } else {
                    print("Signing up succeed")
                }
                
                
            }
        } else {
            print("Empty password or email account")
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
    
    //convert error code into string
    func convertErrorCodeToString(with errorCode: AuthErrorCode) -> String {
        switch errorCode {
        case .emailAlreadyInUse:
            return "The email address has already been used."
        case .invalidEmail:
            return "The email address is invalid. Please Enter it again"
        default:
            return "Unknown error"
        }
    }
    
 
    
    
    
    

}
