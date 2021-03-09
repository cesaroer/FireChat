//
//  Service.swift
//  FireChat
//
//  Created by Cesar Rook on 08/03/21.
//

import Foundation
import Firebase

struct Service {
    
    static func fetchUsers() {
        
        Firestore.firestore().collection("users").getDocuments { (snapShot, error) in
            snapShot?.documents.forEach({ (document) in
                print(document.data())
            })
        }
    }
}
