//
//  register.swift
//  Blood Donation
//
//  Created by HTU on 8/3/22.
//  Copyright © 2022 HTU. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseCore
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage

class register: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let storage = Storage.storage().reference()
    var image : UIImage?
    var imageData : Data?
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        else {
            return
        }
        self.image = image

        guard let imageData = image.pngData()
            else{
            return
        }
        self.imageData = imageData

        picker.dismiss(animated: true, completion: nil)
        self.profilepicture.image = image
        
        
        
        
    }
    

    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBOutlet weak var emailAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilepicture.clipsToBounds = true
        profilepicture.layer.cornerRadius = profilepicture.frame.size.height / 2
        profilepicture.layer.borderWidth = 0.25
        passwordTextField.isSecureTextEntry = true
        confirmPass.isSecureTextEntry = true
        
        
     //   birthDate.inputView = birth;
        
        setupRemoteConfigDefault()
        displayNewValues()
        fetchRemoteConfig()
        
        
    }
    
    func validateFields () -> String? {
        if fname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        lname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        phoneNo.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            city.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            bloodType.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        return nil
    }
        
        func redirectToHome(){
            let signInController = storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.signInPage) as?
            signIn
            
            view.window?.rootViewController = signInController
            view.window?.makeKeyAndVisible()
        }
        
        
    
    
    @IBAction func addImage(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    
    
    @IBAction func registerButton(_ sender: UIButton) {
       //validate
        let error = validateFields()
        
        if error != nil{
            print(error!)
        }
        
        //create user
        if (self.passwordTextField.text == self.confirmPass.text) {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, err) in
                if err != nil{
                
                    print("error creating user")
                    print(err!)
                }
                else{
                    
                    self.storage.child("images/file.png").putData(self.imageData!, metadata: nil, completion: {_, error in
                        guard error == nil else {
                            print ("failed to upload")
                            return
                        }
                        self.profilepicture.image = self.image
                        self.storage.child("images/file.png").downloadURL(completion: {url, error in
                            guard let url = url, error == nil else {
                                return
                            }
                            let urlString = url.absoluteString
                            print("download url : \(urlString)")
                            UserDefaults.standard.set(urlString, forKey: "url")
                        })
                    })
                    
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["first_name" : self.fname.text!, "last_name":self.lname.text! , "uid" : result!.user.uid , "phone":self.phoneNo.text! , "city":self.city.text!, "blood_type": self.bloodType.text!, "email":self.emailAddress.text!,"password":self.passwordTextField.text!, "profile_picture": UserDefaults.standard.string(forKey: "url")!]) { (error) in
                        
                        if error != nil {
                            print(error!)
                            print(self.fname.text!)
                            print(self.phoneNo.text!)
                            
                        }
                    }
                    
                    self.redirectToHome()
                }
                
            }
        }
        
         
        
       
    }
      
    @IBOutlet weak var fname: UITextField!
    
    @IBOutlet weak var lname: UITextField!
    
    @IBOutlet weak var phoneNo: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPass: UITextField!
    
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var bloodType: UITextField!
    
    @IBOutlet weak var registerLabel: UILabel!
    
    @IBOutlet weak var profilepicture: UIImageView!
    
    var imagepick = UIImagePickerController()
  
   
    
    func setupRemoteConfigDefault(){
        let defaultValue = ["label_text": "Register" as NSObject]
        remoteConfig.setDefaults(defaultValue)
    }
    func fetchRemoteConfig() {
        remoteConfig.fetch(withExpirationDuration: 0) {
            [unowned self] (status, error) in guard error == nil else{return }
            print("Got the value from Remote Config!")
            remoteConfig.activate()
            self.displayNewValues()
            
        }
    }
    func displayNewValues() {
        let newLabelText = remoteConfig.configValue(forKey: "label_text").stringValue ?? ""
        registerLabel.text = newLabelText
    }
 
     
}


