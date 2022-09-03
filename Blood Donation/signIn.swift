//
//  signIn.swift
//  Blood Donation
//
//  Created by HTU on 8/3/22.
//  Copyright © 2022 HTU. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore


class signIn: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.isSecureTextEntry = true
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func signInButton(_ sender: Any) {
        //validate
        
        //  create clean version of textfields
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //signing in the user
        
        Auth.auth().signIn(withEmail: email, password: password) { (result , error) in
            if error != nil {
                print(error!)
            }
            else{
                print("signed in")
                self.redirectUserPage()
            }
        }
    }
    
   
    @IBAction func forgotButton(_ sender: Any) {
    }
    
    @IBAction func registerButton(_ sender: Any) {
    }
    @IBAction func googleAuthButton(_ sender: Any) {
    }
    @IBAction func facebookAuthButton(_ sender: Any) {
    }
    func redirectUserPage()
    {
        let accountViewController = storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.tabBar) as?
                 TabBarController
                 view.window?.rootViewController = accountViewController
                 view.window?.makeKeyAndVisible()
        
    }
}
