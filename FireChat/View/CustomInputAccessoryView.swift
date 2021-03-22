//
//  CustomInputAccessoryView.swift
//  FireChat
//
//  Created by Cesar Rook on 20/03/21.
//

import UIKit

protocol CustomInputAccesoryViewDelegate: class {
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String)
}


public class CustomInputAccessoryView: UIView {
    
    //MARK: - Properties
    weak var delegate: CustomInputAccesoryViewDelegate?
    
    public lazy var messageInputTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        return tv
    }()
    
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(.systemPurple, for: .normal)
        button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        return button
    }()
    
    
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter message"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autoresizingMask = .flexibleHeight
        backgroundColor = .white
        
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: -8)
        layer.shadowColor = UIColor.lightGray.cgColor
        
        addSubview(sendButton)
        sendButton.anchor(top:topAnchor,right: rightAnchor, paddingTop: 4,paddingRight: 8)
        sendButton.setDimensions(height: 50, width: 50)
        
        
        addSubview(messageInputTextView)
        messageInputTextView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor,
                                    right: sendButton.leftAnchor, paddingTop: 20, paddingLeft: 4,
                                    paddingBottom: 8, paddingRight: 8)
        
        addSubview(placeHolderLabel)
        placeHolderLabel.anchor(left: messageInputTextView.leftAnchor, paddingLeft: 4)
        placeHolderLabel.centerY(inView: messageInputTextView)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInoutChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    public override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    
    //MARK: - Selectors
    
    @objc func handleSendMessage() {
        guard let message = messageInputTextView.text else {return}
        
        delegate?.inputView(self, wantsToSend: message)
        print("Handle Send message here")
    }
    
    
    @objc func handleTextInoutChange() {
        placeHolderLabel.isHidden = !self.messageInputTextView.text.isEmpty
    }
    
}



