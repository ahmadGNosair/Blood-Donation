//
//  register.swift
//  Blood Donation
//
//  Created by HTU on 8/3/22.
//  Copyright © 2022 HTU. All rights reserved.
//

import UIKit

class register: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        birthDate.inputView = birth;
    }
    
    @IBOutlet weak var birthDate: UITextField!
    var birth = UIDatePicker()
    
    
  private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMddyyyy")
        return formatter
    }()
}
