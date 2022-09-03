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
    
    
        
    
    
    

    @IBOutlet weak var patientName: UITextField!
    
    @IBOutlet weak var patientPhone: UITextField!
    
    @IBOutlet weak var hospital: UITextField!
   
    @IBOutlet weak var numberOfUnits: UITextField!
    @IBOutlet weak var bloodTypeInput: UITextField!
    
    
    let hospitals = ["Istiqlal Hospital", "Prince Hamza Hospital" , "Al-Khaldi Hospital" , "Al-Abdali Hospital" , "Ibn Al-Haytham Hospital"]
    
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
        let db = Firestore.firestore()
        if (pName != "" && hosp != "" && blood != "" && pNumber != "" && units != "") {
            
                     db.collection("requests").addDocument(data: ["patient_name" : pName, "patient_phone":pNumber , "applicant_uid" : userID , "hospital":hosp , "blood_type":blood, "number_of_units": units]) { (error) in
                         
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



