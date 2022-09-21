//
//  EditRequest.swift
//  Blood Donation
//
//  Created by HTU on 9/21/22.
//  Copyright © 2022 HTU. All rights reserved.
//

import UIKit


class EditRequest: UIViewController {

    @IBOutlet weak var patientName: UITextField!
    @IBOutlet weak var hospital: UITextField!
    @IBOutlet weak var bloodtypeText: UITextField!
    @IBOutlet weak var patientPhone: UITextField!
    @IBOutlet weak var numberOfUnits: UITextField!
    
    @IBAction func editButton(_ sender: Any) {
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        back()
    }
    func back()
    {
        let back = storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.myrequests) as? MyRequests
                 
                 view.window?.rootViewController = back
                 view.window?.makeKeyAndVisible()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
