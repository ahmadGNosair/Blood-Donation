//
//  requestDonation.swift
//  Blood Donation
//
//  Created by HTU on 7/28/22.
//  Copyright © 2022 HTU. All rights reserved.
//

import UIKit

class requestDonation: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(hospital.tag == 1)
        
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
           if(hospital.tag == 1) {
                 
                 return hospitals[row]
            
           }
             else
           {
                 return bloodarray[row]
             }
          
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
       
           if(hospital.tag == 1)
           {
                
            hospital.text = hospitals[row]
            
           }
             else
           {
            bloodTypeInput.text = bloodarray[row]
            }
         
    
}
    
    
    

    @IBOutlet weak var hospital: UITextField!
   
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
    
    
   
    }


