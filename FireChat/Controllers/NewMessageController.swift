//
//  NewMessageController.swift
//  FireChat
//
//  Created by Cesar Rook on 06/03/21.
//

import Foundation
import UIKit

private let newMessagesReuseID = "UserCell"

class NewMessageController: UITableViewController {
    
    //MARK: - Properties
    

    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
    }
    
    //MARK: - Selectors
    @objc func handleDissmisal() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - API
    func fetchUsers() {
        Service.fetchUsers()
    }

    //MARK: - Properties
    func configureUI() {
        configureNavigationBar(withTitle: "New Messages", prefersLargeTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDissmisal))
        
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: newMessagesReuseID)
        tableView.rowHeight = 80
    }

}

extension NewMessageController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: newMessagesReuseID, for: indexPath) as! UserCell
        return cell
    }
}
