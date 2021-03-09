//
//  UserCell.swift
//  FireChat
//
//  Created by Cesar Rook on 08/03/21.
//

import UIKit

class UserCell: UITableViewCell {
    
    //MARK: - Properties
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPurple
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let userNameLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "userName"
       return label
    }()
    
    private let fullNameLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "fullName"
       return label
    }()
    
    //MARK: - LifeCycle
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor,paddingLeft: 12)
        profileImageView.setDimensions(height: 64, width: 64)
        profileImageView.layer.cornerRadius = 32
        
        
        let stack = UIStackView(arrangedSubviews: [userNameLabel, fullNameLabel])
        stack.axis = .vertical
        stack.spacing = 2
        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor,paddingLeft: 12)        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
