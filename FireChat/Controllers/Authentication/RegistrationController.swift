//
//  RegistrationController.swift
//  FireChat
//
//  Created by Cesar Rook on 18/02/21.
//

import Foundation
import UIKit

class RegistrationController: UIViewController  {
    
    // MARK: - Properties
    private let plusPhotoButton : UIButton = {
        let button =  UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "add-512"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView : InputContainerView = {
        //image literal makes a square to select an image
        return InputContainerView(image: UIImage(systemName: "envelope"),
                                  textField: emailTextField)
    }()
    
    private lazy var passwordContainerView : UIView = {
        return InputContainerView(image: UIImage(systemName: "lock"),
                                  textField: passwordTextField)
    }()
    
    private lazy var fullNameContainerView : InputContainerView = {
        //image literal makes a square to select an image
        return InputContainerView(image: UIImage(systemName: "person"),
                                  textField: fullNameTextField)
    }()
    
    private lazy var userNameContainerView : UIView = {
        return InputContainerView(image: UIImage(systemName: "person"),
                                  textField: userNameTextField)
    }()
    
    
    private let emailTextField : CustomTextField = {
        let textField = CustomTextField(placeHolder: "Email")
        textField.keyboardType = .emailAddress
        return textField
     }()
    
    private let passwordTextField : CustomTextField = {
       let textField = CustomTextField(placeHolder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let fullNameTextField : CustomTextField = {
        let textField = CustomTextField(placeHolder: "Full Name")
        textField.keyboardType = .emailAddress
        return textField
     }()
    
    private let userNameTextField : CustomTextField = {
        let textField = CustomTextField(placeHolder: "User Name")
        textField.keyboardType = .emailAddress
        return textField
     }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
        
        return button
    }()
    
    private let alreadyHaveAccountBtn : UIButton = {
        let button = UIButton(type: .system)
        let attributtedTittle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [.font: UIFont.systemFont(ofSize: 16),
                        .foregroundColor: UIColor.white])
        
        attributtedTittle.append(NSMutableAttributedString(string: "Log in", attributes: [
                        .font: UIFont.boldSystemFont(ofSize: 16),
                        .foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributtedTittle, for: .normal)
        
        button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Selectors
    @objc func handleSelectPhoto() {
        print("Select photo here")
    }
    
    @objc func handleShowLogIn() {
        navigationController?.popViewController(animated: true)
    }
    

    //MARK: - Helpers
    
    func configureUI() {
        
        configureGradientLayer()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 32)
        plusPhotoButton.setDimensions(height: 200, width: 200)
        
        let stack = UIStackView(arrangedSubviews: [
                                    emailContainerView,
                                    passwordContainerView, fullNameContainerView , userNameContainerView,
                                    signUpButton
                                ])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right:  view.rightAnchor,
                        paddingTop: 32,
                        paddingLeft: 32,
                        paddingRight: 32
                    )
        
        view.addSubview(alreadyHaveAccountBtn)
        alreadyHaveAccountBtn.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingBottom: 16 ,paddingRight: 32)
    }
    
}
