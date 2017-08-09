//
//  UsersPresenterTests.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import XCTest
@testable import TopHub

class UsersPresenterTests: XCTestCase {
    
    private var sut: UsersPresenter!
    private var fetchUsersInteractor: FetchUsersInteractorStub!
    private var numberOfRepositoriesInteractor: NumberOfRepositoriesInteractorStub!
    private var usersView: UsersViewMock!
    private var usersRouter: UsersRouterMock!
    
    private let user = User(login: "username", avatarUrl: nil, reposUrl: nil, userUrl: nil, userId: 0, numberofRepositories: 0)
    
    override func setUp() {
        super.setUp()
        
        usersView = UsersViewMock()
        usersRouter = UsersRouterMock()
        fetchUsersInteractor = FetchUsersInteractorStub()
        numberOfRepositoriesInteractor = NumberOfRepositoriesInteractorStub()
        
        sut = UsersPresenter(view: usersView, router: usersRouter)
        sut.fetchUsersInteractor = fetchUsersInteractor
        sut.numberOfRepositoriesInteractor = numberOfRepositoriesInteractor
    }
    
    func testOnDidSelectRowOpenRepositoriesCalled() {
        fetchUsersInteractor.users = [user, user]
        
        sut.onViewDidLoad()
        sut.onDidSelectRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(usersRouter.openRepositoriesCalled)
    }
    
    func testOnDidSelectRowOpenRepositoriesNotCalled() {
        sut.onViewDidLoad()
        sut.onDidSelectRow(at: IndexPath(row: 0, section: 2))
        
        XCTAssertFalse(usersRouter.openRepositoriesCalled)
    }
    
    func testOnRefreshButtonTappedPresentUsersCalledAndUpdateUserCalledForEveryUser() {
        fetchUsersInteractor.users = [user, user]
        
        sut.onRefreshButtonTapped()
        
        XCTAssertEqual(usersView.presentedUsers?.count, 2)
        XCTAssertEqual(usersView.numberOfCallsForUpdatedUser, 2)
    }
    
    func testOnRefreshButtonTappedPresentUsersNotCalled() {
        sut.onViewDidLoad()
        sut.onRefreshButtonTapped()
        
        XCTAssertNil(usersView.presentedUsers)
    }
}

private class UsersViewMock: UsersView {
    
    var presentedUsers: [User]?
    var numberOfCallsForUpdatedUser = 0
    
    func presentUsers(users: [User]) {
        presentedUsers = users
    }
    
    func updateUser(_ user: User) {
        numberOfCallsForUpdatedUser = numberOfCallsForUpdatedUser + 1
    }
}

private class UsersRouterMock: UsersRouter {
    
    var openRepositoriesCalled = false
    
    func openRepositories(for user: User) {
        openRepositoriesCalled = true
    }
}

private class FetchUsersInteractorStub: FetchUsersInteractor {
    
    var users: [User]?
    
    override func fetchUsersWithCompletion(completion: @escaping UsersCompletionBlock) {
        completion(users)
    }
}

private class NumberOfRepositoriesInteractorStub: NumberOfRepositoriesInteractor {
    override func numberOfRepositories(for user: User, completion: @escaping NumberOfRepositoriesCompletionBlock) {
        completion(0)
    }
}
