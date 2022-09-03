//
//  RequestCellTableViewCell.swift
//  Blood Donation
//
//  Created by HTU on 8/24/22.
//  Copyright © 2022 HTU. All rights reserved.
//

import UIKit

class RequestCellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var numberOfUnits: UILabel!
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var bloodType: UILabel!
    @IBOutlet weak var hospitalName: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

     func fillCell(profilePic : UIImage , unitsNo : String , hospital : String , bloodtype : String){
           
           profilePicture.image = profilePic
           numberOfUnits.text = unitsNo
           hospitalName.text = hospital
           bloodType.text = bloodtype
           
           
       }}
