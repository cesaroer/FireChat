//
//  ProfileController.swift
//  FireChat
//
//  Created by Cesar Rook on 01/04/21.
//

import UIKit
private let profileControllerReuseID = "ProfileCell"

class ProfileController: UITableViewController {
    //MARK: - Properties
    private lazy var headerView = ProfileHeader(frame: .init(x: 0, y: 0,
                                                             width: view.frame.width,
                                                             height: 380))
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureUI()
    }
    
    //MARK: - Selectors
    
    //MARK: - API
    
    //MARK: - Helpers
    
    func configureUI() {
        tableView.backgroundColor = .white
        tableView.tableHeaderView = headerView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: profileControllerReuseID)
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .never
        
    }
}

extension ProfileController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: profileControllerReuseID, for: indexPath)
        return cell
    }
}

