//
//  EditMyInfo.swift
//  Blood Donation
//
//  Created by HTU on 9/1/22.
//  Copyright © 2022 HTU. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class EditMyInfo: UIViewController {
    
    
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var bloodType: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var city: UITextField!
    
    
    @IBAction func editFname(_ sender: Any) {
        firstName.isEnabled = !firstName.isEnabled
    }
    @IBAction func editLname(_ sender: Any) {
        lastName.isEnabled = !lastName.isEnabled
    }
    @IBAction func editPhone(_ sender: Any) {
        phone.isEnabled = !phone.isEnabled
    }
    @IBAction func editBloodType(_ sender: Any) {
        bloodType.isEnabled = !bloodType.isEnabled
    }
    @IBAction func editEmail(_ sender: Any) {
        emailAddress.isEnabled = !emailAddress.isEnabled
    }
    @IBAction func editCity(_ sender: Any) {
        city.isEnabled = !city.isEnabled
    }
    
    
    
    
    @IBAction func cancelEditButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstName.isEnabled = false
        lastName.isEnabled = false
        phone.isEnabled = false
        bloodType.isEnabled = false
        emailAddress.isEnabled = false
        city.isEnabled = false
        
        profilePic.layer.masksToBounds = true
        profilePic.layer.cornerRadius = profilePic.frame.height / 2
    
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser?.uid
        db.collection("users").whereField("uid", isEqualTo: "\(userId ?? "")").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print(err)
            }else{
                for document in querySnapshot!.documents {
                    self.firstName.text = "\(document.get("first_name")!)"
                    self.lastName.text = "\(document.get("last_name")!)"
                    self.phone.text = "\(document.get("phone")!)"
                    self.bloodType.text = "\(document.get("blood_type")!)"
                    self.emailAddress.text = "\(document.get("email")!)"
                    self.city.text = "\(document.get("city")!)"
                    
                }
            }
        }
        
        
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
