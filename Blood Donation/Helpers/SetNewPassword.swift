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
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser?.uid
        db.collection("users").whereField("email", isEqualTo: Auth.auth().currentUser?.email ?? "").getDocuments() { (querySnapshot, err) in
            if let err = err{
                print(err)
            }else {
                for document in querySnapshot!.documents {
                    print(document.data())
                    if (self.currentPass.text == "\(document.get("password") ?? "")") {
                        if (self.newPass.text == self.newPassConfirm.text) {
                            db.collection("users").document().updateData(["password":self.newPass.text!])
                            Auth.auth().currentUser?.updatePassword(to: self.newPass.text!){ error in
                                if let error = error{
                                    print(error)
                                }
                            }
                        }else{
                            print("password doesn't match")
                        }
                    }else{
                        print("incorrect password")
                    }
                }
            }
        }
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
