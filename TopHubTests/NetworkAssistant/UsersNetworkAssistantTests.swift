//
//  UsersNetworkAssistantTests.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import XCTest
@testable import TopHub

class UsersNetworkAssistantTests: XCTestCase {
    
    private var sut: NetworkAssistant!
    private var requestExecutor: RequestExecutorMock!
    private let user = User(login: "", avatarUrl: nil, reposUrl: nil, userUrl: nil, userId: 1, numberofRepositories: 0)
    
    override func setUp() {
        super.setUp()
        
        requestExecutor = RequestExecutorMock()
        sut = NetworkAssistant(baseUrl: URL(string: "http://test.com")!, executor: requestExecutor)
    }
    
    func testFetchUsersWithSuccessReturnsTwoUsers() {
        requestExecutor.isSuccess = true
        requestExecutor.responses = [[[:], [:]]]
        
        var users: [User]?
        sut.fetchUsersWithCompletionBlock { users = $0 }
        
        XCTAssertNotNil(users)
        XCTAssertEqual(users?.count, 2)
    }
    
    func testFetchUsersWithFailureReturnsNoUsers() {
        requestExecutor.isSuccess = false
        
        var users: [User]?
        sut.fetchUsersWithCompletionBlock { users = $0 }
        
        XCTAssertNil(users)
    }
    
    func testNumberOfRepositoriesForUserWithSuccessReturnsEleven() {
        requestExecutor.isSuccess = true
        requestExecutor.responses = [["public_repos": 10]]
        
        var numberOfRepositories: Int?
        sut.numberOfRepositoriesForUser(user) { numberOfRepositories = $0 }
        
        XCTAssertNotNil(numberOfRepositories)
        XCTAssertEqual(numberOfRepositories, 10)
    }
    
    func testNumberOfRepositoriesForUserWithFailure() {
        requestExecutor.isSuccess = false
        
        var numberOfRepositories: Int?
        sut.numberOfRepositoriesForUser(user) { numberOfRepositories = $0 }
        
        XCTAssertNil(numberOfRepositories)
    }
}
