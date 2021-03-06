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
    }
    
    
    //MARK: - Selectors
    
    @objc func showProfie() {
        logout()
    }
    
    @objc func showNewMessagecontroller() {
        let controller = NewMessageController()
//        let navController = UINavigationController(rootViewController: controller)
//        navController.modalPresentationStyle = .fullScreen
//        present(navController, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - API
    
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
        configureNavigationBar()
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView() //Para los separadores
        tableView.delegate = self
        tableView.dataSource = self
        
                           
        view.addSubview(tableView)
        tableView.frame = view.frame
        
    }
    
    func configureNavigationBar() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .systemPurple
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance //when make scroll up
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Messages"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent =  true
        
        // Con esto ya funciona pero no se pone en blanco desde un inicio
        navigationController!.navigationBar.overrideUserInterfaceStyle = .dark
        //Con esto ya se pone en blanco desde un inicio pero deben ir las dos lineas de Code
        navigationController?.navigationBar.barStyle = .black
    }

}

extension ConversationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = "Im the cell # \(indexPath.row)"
        return cell
    }
    
    
}

extension ConversationsController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}



