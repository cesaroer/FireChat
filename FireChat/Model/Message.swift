//
//  Message.swift
//  FireChat
//
//  Created by Cesar Rook on 21/03/21.
//

import Foundation
import Firebase


struct Message {
    let text   : String
    let toID   : String
    let fromID : String
    var user   : User?
    let timeStamp: Timestamp!

    
    let isFromCurrentUser : Bool
    
    init(dictionary : [String: Any]) {
        
        self.text = dictionary["text"] as? String ?? ""
        self.toID = dictionary["toID"] as? String ?? ""
        self.fromID = dictionary["fromID"] as? String ?? ""
        self.timeStamp = dictionary["timeStamp"] as? Timestamp ?? Timestamp(date: Date())
        
        self.isFromCurrentUser = fromID == Auth.auth().currentUser?.uid
        
    }
}



struct Conversation {
    let user: User
    let message: Message
}
