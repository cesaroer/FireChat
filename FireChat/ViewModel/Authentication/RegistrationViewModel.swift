//
//  RegistrationViewModel.swift
//  FireChat
//
//  Created by Cesar Rook on 23/02/21.
//

import Foundation

protocol AuthenticationProtocol {
    var formIsValid: Bool {get}
}

public struct RegistrationViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
            && fullname?.isEmpty == false
            && username?.isEmpty == false
    }
    
    
}



