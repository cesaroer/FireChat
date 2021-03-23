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
    
    
    static func fetchMessages(froUser user: User, completion: @escaping([Message]) -> Void) {
        
        var messages = [Message]()
        guard let currentUUID = Auth.auth().currentUser?.uid else {return}
        
        let query = COLLECTION_MESSAGES.document(currentUUID).collection(user.uid).order(by: "timeStamp")
        query.addSnapshotListener { (snapShot, error) in
            
            // This help us to make the real time chat
            snapShot?.documentChanges.forEach({ (change) in
                
                //Aqui decimos que cachamos todo lo que su cambio es de tipo added, o sea lo que se acaba de añadir al documento
                if change.type == .added {
                    let dictionary = change.document.data()
                    
                    messages.append(Message(dictionary: dictionary))
                    completion(messages)
                }
            })
        }

    }
    
    
    static func uploadMessage(_ message: String, to user: User, completion: ((Error?) -> Void)?) {
        
        guard let currentUUID = Auth.auth().currentUser?.uid else {return}
        let data = [
                    "text" : message,
                    "fromID": currentUUID,
                    "ToID": user.uid,
                    "timeStamp" : Timestamp(date: Date())
                    ] as [String : Any]
        
        COLLECTION_MESSAGES.document(currentUUID).collection(user.uid).addDocument(data: data) { (_) in
            
            COLLECTION_MESSAGES.document(user.uid).collection(currentUUID).addDocument(data: data, completion: completion)
        }
    }
    
    
}
