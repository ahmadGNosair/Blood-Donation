//
//  HomeCell.swift
//  Blood Donation
//
//  Created by HTU on 8/24/22.
//  Copyright © 2022 HTU. All rights reserved.
//

import UIKit
import FirebaseFirestore

class HomeCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }
    
    @IBOutlet weak var pofilePicture: UIImageView?
    @IBOutlet weak var numberOfUnits: UILabel?
    @IBOutlet weak var hospitalName: UILabel?
    @IBOutlet weak var bloodType: UILabel?
    @IBOutlet weak var pateintName: UILabel?
    
    @IBAction func callButton(_ sender: Any) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNo)") {
          let application:UIApplication = UIApplication.shared
          if (application.canOpenURL(phoneCallURL)) {
              application.open(phoneCallURL, options: [:], completionHandler: nil)
          }
        }
    }
    
    var phoneNo = ""
    
    @IBAction func whtsappText(_ sender: Any) {
        let phoneNumber = phoneNo
        let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
        if UIApplication.shared.canOpenURL(appURL){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
            else{
                UIApplication.shared.openURL(appURL)
            }
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    func fillCell(profilePic : UIImage , unitsNo : String , hospital : String , bloodtype : String, phone : String){
           print(unitsNo, hospital, bloodtype)
            
        self.pofilePicture?.image = profilePic
        numberOfUnits!.text = "\(unitsNo) Units"
        hospitalName!.text = "\(hospital)"
        bloodType!.text = bloodtype
        phoneNo = phone
           
    }
    
}
