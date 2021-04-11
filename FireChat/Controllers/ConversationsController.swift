//
//  ConversationsController.swift
//  FireChat
//
//  Created by Cesar Rook on 17/02/21.
//

import UIKit
import Firebase

private let reuseIdentifier = "ConversationCell"

class ConversationsController: UIViewController {
    
    
    //MARK: - Properties
    private let tableView = UITableView()
    private var conversations = [Conversation]()
    private let newMessageBtn : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemPurple
        button.tintColor = .white
        button.imageView?.setDimensions(height: 24, width: 24)
        button.addTarget(self, action: #selector(showNewMessagecontroller), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        authenticateUser()
        fetchConversations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureNavigationBar(withTitle: "Messages", prefersLargeTitles: true)
    }
    
    
    //MARK: - Selectors
    
    @objc func showProfie() {
        //logout()
        
        let controller = ProfileController(style: .insetGrouped)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    @objc func showNewMessagecontroller() {
        let controller = NewMessageController()
        controller.delegate = self
        let navController = UINavigationController(rootViewController: controller)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
        
        //self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - API
    
    func fetchConversations() {
        Service.fetchConversations { (conversations) in
            self.conversations = conversations
            self.tableView.reloadData()
        }
    }
    
    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
        }else{
            print("DEBUG: User is logged in. usr id is \(Auth.auth().currentUser?.uid)")
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            presentLoginScreen()
        }catch {
            print("DEBUG: Error signing out ...")
        }
    }

    
    //MARK: - Helpers
    
    func presentLoginScreen() {
        DispatchQueue.main.async {
            let controller  = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        configureTableView()

        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfie))
        
        view.addSubview(newMessageBtn)
        newMessageBtn.setDimensions(height: 56, width: 56)
        newMessageBtn.layer.cornerRadius = 56 / 2
        newMessageBtn.anchor(bottom: view.bottomAnchor, right: view.rightAnchor, paddingBottom: 60, paddingRight: 24)
        
        //Image Like Snapchat
         let logo = UIImage(named: "snap")
         let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 37, height: 37))
         let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 37, height: 37))
         imageView.contentMode = .scaleAspectFit
         imageView.image = logo
         imageView.backgroundColor = .yellow
         imageView.layer.masksToBounds = true
         imageView.layer.cornerRadius = 8
         imageView.layer.borderWidth = 1
         imageView.layer.borderColor = UIColor.black.cgColor
         logoContainer.addSubview(imageView)
         navigationItem.titleView = logoContainer
    }
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView() //Para los separadores
        tableView.delegate = self
        tableView.dataSource = self
        
                           
        view.addSubview(tableView)
        tableView.frame = view.frame
        
    }
    
    func showChatController(forUser user: User) {
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }


}

//MARK: - UITableViewDataSource

extension ConversationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversationCell
        cell.conversation = conversations[indexPath.row]
        
        return cell
    }
    
    
}

//MARK: - UITableViewDelegate
extension ConversationsController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = conversations[indexPath.row].user
        showChatController(forUser: user)

    }
}

//MARK: -  NewMessageControllerDelegate
extension ConversationsController: NewMessageControllerDelegate {
    func controller(_ controller: NewMessageController, wantsToStartChatWith user: User) {
        controller.dismiss(animated: true, completion: nil)
        showChatController(forUser: user)
    }
    
}



