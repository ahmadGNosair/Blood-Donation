//
//  MyRequests.swift
//  
//
//  Created by HTU on 9/8/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class MyRequests: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    var requestsArray = [Requests]()
  
    @IBOutlet weak var tableView: UITableView!
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           print("\(requestsArray.count) numberofrows")
           return requestsArray.count
           
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "myRequestsCell", for: indexPath) as! MyRequestsCell
           
           let mydata = requestsArray[indexPath.row]
          /* cell.profilePicture?.image = UIImage(systemName: "person.circle")
           cell.numberOfUnits?.text = "\(mydata.units ?? "") Units"
           cell.bloodType?.text = mydata.bloodType
           cell.hospital?.text = mydata.hospital
           cell.patientName?.text = mydata.name*/
       cell.fillCell(profilePic: mydata.profilePic, unitsNo: mydata.units, hospital: mydata.hospital, bloodtype: mydata.bloodType, Name: mydata.name)
            print("+++++++")
           return cell
           
       }
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 180
       }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "my requests"
    }
  


       override func viewDidLoad() {
           super.viewDidLoad()
           
          //self.tableView.register(MyRequestsCell.self, forCellReuseIdentifier: "myRequestsCell")
           tableView.delegate = self
           tableView.dataSource = self
           loadData()
       
           
       }
       
    
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let action = UIContextualAction(style: .destructive, title: "delete"){
                [weak self] (action, view, completionHandler) in
                self?.deleteRequest(documentid: "")
                completionHandler(true)
            }
             
            
            action.backgroundColor = .systemRed
            action.image = UIImage.init(systemName: "trash")
            return UISwipeActionsConfiguration(actions: [action])
        }
    func deleteRequest(documentid:String) {
        let db = Firestore.firestore()
        db.collection("requests").document("\(documentid)").delete()
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "edit"){
            [weak self] (action, view, completionHandler) in
            completionHandler(true)
        
        }
        action.backgroundColor = .systemGray
        action.image = UIImage.init(systemName: "pencil")
        redirectToEdit()
        return UISwipeActionsConfiguration(actions: [action])

    }
   
  
    
       func loadData()  {
           let db = Firestore.firestore()
        let id = Auth.auth().currentUser?.uid
        db.collection("requests").whereField("applicant_uid", isEqualTo: "\(id!)").getDocuments() { (querySnapshot, err) in
                   if let err = err {
                       print("Error getting from firestore: \(err)")
                       
                   }else {
                       for document in querySnapshot!.documents {
                           print("\(document.documentID) => \(document.data())")
                        self.requestsArray.append(Requests.init(profilePic: UIImage(systemName: "person.circle")! , units: "\( document.get("number_of_units")!)", bloodType: "\(document.get("blood_type")!)", hospital: "\( document.get("hospital")!)", name: "\(document.get("patient_name")!)" ))
                           print("      877877    \(self.requestsArray) from arrrrrrrray###           ")
                           
                       }
                       self.tableView.reloadData()
                    print("reload")
                   }
           }
       }
    func redirectToEdit()
    {
        let editRequest = storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.editRequest) as? EditRequest
                 
                 view.window?.rootViewController = editRequest
                 view.window?.makeKeyAndVisible()
        
    }
    
       
       struct Requests {
           var profilePic : UIImage!
           var units : String!
           var bloodType : String!
           var hospital : String!
            var name : String!
           
       }
       

}
