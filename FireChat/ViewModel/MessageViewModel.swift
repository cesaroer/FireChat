//
//  MessageViewModel.swift
//  FireChat
//
//  Created by Cesar Rook on 21/03/21.
//

import UIKit

struct MessageViewModel {
    
    private let message : Message
    var messageBackgroundColor: UIColor {
        return message.isFromCurrentUser ?
            #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) :
            .systemPurple
    }
    
    var messageTextColor : UIColor {
        return message.isFromCurrentUser ?
            .black :
            .white
    }
    
    init(message: Message) {
        self.message = message
    }
    
    
    
    
}



