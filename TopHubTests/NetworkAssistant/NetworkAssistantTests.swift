//
//  NetworkAssistantTests.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import XCTest
@testable import TopHub

class NetworkAssistantTests: XCTestCase {
    
    private var sut: NetworkAssistant!
    private var requestExecutor: RequestExecutorMock!
    
    override func setUp() {
        super.setUp()
        
        requestExecutor = RequestExecutorMock()
        sut = NetworkAssistant(baseUrl: URL(string: "http://test.com")!, executor: requestExecutor)
    }
    
    func testGetWithSuccessCallback() {
        requestExecutor.isSuccess = true
        
        var isSuccess = false
        sut.get("", parameters: [:], success: { _ in isSuccess = true }, failure: { _ in })
        
        XCTAssertTrue(isSuccess)
    }
    
    func testGetWithFailureCallback() {
        requestExecutor.isSuccess = false
        
        var isFailure = false
        sut.get("", parameters: [:], success: { _ in }, failure: { _ in isFailure = true })
        
        XCTAssertTrue(isFailure)
    }
}
