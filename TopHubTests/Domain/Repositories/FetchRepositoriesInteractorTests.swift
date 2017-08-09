//
//  FetchRepositoriesInteractorTests.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import XCTest
@testable import TopHub

class FetchRepositoriesInteractorTests: XCTestCase {
    
    private var sut: FetchRepositoriesInteractor!
    private var service: RepositoriesServiceStub!
    
    private let user = User(login: "", avatarUrl: nil, reposUrl: nil, userUrl: nil, userId: 0, numberofRepositories: 0)
    
    override func setUp() {
        super.setUp()
        
        service = RepositoriesServiceStub()
        sut = FetchRepositoriesInteractor()
        sut.repositoriesService = service
    }
    
    func testFetchRepositoriesReturnsTwoRepositories() {
        service.repositories = [Repository(name: ""), Repository(name: "")]
        
        var repositories: [Repository]?
        sut.fetchRepositories(for: user) { repositories = $0 }
        
        XCTAssertNotNil(repositories)
        XCTAssertEqual(repositories?.count, 2)
    }
    
    func testFetchRepositoriesReturnsNoRepositories() {
        var repositories: [Repository]?
        sut.fetchRepositories(for: user) { repositories = $0 }
        
        XCTAssertNil(repositories)
    }
}

private class RepositoriesServiceStub: RepositoriesService {
    
    var repositories: [Repository]?
    
    func fetchRepositories(for user: User, page: Int, completion: @escaping RepositoriesCompletionBlock) {
        completion(repositories)
    }
}
