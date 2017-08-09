//
//  RepositoriesViewController.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import UIKit

private let RepositoriesViewControllerIdentifier = "RepositoriesViewControllerIdentifier"
private let RepositoryTableViewCellIdentifier = "RepositoryTableViewCellIdentifier"

class RepositoriesViewController: UIViewController, UITableViewDataSource, RepositoriesView {
    
    @IBOutlet private var tableView: UITableView!
    
    var presenter: RepositoriesPresenter!
    
    private var repositories = [Repository]()
    
    //MARK: - Class Methods
    
    class func instantiate() -> RepositoriesViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: RepositoriesViewControllerIdentifier) as! RepositoriesViewController
    }
    
    //MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewDidLoad()
    }
    
    //MARK: - Deinitialization
    
    //MARK: - Actions
    
    //MARK: - Open
    
    //MARK: - Internal
    
    //MARK: - Private
    
    //MARK: - Overridden
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repository = repositories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCellIdentifier, for: indexPath) as! RepositoryTableViewCell
        cell.update(with: repository)
        
        if tableView.isLast(for: indexPath) {
            presenter.onLastCellDisplayed()
        }
        
        return cell
    }
    
    //MARK: - RepositoriesView
    
    func updateNavigationBar(withTitle title: String) {
        navigationItem.title = title
    }
    
    func updateWith(_ repositories: [Repository]) {
        self.repositories = repositories
        tableView.reloadData()
    }
}
