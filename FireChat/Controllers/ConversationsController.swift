//
//  ConversationsController.swift
//  FireChat
//
//  Created by Cesar Rook on 17/02/21.
//

import UIKit

private let reuseIdentifier = "ConversationCell"

class ConversationsController: UIViewController {
    
    
    //MARK: - Properties
    private let tableView = UITableView()
    
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
        configureNavigationBar()
        configureTableView()

        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfie))
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



