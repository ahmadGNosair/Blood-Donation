//
//  HomeViewController.swift
//  Blood Donation
//
//  Created by HTU on 8/10/22.
//  Copyright © 2022 HTU. All rights reserved.
//

import UIKit
import FirebaseFirestore

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
        print("\(mydata) mydata###")
        //cell.fillCell(/*profilePic: mydata.profilePic, */unitsNo: "5", hospital:  "ghfd", bloodtype: "A+")
        print("mjjjjjjjjjj\(String(describing: mydata.units))mjjjjjjjjjjj")
        cell.pofilePicture?.image = UIImage(systemName: "person.circle")
        cell.numberOfUnits?.text = mydata.units
        cell.bloodType?.text = mydata.bloodType
        cell.hospitalName?.text = mydata.hospital
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
      //  self.tableView.register(HomeCell.self, forCellReuseIdentifier: "myCell")
        loadData()
        
     
        
    }
    
    func loadData()  {
        let db = Firestore.firestore()
            db.collection("requests").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting from firestore: \(err)")
                    
                }else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        self.requestsArray.append(Requests.init(/*profilePic: UIImage(systemName: "person.circle")! ,*/ units: "\( document.get("number_of_units")!)", bloodType: "\(document.get("blood_type")!)", hospital: "\( document.get("hospital")!)"))
                        print("\(self.requestsArray) from array###")
                        
                    }
                    self.tableView.reloadData()
                }
        }
    }
    
    struct Requests {
        //var profilePic : UIImage
        var units : String!
        var bloodType : String!
        var hospital : String!
    }
    

}
