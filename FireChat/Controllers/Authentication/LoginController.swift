//
//  LoginController.swift
//  FireChat
//
//  Created by Cesar Rook on 18/02/21.
//

import Foundation
import UIKit

class LoginController: UIViewController  {
    
    // MARK: - Properties
    private let iconImage : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bubble.right")
        iv.tintColor = .white
        return iv
    }()
    
    private let emailContainerView : UIView = {
       let containerView = UIView()
        containerView.backgroundColor = .cyan
        containerView.setHeight(height: 50)
        return containerView
    }()
    
    private let passwordContainerView : UIView = {
       let containerView = UIView()
        containerView.setHeight(height: 50)
        containerView.backgroundColor = .yellow
        return containerView
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemRed
        button.setHeight(height: 50)
        
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        configureGradientLayer()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 32)
        iconImage.setDimensions(height: 120, width: 120)
        
        let stack = UIStackView(arrangedSubviews: [
                                    emailContainerView,
                                    passwordContainerView,
                                    loginButton
                                ])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right:  view.rightAnchor,
                        paddingTop: 32,
                        paddingLeft: 32,
                        paddingRight: 32
                    )
    }
    
    func configureGradientLayer() {
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0,1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }

    
}
