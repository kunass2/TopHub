//
//  UsersService.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

typealias UsersCompletionBlock = (([User]?) -> Void)
typealias NumberOfRepositoriesCompletionBlock = ((Int?) -> Void)

protocol UsersService {
    func fetchUsersWithCompletionBlock(completion: @escaping UsersCompletionBlock)
    func numberOfRepositoriesForUser(_ user: User, completion: @escaping NumberOfRepositoriesCompletionBlock)
}
