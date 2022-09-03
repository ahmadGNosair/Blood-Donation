//
//  SetNewPassword.swift
//  Blood Donation
//
//  Created by HTU on 9/1/22.
//  Copyright © 2022 HTU. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SetNewPassword: UIViewController {

    //hello
  
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var newPassConfirm: UITextField!
    @IBOutlet weak var currentPass: UITextField!
    
  /*  @IBAction func setPassword(_ sender: Any) {
        let db = Firestore.firestore()
        db.collection("users").whereField("email", isEqualTo: Auth.auth().currentUser?.email ?? "")
            .getDocuments() { (querySnapShot, err) in
                if let err = err {
                    print("error getting docs\(err)")
                }else {
                    for document in querySnapShot!.documents {
                    print("\(document.documentID) => \(document.data())")
                        print("1")
                        if(self.currentPass.text == "\(document.get("password") ?? "")"){
                            if(self.newPass.text == self.newPassConfirm.text){
                                Auth.auth().currentUser?.updatePassword(to: self.newPass.text!){
                                    error in
                                    if let error = error{
                                        print("\(error)")
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
        
    }*/
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
