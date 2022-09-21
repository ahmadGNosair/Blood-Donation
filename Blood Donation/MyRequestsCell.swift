//
//  MyRequestsCell.swift
//  Blood Donation
//
//  Created by HTU on 9/8/22.
//  Copyright © 2022 HTU. All rights reserved.
//

import UIKit
import FirebaseFirestore

class MyRequestsCell: UITableViewCell {

    @IBOutlet weak var numberOfUnits: UILabel?
    @IBOutlet weak var hospital: UILabel?
    @IBOutlet weak var bloodType: UILabel?
    @IBOutlet weak var profilePicture: UIImageView?
    @IBOutlet weak var patientName: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fillCell(profilePic : UIImage , unitsNo : String , hospital : String , bloodtype : String, Name : String){
        print(unitsNo, hospital, bloodtype, Name, "     0000000  \(profilePic) 0000000")
              
        self.profilePicture?.image = profilePic
        numberOfUnits!.text = "\(unitsNo) Units"
        self.hospital!.text = "\(hospital)"
          bloodType!.text = bloodtype
        patientName!.text = Name
          
             
      }
  
    
}
