//
//  AlamofireRequestExecutorMock.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import Foundation
@testable import TopHub

class RequestExecutorMock: ApiRequestExecutor {
    var parameters = [[String: Any]]()
    var isSuccess = false
    var responses = [Any]()
    
    func get(_ url: URL, parameters: [String : Any]?, success: @escaping SuccessCallback, failure: @escaping FailureCallback) {

        if let parameters = parameters {
            self.parameters.append(parameters)
        }

        if isSuccess {
            success(!responses.isEmpty ? responses.removeFirst() : nil)
        } else {
            failure()
        }
    }
}
