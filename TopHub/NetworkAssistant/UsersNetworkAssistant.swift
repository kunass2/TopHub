//
//  UsersNetworkAssistant.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

extension NetworkAssistant: UsersService {
    
    func fetchUsersWithCompletionBlock(completion: @escaping UsersCompletionBlock) {
        get("users", parameters: nil, success: { response in
            completion(self.users(from: response))
        }, failure: {
            completion(nil)
        })
    }
    
    func numberOfRepositoriesForUser(_ user: User, completion: @escaping NumberOfRepositoriesCompletionBlock) {
        get("users/\(user.login)", parameters: nil, success: { response in
            completion(self.numberOfRepositories(from: response))
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
    
    private func users(from response: Any?) -> [User] {
        var users = [User]()
        
        if let dictionaries = response as? [[String: Any]] {
            for dictionary in dictionaries {
                
                let login = dictionary["login"] as? String ?? ""
                let avatarUrl = dictionary["avatar_url"] as? String
                let reposUrl = dictionary["repos_url"] as? String
                let userUrl = dictionary["url"] as? String
                let userId = dictionary["id"] as? Int ?? 1
                
                users.append(User(login: login, avatarUrl: avatarUrl, reposUrl: reposUrl, userUrl: userUrl, userId: userId, numberofRepositories: 0))
            }
        }
        return users
    }
    
    private func numberOfRepositories(from response: Any?) -> Int {
        return (response as? [String: Any])?["public_repos"] as? Int ?? 0
    }
}
