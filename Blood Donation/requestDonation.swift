//
//  requestDonation.swift
//  Blood Donation
//
//  Created by HTU on 7/28/22.
//  Copyright © 2022 HTU. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class requestDonation: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(hospital.isEditing)
        
        {
            print(hospital.isEditing)
            return hospitals.count
            
        }
        else
        {
            return bloodarray.count
        }
      
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           if(hospital.isEditing) {
                 
                 return hospitals[row]
            
           }
             else
           {
                 return bloodarray[row]
             }
          
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
       
           if(hospital.isEditing)
           {
                
            hospital.text = hospitals[row]
            
           }
             else
           {
            bloodTypeInput.text = bloodarray[row]
            }
         
    
}
    
    
        
    
    
    
    @IBAction func infoSwitch(_ sender: UISwitch) {
        if sender.isOn{
        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: "\(Auth.auth().currentUser?.uid ?? "")").getDocuments(){ (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            
            for document in querySnapshot!.documents{
                self.patientName.text! = "\(document.get("first_name") as! String) \(document.get("last_name") ?? "")"
                self.bloodTypeInput.text! = (document.get("blood_type") as! String)
                self.patientPhone.text! = (document.get("phone") as! String)
                
            }
            }
        
        }
        
        }
        else {
            self.patientName.text = ""
            self.hospital.text = ""
            self.bloodTypeInput.text = ""
            self.patientPhone.text = ""
            self.numberOfUnits.text = ""
        }
    }
    
    @IBOutlet weak var patientName: UITextField!
    
    @IBOutlet weak var patientPhone: UITextField!
    
    @IBOutlet weak var hospital: UITextField!
   
    @IBOutlet weak var numberOfUnits: UITextField!
    @IBOutlet weak var bloodTypeInput: UITextField!
    
    
    let hospitals =
     ["Abdali Hospital",
     "Abdulhadi Eye Hospital",
     "Akilah Hospital",
     "Al-Kindi Hospital",
     "Al Ahli Hospital",
     "Al Hanan General Hospital",
     "Al Hayat General Hospital",
     "Al Khalidi Medical Center",
     "Makassed Hospital",
     "Al-Essra Hospital",
     "Al-Hikma Modern Hospital",
     "King Hussein Cancer Center",
     "King Hussein Medical Center",
     "Al-Iman Hospital",
     "Al-Jazeera Hospital",
     "Al-Amal Hospital",
     "Shmaisani Hospital",
     "South Shona Hospital – Balqa",
     "Speciality Hospital",
     "Tlaa’ Al-Ali Hospital",
     "Mouwasat Hospital",
     "Al-Najah Hospital",
     "Al-Nour Sanitarium",
     "Queen Rania Hospital",
     "Al-Qawasmi Hospital",
     "Al-Rashid Hospital Center",
     "Qasr Shabeeb Hospital",
     "Amman Surgical Hospital",
     "Arab Medical Center",
     "The Arab Potash Co. Hospital",
     "Farah Center for Rehabilitation",
     "The Farah Hospital",
     "Ibn-Alhaytham Hospital",
     "Ibn-Alnafees Hospital",
     "Irbid Speciality Hospital",
     "The Islamic Hospital",
     "Istiklal Hospital",
     "Istishari Hospital",
     "Jordan Hospital",
     "Palestine Hospital",
     "Philadelphia Hospital",
     "Milad Hospital",
     "Jordan Red Crescent Hospital",
     "Jordan University Hospital",
     "King Abdullah University Hospital",
     "King Hussein Cancer Center",
     "Luzmila Hospital",
     "Milad Hospital"]

    
    let bloodarray = ["A+" , "A-", "B+","B-","O+","O-","AB+","AB-"]
    
    var hosPicker = UIPickerView()
    
    var bloodtypepick = UIPickerView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hosPicker.delegate = self
        hosPicker.dataSource = self
        
        hospital.inputView = hosPicker
        
        bloodtypepick.delegate = self
        bloodtypepick.dataSource = self
        
        bloodTypeInput.inputView = bloodtypepick
        
        
     
        
        
        
        
        
        
    }

    
    
    @IBAction func requestButton(_ sender: UIButton) {
        
        let pName = patientName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let hosp = hospital.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let blood = bloodTypeInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pNumber = patientPhone.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let units =  numberOfUnits.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let userID = Auth.auth().currentUser!.uid
        let uuid = UUID.init()
        let db = Firestore.firestore()
        if (pName != "" && hosp != "" && blood != "" && pNumber != "" && units != "") {
            
            db.collection("requests").addDocument(data: ["patient_name" : pName, "patient_phone":pNumber , "applicant_uid" : userID , "hospital":hosp , "blood_type":blood, "number_of_units": units, "request_id": uuid]) { (error) in
                         
                         if error != nil {
                             print(error!)
                        }
                         }
                        self.patientName.text = nil
                        self.hospital.text = nil
                        self.bloodTypeInput.text = nil
                        self.patientPhone.text = nil
                        self.numberOfUnits.text = nil
        }else {
            print("invalid")
        }
                        
                        
        
                
            
    }
    
   
    }



