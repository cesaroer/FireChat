//
//  ConversationsController.swift
//  FireChat
//
//  Created by Cesar Rook on 17/02/21.
//

import UIKit

class ConversationsController: UIViewController {
    
    
    //MARK: - Properties
    
    
    //MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func showProfie() {
        print(123)
    }

    
    //MARK: - Helpers
    
    func configureUI() {
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Messages"
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfie))
        
    }

    
    
}
