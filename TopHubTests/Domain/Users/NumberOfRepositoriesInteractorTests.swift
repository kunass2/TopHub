//
//  NumberOfRepositoriesInteractorTests.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import XCTest
@testable import TopHub

class NumberOfRepositoriesInteractorTests: XCTestCase {
    
    private var sut: NumberOfRepositoriesInteractor!
    private var service: UsersServiceStub!
    
    private let user = User(login: "", avatarUrl: nil, reposUrl: nil, userUrl: nil, userId: 0, numberofRepositories: 0)
    
    override func setUp() {
        super.setUp()
        
        service = UsersServiceStub()
        sut = NumberOfRepositoriesInteractor()
        sut.usersService = service
    }
    
    func testnumberOfRepositoriesReturnsTwo() {
        service.numberOfRepositories = 2
        
        var numberOfRepositories: Int?
        sut.numberOfRepositories(for: user) { numberOfRepositories = $0 }
        
        XCTAssertNotNil(numberOfRepositories)
        XCTAssertEqual(numberOfRepositories, 2)
    }
    
    func testnumberOfRepositoriesReturnsNil() {
        var numberOfRepositories: Int?
        sut.numberOfRepositories(for: user) { numberOfRepositories = $0 }
        
        XCTAssertNil(numberOfRepositories)
    }
}

private class UsersServiceStub: UsersService {
    
    var numberOfRepositories: Int?
    
    func fetchUsersWithCompletionBlock(completion: @escaping UsersCompletionBlock) {}
    
    func numberOfRepositoriesForUser(_ user: User, completion: @escaping NumberOfRepositoriesCompletionBlock) {
        completion(numberOfRepositories)
    }
}
