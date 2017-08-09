//
//  UsersViewController.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import UIKit

private let UsersViewControllerIdentifier = "UsersViewControllerIdentifier"
private let UserTableViewCellIdentifier = "UserTableViewCellIdentifier"

class UsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UsersView, UsersRouter {
    
    @IBOutlet private var tableView: UITableView!
    
    private var users = [User]()
    
    var presenter: UsersPresenter!
    
    //MARK: - Class Methods
    
    class func instantiate() -> UsersViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: UsersViewControllerIdentifier) as! UsersViewController
    }
    
    //MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewDidLoad()
    }
    
    //MARK: - Deinitialization
    
    //MARK: - Actions
    
    @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
        presenter.onRefreshButtonTapped()
    }
    
    //MARK: - Open
    
    //MARK: - Internal
    
    //MARK: - Private
    
    //MARK: - Overridden
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCellIdentifier, for: indexPath) as! UserTableViewCell
        cell.update(with: user)
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onDidSelectRow(at: indexPath)
    }
    
    //MARK: - UsersView
    
    func presentUsers(users: [User]) {
        self.users = users
        tableView.reloadData()
    }
    
    func updateUser(_ user: User) {
        guard let index = users.index(of: user) else {
            return
        }
        
        users[index].numberofRepositories = user.numberofRepositories
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
    }
    
    //MARK: - UsersRouter
    
    func openRepositories(for user: User) {
        let controller = DependencyAssistant.resolver.resolve(RepositoriesViewController.self, argument: user)!
        navigationController?.pushViewController(controller, animated: true)
    }
}
