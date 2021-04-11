//
//  ProfileController.swift
//  FireChat
//
//  Created by Cesar Rook on 01/04/21.
//

import UIKit
import Firebase

private let profileControllerReuseID = "ProfileCell"

class ProfileController: UITableViewController {
    //MARK: - Properties
    private var mUser: User? {
        didSet{ headerView.user = mUser}
    }
    private lazy var headerView = ProfileHeader(frame: .init(x: 0, y: 0,
                                                             width: view.frame.width,
                                                             height: 380))
    private lazy var footerView = ProfileFooterView(frame:
                                                        CGRect(x: 0, y: 0, width: view.frame.width, height: 120))
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureUI()
        fetchUser()
    }
    
    //MARK: - Selectors
    
    //MARK: - API
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else{return}        
        Service.newFetchUserWithoutDocRef(with: uid) { (user) in
            self.mUser = user
            print("DEBUG: User is \(user.username)")
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        tableView.backgroundColor = .white
        tableView.tableFooterView = footerView
        tableView.tableHeaderView = headerView
        headerView.delegate = self
        tableView.register(ProfileCell.self, forCellReuseIdentifier: profileControllerReuseID)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = 64
        tableView.backgroundColor = .systemGroupedBackground
        
    }
}

extension ProfileController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileViewModel.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: profileControllerReuseID, for: indexPath) as! ProfileCell
        let viewModel = ProfileViewModel(rawValue: indexPath.row)
        cell.viewModel = viewModel
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension ProfileController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

extension ProfileController: ProfileHeaderDelegate {
    func dismissController() {
        dismiss(animated: true, completion: nil)
    }
    
}

