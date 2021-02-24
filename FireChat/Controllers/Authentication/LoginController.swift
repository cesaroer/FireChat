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
    private var viewModel = LoginViewModel()
    
    
    private let iconImage : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bubble.right")
        iv.tintColor = .white
        return iv
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
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        return button
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
    
    private let dontHaveAccountBtn : UIButton = {
        let button = UIButton(type: .system)
        let attributtedTittle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [.font: UIFont.systemFont(ofSize: 16),
                        .foregroundColor: UIColor.white])
        
        attributtedTittle.append(NSMutableAttributedString(string: "Sign Up", attributes: [
                        .font: UIFont.boldSystemFont(ofSize: 16),
                        .foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributtedTittle, for: .normal)
        
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func handleShowSignUp() {
        
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            
            viewModel.email = sender.text
        }else {
            
            viewModel.password = sender.text
        }
        
        checkFormStatus()
    }
    
    @objc func handleLogin() {
        print("DEBUG: Handle Login here ..")
    }
    
    //MARK: - Helpers
    
    func checkFormStatus() {
        if viewModel.formIsValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else{
            
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
    
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
        
        view.addSubview(dontHaveAccountBtn)
        dontHaveAccountBtn.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingBottom: 16 ,paddingRight: 32)
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    
}
