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
import FirebaseStorage

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
               firstName.isEnabled = false
               lastName.isEnabled = false
               phone.isEnabled = false
               bloodType.isEnabled = false
               emailAddress.isEnabled = false
               city.isEnabled = false
    
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
    
    }
    var docRef : String!
    
    @IBAction func saveChanges(_ sender: Any) {
        let db = Firestore.firestore()
        print("docref is: \(docRef!)")
        db.collection("users").document(docRef).updateData(["first_name" : self.firstName.text!, "last_name" : self.lastName.text!, "phone" : self.phone.text!, "blood_type" : self.bloodType.text!, "email" : self.emailAddress.text!, "city" : self.city.text!]){ err in
            if let err = err{
                print(err)
            }
        }
       Auth.auth().currentUser?.updateEmail(to: self.emailAddress.text!){ error in
            if let error = error{
                print(error)
            }
        }
    
        firstName.isEnabled = false
        lastName.isEnabled = false
        phone.isEnabled = false
        bloodType.isEnabled = false
        emailAddress.isEnabled = false
        city.isEnabled = false
        
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
                    self.showToast(message: "Saved", font: .systemFont(ofSize: 12.0))
                }
            }
        }

    }
    @IBAction func editPictureButton(_ sender: Any) {
    }
    @IBAction func signOutButton(_ sender: Any) {
         let firebaseAuth = Auth.auth()
        redirectToHome()
        do {
          try firebaseAuth.signOut()
            
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    func redirectToHome(){
               let signInController = storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.signInPage) as?
               signIn
               
               view.window?.rootViewController = signInController
               view.window?.makeKeyAndVisible()
           }
    
    var picURl : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstName.isEnabled = false
        lastName.isEnabled = false
        phone.isEnabled = false
        bloodType.isEnabled = false
        emailAddress.isEnabled = false
        city.isEnabled = false
        
        profilePic?.layer.masksToBounds = true
        profilePic?.layer.cornerRadius = profilePic.frame.height / 2
        profilePic?.layer.borderWidth = 0.25
    
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
                    self.picURl = "\(document.get("profile_picture")!)"
                    print("\(self.picURl)from self.picURL")
                    self.docRef = "\(document.documentID)"
                    print("docref is form viewdidload : \(self.docRef!)")

                }
            }
        }
        
    
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child(picURl)
        print("viewdid")
        fileRef.getData(maxSize: 5 * 2048 * 2048) { data, err in
            if err == nil{
                let image = UIImage(data: data!)
                    print("err-nil")
                self.profilePic.image = image
                    print("11111111111\(data!)")
               
                
            }else{
                    print("000000000000000\(err!)00000000000000")
                    print("nil image")
                }
                
            }
        }
    
        func showToast(message : String, font: UIFont) {
        
            let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-150, width: 150, height: 35))
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.font = font
            toastLabel.textAlignment = .center;
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                 toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
    }
    
    


