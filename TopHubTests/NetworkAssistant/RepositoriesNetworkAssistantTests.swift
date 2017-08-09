//
//  RepositoriesNetworkAssistantTests.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import XCTest
@testable import TopHub

class RepositoriesNetworkAssistantTests: XCTestCase {
    
    private var sut: NetworkAssistant!
    private var requestExecutor: RequestExecutorMock!
    private let user = User(login: "", avatarUrl: nil, reposUrl: nil, userUrl: nil, userId: 1, numberofRepositories: 0)
    
    override func setUp() {
        super.setUp()
        
        requestExecutor = RequestExecutorMock()
        sut = NetworkAssistant(baseUrl: URL(string: "http://test.com")!, executor: requestExecutor)
    }
    
    func testFetchRepositoriesWithSuccessReturnsTwoRepositories() {
        requestExecutor.isSuccess = true
        requestExecutor.responses = [[[:], [:]]]
        
        var repositories: [Repository]?
        sut.fetchRepositories(for: user, page: 1) { repositories = $0 }
        
        XCTAssertNotNil(repositories)
        XCTAssertEqual(repositories?.count, 2)
    }
    
    func testFetchRepositoriesWithFailure() {
        requestExecutor.isSuccess = false
        
        var repositories: [Repository]?
        sut.fetchRepositories(for: user, page: 1) { repositories = $0 }
        
        XCTAssertNil(repositories)
    }
}
