//
//  RepositoriesNetworkAssistant.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

extension NetworkAssistant: RepositoriesService {
    
    func fetchRepositories(for user: User, page: Int, completion: @escaping RepositoriesCompletionBlock) {
        
        get("user/\(user.userId)/repos", parameters: ["page": page], success: { response in
            completion(self.repositories(from: response))
        }, failure: {
            completion(nil)
        })
    }
    
    //MARK: - Class Methods
    
    //MARK: - Initialization
    
    //MARK: - Deinitialization
    
    //MARK: - Actions
    
    //MARK: - Open
    
    //MARK: - Internal
    
    //MARK: - Private
    
    private func repositories(from response: Any?) -> [Repository] {
        var repositories = [Repository]()
        
        if let dictionaries = response as? [[String: Any]] {
            for dictionary in dictionaries {
                let name = dictionary["name"] as? String ?? ""
                repositories.append(Repository(name: name))
            }
        }
        return repositories
    }
}
