//
//  Service.swift
//  FireChat
//
//  Created by Cesar Rook on 08/03/21.
//

import Foundation
import Firebase

struct Service {
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { (snapShot, error) in
            snapShot?.documents.forEach({ (document) in
                
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                users.append(user)
                //completion(users)
            })
            
            completion(users)
        }
    }
}
