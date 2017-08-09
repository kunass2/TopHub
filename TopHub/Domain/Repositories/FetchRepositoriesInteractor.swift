//
//  FetchRepositoriesInteractor.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

class FetchRepositoriesInteractor {
    var repositoriesService: RepositoriesService!
    
    func fetchRepositories(for user: User, page: Int = 1, completion: @escaping RepositoriesCompletionBlock) {
        repositoriesService.fetchRepositories(for: user, page: page, completion: completion)
    }
}
