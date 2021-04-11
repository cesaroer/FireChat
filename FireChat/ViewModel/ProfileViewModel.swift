//
//  ProfileViewModel.swift
//  FireChat
//
//  Created by Cesar Rook on 10/04/21.
//

import UIKit

enum ProfileViewModel: Int, CaseIterable {
    case accountInfo
    case setting
    
    var description: String {
        switch self {
            case .accountInfo: return "Account Info"
            case .setting: return "Setting"
        }
    }
    
    var iconImageName : String {
        switch self {
            case .accountInfo: return "person.circle"
            case .setting: return "gear"
        }
    }
    
    
    
}

