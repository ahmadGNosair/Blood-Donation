//
//  HomeViewController.swift
//  Blood Donation
//
//  Created by HTU on 8/10/22.
//  Copyright © 2022 HTU. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var requestsArray = [Requests]()
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(requestsArray.count)
        return requestsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! HomeCell
        
        let mydata = requestsArray[indexPath.row]
       /* cell.pofilePicture?.image = UIImage(systemName: "person.circle")
        cell.numberOfUnits?.text = "\(mydata.units ?? "") Units"
        cell.bloodType?.text = mydata.bloodType
        cell.hospitalName?.text = mydata.hospital*/
        cell.fillCell(profilePic: mydata.profilePic, unitsNo: mydata.units, hospital: mydata.hospital, bloodtype: mydata.bloodType, phone: mydata.phone)
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    @IBAction func refresh(_ sender: Any) {
        self.viewDidLoad()
        refreshControl.endRefreshing()
    }
    let refreshControl = UIRefreshControl()

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Requests"
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
      //  self.tableView.register(HomeCell.self, forCellReuseIdentifier: "myCell")
        loadData()
        //refresh(_:))
     refreshControl.attributedTitle = NSAttributedString(string: "refreshing")
       refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
     //tableView.addSubview(refreshControl) // not required when using UITableViewController
        
    }
    var picUrl : String!
    func loadData()  {
        let db = Firestore.firestore()
        let storage = Storage.storage().reference()
        var userId : String!
            db.collection("requests").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting from firestore: \(err)")
                    
                }else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        self.requestsArray.append(Requests.init(profilePic: UIImage(systemName: "person.circle")! , units: "\( document.get("number_of_units")!)", bloodType: "\(document.get("blood_type")!)", hospital: "\( document.get("hospital")!)",phone: "\(document.get("patient_phone")!)"))
                        userId = (document.get("applicant_uid") as! String)
                        
                        
                        print("\(self.requestsArray) from array###")
                        
                    }
                    self.tableView.reloadData()
                }
        }
    }
    
    struct Requests {
        var profilePic : UIImage!
        var units : String!
        var bloodType : String!
        var hospital : String!
        var phone : String!
    }
    

}
