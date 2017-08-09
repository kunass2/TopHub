//
//  RepositoriesService.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

typealias RepositoriesCompletionBlock = (([Repository]?) -> Void)

protocol RepositoriesService {
    func fetchRepositories(for user: User, page: Int, completion: @escaping RepositoriesCompletionBlock)
}
