//
//  FetchUsersInteractorTests.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import XCTest
@testable import TopHub

class FetchUsersInteractorTests: XCTestCase {
    
    private var sut: FetchUsersInteractor!
    private var service: UsersServiceStub!
    
    private let user = User(login: "", avatarUrl: nil, reposUrl: nil, userUrl: nil, userId: 0, numberofRepositories: 0)
    
    override func setUp() {
        super.setUp()
        
        service = UsersServiceStub()
        sut = FetchUsersInteractor()
        sut.usersService = service
    }
    
    func testFetchRepositoriesReturnsTwoUsers() {
        service.users = [user, user]
        
        var users: [User]?
        sut.fetchUsersWithCompletion { users = $0 }
        
        XCTAssertNotNil(users)
        XCTAssertEqual(users?.count, 2)
    }
    
    func testFetchRepositoriesReturnsNoUsers() {
        
        var users: [User]?
        sut.fetchUsersWithCompletion { users = $0 }
        
        XCTAssertNil(users)
    }
}

private class UsersServiceStub: UsersService {
    
    var users: [User]?
    
    func fetchUsersWithCompletionBlock(completion: @escaping UsersCompletionBlock) {
        completion(users)
    }
    
    func numberOfRepositoriesForUser(_ user: User, completion: @escaping NumberOfRepositoriesCompletionBlock) {}
}
