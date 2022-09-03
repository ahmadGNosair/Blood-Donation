//
//  accountInfo.swift
//  Blood Donation
//
//  Created by HTU on 8/10/22.
//  Copyright © 2022 HTU. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class accountInfo: UIViewController {

    let storage = Storage.storage()
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.layer.masksToBounds = true
        profilePic.layer.cornerRadius = profilePic.frame.size.height / 2
        
        
        let db = Firestore.firestore()

        db.collection("users").whereField("email", isEqualTo: Auth.auth().currentUser?.email ?? "")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        self.userName.text = "\(document.get("first_name") as? String ?? "")  \(document.get("last_name") as? String ?? "")"
                        var pic = "\(document.get ("profile_picture") as? UIImage )"
                        self.profilePic.image = pic as? UIImage
                    }
                }
        }
        }
         
         
        
        
     
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


