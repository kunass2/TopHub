//
//  UsersAssemblyTests.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import XCTest
@testable import TopHub

class UsersAssemblyTests: XCTestCase {
    
    func testResolveNetworkAssistant() {
        let assistant = DependencyAssistant.resolver.resolve(NetworkAssistant.self)
        
        XCTAssertNotNil(assistant)
    }
    
    func testResolveNetworkAssistantAsSingleton() {
        let first = DependencyAssistant.resolver.resolve(NetworkAssistant.self)
        let second = DependencyAssistant.resolver.resolve(NetworkAssistant.self)
        
        XCTAssertTrue(first === second)
    }
    
    func testResolveUsersViewController() {
        let controller = DependencyAssistant.resolver.resolve(UsersViewController.self)
        
        XCTAssertNotNil(controller)
        XCTAssertNotNil(controller?.presenter)
    }
    
    func testResolveUsersService() {
        let assistant = DependencyAssistant.resolver.resolve(UsersService.self)
        
        XCTAssertNotNil(assistant)
    }
    
    func testResolveFetchUsersInteractor() {
        let interactor = DependencyAssistant.resolver.resolve(FetchUsersInteractor.self)
        
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(interactor?.usersService)
    }
    
    func testResolveNumberOfRepositoriesInteractor() {
        let interactor = DependencyAssistant.resolver.resolve(NumberOfRepositoriesInteractor.self)
        
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(interactor?.usersService)
    }
    
    func testResolveUsersPresenter() {
        let presenter = DependencyAssistant.resolver.resolve(UsersPresenter.self, arguments: UsersViewController() as UsersView, UsersViewController() as UsersRouter)
        
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter?.fetchUsersInteractor)
        XCTAssertNotNil(presenter?.numberOfRepositoriesInteractor)
    }
}
