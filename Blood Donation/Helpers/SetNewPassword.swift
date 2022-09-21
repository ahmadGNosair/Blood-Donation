//
//  SetNewPassword.swift
//  Blood Donation
//
//  Created by HTU on 9/1/22.
//  Copyright © 2022 HTU. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class SetNewPassword: UIViewController {

    @IBOutlet weak var currentPass: UITextField!
    
    @IBOutlet weak var newPass: UITextField!
    
    @IBOutlet weak var newPassConfirm: UITextField!
    
    @IBAction func setPassButton(_ sender: Any) {
        var docID : String!
        
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser?.uid
        db.collection("users").whereField("email", isEqualTo: Auth.auth().currentUser?.email ?? "").getDocuments() { (querySnapshot, err) in
            if let err = err{
                print(err)
            }else {
                for document in querySnapshot!.documents {
                    print(document.data())
                    docID = document.documentID
                    if (self.currentPass.text == "\(document.get("password") ?? "")") {
                        if (self.newPass.text == self.newPassConfirm.text) {
                            db.collection("users").document(docID).updateData(["password":self.newPass.text!])
                            Auth.auth().currentUser?.updatePassword(to: self.newPass.text!){ error in
                                if let error = error{
                                    print(error)
                                }
                            }
                        }else{
                            print("password doesn't match")
                              self.newPassConfirm.layer.borderColor = UIColor.red.cgColor
                                          self.newPassConfirm.layer.borderWidth = 1
                                          self.newPassConfirm.text = ""
                                          self.newPassConfirm.placeholder = "Password doesn't match"
                        }
                    }else{
                        print("incorrect password")
                        self.currentPass.layer.borderColor = UIColor.red.cgColor
                        self.currentPass.layer.borderWidth = 1
                        self.currentPass.text = ""
                        self.currentPass.placeholder = "Incorrect Password"

                    }
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentPass.isSecureTextEntry = true
        newPassConfirm.isSecureTextEntry = true
        newPass.isSecureTextEntry = true

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
