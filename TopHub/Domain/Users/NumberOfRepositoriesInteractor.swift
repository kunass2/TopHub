//
//  NumberOfRepositoriesInteractor.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

class NumberOfRepositoriesInteractor {
    
    var usersService: UsersService!
    
    func numberOfRepositories(for user: User, completion: @escaping NumberOfRepositoriesCompletionBlock) {
        usersService.numberOfRepositoriesForUser(user, completion: completion)
    }
}
