//
//  AuthService.swift
//  FireChat
//
//  Created by Cesar Rook on 05/03/21.
//

import Foundation
import Firebase

struct RegistrationCredentials {
    let email: String
    let password: String
    let fullname: String
    let username :String
    let profileImageVariable: UIImage
}

struct AuthService  {
    static let shared = AuthService()
    
    func logUserIn(email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        
    }
    
    func createUser(credentials: RegistrationCredentials, completion: ((Error?) -> Void)?) {
        guard let imageData = credentials.profileImageVariable.jpegData(compressionQuality: 0.3) else {return}
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        
        ref.putData(imageData, metadata: nil) { (meta, error) in
            if let error = error {
                completion!(error)
                return
            }
            
            ref.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else {return}
                
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                    if let error = error {
                        completion!(error)
                        return
                    }
                    
                    guard let uuid = result?.user.uid else {return}
                    
                    let data  = [
                        "email" : credentials.email,
                        "fullname" : credentials.fullname,
                        "profileImageUrl" : profileImageUrl,
                        "uid" : uuid,
                        "username" : credentials.username
                    ] as [String : Any]
                    
                    Firestore.firestore().collection("users").document().setData(data, completion: completion)
                    
                }
            }
        }
    }
}
