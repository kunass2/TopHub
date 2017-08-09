//
//  RepositoriesPresenterTests.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import XCTest
@testable import TopHub

class RepositoriesPresenterTests: XCTestCase {
    
    private var sut: RepositoriesPresenter!
    private var fetchRepositoriesInteractor: FetchRepositoriesInteractorMock!
    private var repositoriesView: RepositoriesViewMock!
    
    private let user = User(login: "username", avatarUrl: nil, reposUrl: nil, userUrl: nil, userId: 0, numberofRepositories: 0)
    
    override func setUp() {
        super.setUp()
        
        fetchRepositoriesInteractor = FetchRepositoriesInteractorMock()
        repositoriesView = RepositoriesViewMock()
        sut = RepositoriesPresenter(view: repositoriesView, user: user)
        sut.fetchRepositoriesInteractor = fetchRepositoriesInteractor
    }
    
    func testOnViewDidLoadUpdatesNavigationBarAndFetchesTwoRepositories() {
        sut.onViewDidLoad()
        fetchRepositoriesInteractor.completion?([Repository(name: ""), Repository(name: "")])
        
        XCTAssertEqual(repositoriesView.updatedWithTitle, "username")
        XCTAssertEqual(repositoriesView.updatedWithRepositories?.count, 2)
    }
    
    func testOnViewDidLoadUpdatesNavigationBarAndFetchesNoRepositories() {
        sut.onViewDidLoad()
        fetchRepositoriesInteractor.completion?(nil)
        
        XCTAssertEqual(repositoriesView.updatedWithTitle, "username")
        XCTAssertNil(repositoriesView.updatedWithRepositories)
    }
    
    func testOnLastCellDisplayedUpdatesThreeTimesWithFiveRepositories() {
        sut.onViewDidLoad()
        sut.onLastCellDisplayed()
        fetchRepositoriesInteractor.completion?([Repository(name: ""), Repository(name: "")])
        sut.onLastCellDisplayed()
        fetchRepositoriesInteractor.completion?([Repository(name: ""), Repository(name: "")])
        sut.onLastCellDisplayed()
        fetchRepositoriesInteractor.completion?([Repository(name: "")])
        sut.onLastCellDisplayed()
        fetchRepositoriesInteractor.completion?(nil)
        sut.onLastCellDisplayed()
        
        XCTAssertEqual(repositoriesView.updatedWithRepositories?.count, 5)
        XCTAssertEqual(fetchRepositoriesInteractor?.page, 4)
    }
}

private class FetchRepositoriesInteractorMock: FetchRepositoriesInteractor {
    
    var user: User?
    var page: Int?
    var completion: RepositoriesCompletionBlock?
    
    override func fetchRepositories(for user: User, page: Int, completion: @escaping RepositoriesCompletionBlock) {
        self.user = user
        self.page = page
        self.completion = completion
    }
}

private class RepositoriesViewMock: RepositoriesView {
    
    var updatedWithTitle: String?
    var updatedWithRepositories: [Repository]? = nil
    
    func updateWith(_ repositories: [Repository]) {
        updatedWithRepositories = repositories
    }
    
    func updateNavigationBar(withTitle title: String) {
        updatedWithTitle = title
    }
}
