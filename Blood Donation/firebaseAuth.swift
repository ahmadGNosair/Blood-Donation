//
//  firebaseAuth.swift
//  Blood Donation
//
//  Created by HTU on 8/10/22.
//  Copyright © 2022 HTU. All rights reserved.
//

import UIKit
import FirebaseAuth

class firebaseAuth{

    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
}
