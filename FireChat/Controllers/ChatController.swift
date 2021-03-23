//
//  ChatController.swift
//  FireChat
//
//  Created by Cesar Rook on 15/03/21.
//

import UIKit

private let chatReuseIdentifier  = "messageCell"

class ChatController: UICollectionViewController {
    
    //MARK: - Properties
    private let mUser : User
    private var mMessages = [Message]()
    var fromCurrentUser = false

    
    internal lazy var customInputView: CustomInputAccessoryView = {
        let iv = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0,
                                                        width: view.frame.width, height: 50))
        iv.delegate = self
        return iv
    }()
    
    
    
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
        fetchMessages()
        
        print("DEBUG: User in chat controller is \(mUser.username)")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override var inputAccessoryView: UIView? {
        get {return customInputView}
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    //MARK: - API
    func fetchMessages() {
        Service.fetchMessages(froUser: mUser) { (messages) in
            
            self.mMessages = messages
            self.collectionView.reloadData()
        }
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
         navigationItem.title =  mUser.username
        
        
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: chatReuseIdentifier)
        collectionView.alwaysBounceVertical = true
    }
}


extension ChatController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mMessages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: chatReuseIdentifier, for: indexPath) as! MessageCell
        cell.message = mMessages[indexPath.row]
        cell.message?.user = mUser
        return cell
    }
    
}

extension ChatController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    
    
}

extension ChatController : CustomInputAccesoryViewDelegate {
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String) {
        
        Service.uploadMessage(message, to: mUser) { (error) in
            if let error = error {
                print("DEBUG: Failes to upload message with error \(error.localizedDescription)")
            }
            
            inputView.clearMessageText()
        }
    }
}
