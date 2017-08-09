//
//  FetchUsersInteractor.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

class FetchUsersInteractor {
    
    var usersService: UsersService!
    
    func fetchUsersWithCompletion(completion: @escaping UsersCompletionBlock) {
        usersService.fetchUsersWithCompletionBlock(completion: completion)
    }
}
