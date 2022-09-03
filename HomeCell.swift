//
//  HomeCell.swift
//  Blood Donation
//
//  Created by HTU on 8/24/22.
//  Copyright © 2022 HTU. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }
    
    @IBOutlet weak var pofilePicture: UIImageView?
    @IBOutlet weak var numberOfUnits: UILabel?
    @IBOutlet weak var hospitalName: UILabel?
    @IBOutlet weak var bloodType: UILabel?
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

     func fillCell(/*profilePic : UIImage ,*/ unitsNo : String , hospital : String , bloodtype : String){
           print(unitsNo, hospital, bloodtype)
          // profilePicture.image = profilePic
        numberOfUnits!.text = "\(unitsNo) Units"
        hospitalName!.text = "\(hospital)"
        bloodType!.text = bloodtype
           
    }
    
}
