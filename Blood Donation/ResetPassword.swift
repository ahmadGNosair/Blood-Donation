//
//  ResetPassword.swift
//  Blood Donation
//
//  Created by HTU on 9/10/22.
//  Copyright © 2022 HTU. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ResetPassword: UIViewController {

    @IBOutlet weak var emailAddress: UITextField!
    
    @IBAction func resetPassButton(_ sender: Any) {
        let email = emailAddress.text!
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error{
                print(error)
                self.emailAddress.layer.borderColor = UIColor.red.cgColor
                self.emailAddress.layer.borderWidth = 1
                self.emailAddress.text = ""
                self.emailAddress.placeholder = "Incorrect email"
                

            }else{
                
                print("email sent")
                self.emailAddress.layer.borderWidth = 0
                self.emailAddress.placeholder = "Email Address"
                self.redirectToHome()
            }
        }
    }
    
    func redirectToHome(){
        let signInController = storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.signInPage) as?
        signIn
        
        view.window?.rootViewController = signInController
        view.window?.makeKeyAndVisible()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
