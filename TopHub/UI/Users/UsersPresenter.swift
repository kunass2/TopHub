//
//  UsersPresenter.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import Foundation

protocol UsersView {
    func presentUsers(users: [User])
    func updateUser(_ user: User)
}

protocol UsersRouter {
    func openRepositories(for user: User)
}

class UsersPresenter {
    
    var view: UsersView!
    var router: UsersRouter!
    var fetchUsersInteractor: FetchUsersInteractor!
    var numberOfRepositoriesInteractor: NumberOfRepositoriesInteractor!
    
    private var users: [User]?
    
    //MARK: - Class Methods
    
    //MARK: - Initialization
    
    init(view: UsersView, router: UsersRouter) {
        self.view = view
        self.router = router
    }
    
    //MARK: - Deinitialization
    
    //MARK: - Actions
    
    //MARK: - Open
    
    //MARK: - Internal
    
    func onViewDidLoad() {
        fetchUsers()
    }
    
    func onDidSelectRow(at indexPath: IndexPath) {
        guard let user = users?[indexPath.row] else {
            return
        }
        
        router.openRepositories(for: user)
    }
    
    func onRefreshButtonTapped() {
        fetchUsers()
    }
    
    //MARK: - Private
    
    private func fetchUsers() {
        fetchUsersInteractor.fetchUsersWithCompletion { users in
            
            guard let users = users else {
                return
            }
            
            self.users = users
            self.view.presentUsers(users: users)
            
            for var user in users {
                self.numberOfRepositoriesInteractor.numberOfRepositories(for: user) { numberOfRepositories in
                    user.numberofRepositories = numberOfRepositories ?? 0
                    self.view.updateUser(user)
                }
            }
        }
    }
    
    //MARK: - Overridden
}
