//
//  RepositoriesAssemblyTests.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import XCTest
@testable import TopHub

class RepositoriesAssemblyTests: XCTestCase {
    
    private let user = User(login: "", avatarUrl: "", reposUrl: "", userUrl: "", userId: 1, numberofRepositories: 0)
    
    func testResolveRepositoriesViewController() {
        let controller = DependencyAssistant.resolver.resolve(RepositoriesViewController.self, argument: user)
        
        XCTAssertNotNil(controller)
        XCTAssertNotNil(controller?.presenter)
    }
    
    func testResolveRepositoriesPresenter() {
        let presenter = DependencyAssistant.resolver.resolve(RepositoriesPresenter.self, arguments: RepositoriesViewController() as RepositoriesView, user)
        
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter?.fetchRepositoriesInteractor)
    }
    
    func testResolveRepositoriesService() {
        let assistant = DependencyAssistant.resolver.resolve(RepositoriesService.self)
        
        XCTAssertNotNil(assistant)
    }
    
    func testResolveFetchRepositoriesInteractor() {
        let interactor = DependencyAssistant.resolver.resolve(FetchRepositoriesInteractor.self)
        
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(interactor?.repositoriesService)
    }
}
