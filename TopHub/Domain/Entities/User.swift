//
//  User.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

struct User {
    var login: String
    var avatarUrl: String?
    var reposUrl: String?
    var userUrl: String?
    var userId: Int
    var numberofRepositories = 0
}

extension User: Equatable {}
func == (lhs: User, rhs: User) -> Bool {
    return lhs.login == rhs.login
}
