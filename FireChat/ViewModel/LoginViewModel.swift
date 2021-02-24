//
//  LoginViewModel.swift
//  FireChat
//
//  Created by Cesar Rook on 23/02/21.
//

import Foundation

struct LoginViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
    }
    
    
}
