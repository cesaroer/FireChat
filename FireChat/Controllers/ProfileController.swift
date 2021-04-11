//
//  ProfileController.swift
//  FireChat
//
//  Created by Cesar Rook on 01/04/21.
//

import UIKit
import Firebase

private let profileControllerReuseID = "ProfileCell"

protocol ProfileControllerDelegate: class {
    func handleLogout()
}

class ProfileController: UITableViewController {
    //MARK: - Properties
    private var mUser: User? {
        didSet{ headerView.user = mUser}
    }
    
    weak var delegate : ProfileControllerDelegate?
    
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
        tableView.tableFooterView = footerView
        footerView.delegate = self
        tableView.tableHeaderView = headerView
        headerView.delegate = self
        
        tableView.backgroundColor = .white
        tableView.register(ProfileCell.self, forCellReuseIdentifier: profileControllerReuseID)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = 64
        tableView.backgroundColor = .systemGroupedBackground
        
    }
}

//MARK: - UITableViewDataSource

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

//MARK: - UITableViewDelegate

extension ProfileController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = ProfileViewModel(rawValue: indexPath.row) else {return}
        print("Handle for action \(viewModel.description)")
        
        switch viewModel {
        case .accountInfo:
            print("DEBUG: Show account info page")
        case .setting:
            print("DEBUG: Show setting page")
        case .savedMessages:
            print("DEBUG: Show savedMessages page")
        }
    }
    
}

//MARK: - ProfileHeaderDelegate

extension ProfileController: ProfileHeaderDelegate {
    func dismissController() {
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - ProfileFooterDelegate

extension ProfileController: ProfileFooterDelegate {
    func handleLogout() {
        let alert = UIAlertController(title: nil, message: "Are you sure you want to logout", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { _ in
            self.dismiss(animated: true) {
                self.delegate?.handleLogout()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)        
    }
    
    
}


