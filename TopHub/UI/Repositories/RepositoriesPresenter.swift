//
//  RepositoriesPresenter.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

protocol RepositoriesView {
    func updateNavigationBar(withTitle title: String)
    func updateWith(_ repositories: [Repository])
}

class RepositoriesPresenter {
    
    var fetchRepositoriesInteractor: FetchRepositoriesInteractor!
    private var view: RepositoriesView!
    private var user: User!
    
    private var possibleToFetchMore = false
    private var nextPageForRepositories = 2
    private var fetchingInProgress = false
    private var repositories = [Repository]()
    
    //MARK: - Class Methods
    
    //MARK: - Initialization
    
    init(view: RepositoriesView, user: User) {
        self.view = view
        self.user = user
    }
    
    //MARK: - Deinitialization
    
    //MARK: - Actions
    
    //MARK: - Open
    
    //MARK: - Internal
    
    func onViewDidLoad() {
        view.updateNavigationBar(withTitle: user.login)
        fetchRepositories()
    }
    
    func onLastCellDisplayed() {
        fetchMoreRepositories()
    }
    
    //MARK: - Private
    
    private func fetchRepositories() {

        fetchRepositoriesInteractor.fetchRepositories(for: user) { repositories in
            
            guard let repositories = repositories else {
                return
            }
            
            self.repositories = repositories
            self.view.updateWith(repositories)
            self.possibleToFetchMore = !repositories.isEmpty
        }
    }
    
    private func fetchMoreRepositories() {
        
        if possibleToFetchMore && !fetchingInProgress {
            
            fetchingInProgress = true
            
            fetchRepositoriesInteractor.fetchRepositories(for: user, page: nextPageForRepositories) { repositories in
                
                self.fetchingInProgress = false
                
                guard let repositories = repositories else {
                    return
                }
                
                for repository in repositories {
                    self.repositories.append(repository)
                }
                self.nextPageForRepositories = self.nextPageForRepositories + 1
                self.view.updateWith(self.repositories)
                self.possibleToFetchMore = !repositories.isEmpty
            }
        }
    }
    
    //MARK: - Overridden
}
