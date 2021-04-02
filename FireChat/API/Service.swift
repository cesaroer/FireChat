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
        COLLECTION_USERS.getDocuments { (snapShot, error) in
            snapShot?.documents.forEach({ (document) in
                
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                users.append(user)
                //completion(users)
            })
            
            completion(users)
        }
    }
    static func fetchUser(with uid: String, completion: @escaping(User) -> Void) {
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else {return}
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func newFetchUserWithoutDocRef(with uid: String, completion: @escaping(User) -> Void) {
        self.fetchUsers { (users) in
            users.forEach { (user) in
                if user.uid == uid{
                    completion(user)
                    return
                }
            }
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
    

    static func fetchConversations(completion: @escaping([Conversation]) -> Void) {
        
        var conversations = [Conversation]()
        guard let uid = Auth.auth().currentUser?.uid else {return print("sin uid")}
        
        let query = COLLECTION_MESSAGES.document(uid).collection("recent-messages").order(by: "timeStamp")
        query.addSnapshotListener { (snapshot, error) in
            
            snapshot?.documentChanges.forEach({ (change) in
                let dictionary = change.document.data()
                let message = Message(dictionary: dictionary)
                
                newFetchUserWithoutDocRef(with: message.toID) { (user) in
                    let conversation = Conversation(user: user, message: message)
                    conversations.append(conversation)
                    completion(conversations)
                }
            })
        }
        
    }
    
    
    static func uploadMessage(_ message: String, to user: User, completion: ((Error?) -> Void)?) {
        
        guard let currentUUID = Auth.auth().currentUser?.uid else {return}
        let data = [
            "text" : message,
            "fromID": currentUUID,
            "toID": user.uid,
            "timeStamp" : Timestamp(date: Date())
        ] as [String : Any]
        
        COLLECTION_MESSAGES.document(currentUUID).collection(user.uid).addDocument(data: data) { (_) in
            
            COLLECTION_MESSAGES.document(user.uid).collection(currentUUID).addDocument(data: data, completion: completion)
            
            COLLECTION_MESSAGES.document(currentUUID).collection("recent-messages").document(user.uid).setData(data)
            
            COLLECTION_MESSAGES.document(user.uid).collection("recent-messages").document(currentUUID).setData(data)
        }
    }
    
    
}
