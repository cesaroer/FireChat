//
//  ChatController.swift
//  FireChat
//
//  Created by Cesar Rook on 15/03/21.
//

import UIKit

class ChatController: UICollectionViewController {
    
    //MARK: - Properties
    private let mUser : User
    
    
    
    //MARK: - LifeCycle
    
    init(user: User) {
        self.mUser = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        print("DEBUG: User in chat controller is \(mUser.username)")
        
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        
        collectionView.backgroundColor = .white
        
        //Image Like Snapchat
        guard let url = URL(string: mUser.profileImageUrl) else { return }

         let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 44))
         let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 44))
         imageView.contentMode = .scaleAspectFill
         imageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person.fill"))
         imageView.backgroundColor = .clear
         imageView.layer.masksToBounds = true
         imageView.layer.cornerRadius = imageView.frame.height / 2
         imageView.layer.borderWidth = 1
         imageView.layer.borderColor = UIColor.black.cgColor
         logoContainer.addSubview(imageView)
         navigationItem.titleView = logoContainer
    }
}
