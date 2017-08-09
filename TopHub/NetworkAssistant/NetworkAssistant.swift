//
//  NetworkAssistant.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

//
//  Created by Marek Niedbach on 22.05.2017.
//  Copyright © 2017 Silvair. All rights reserved.
//

import Foundation

typealias SuccessCallback = (Any?) -> Void
typealias FailureCallback = () -> Void

protocol ApiRequestExecutor {
    func get(_ url: URL, parameters: [String: Any]?, success: @escaping SuccessCallback, failure: @escaping FailureCallback)
}

class NetworkAssistant {
    private let executor: ApiRequestExecutor
    private let baseUrl: URL
    
    //MARK: - Initialization
    
    init(baseUrl: URL, executor: ApiRequestExecutor) {
        self.baseUrl = baseUrl
        self.executor = executor
    }
    
    //MARK: - Overriden
    
    //MARK: - Actions
    
    //MARK: - Internal
    
    func get(_ path: String, parameters: [String: Any]?, success: @escaping SuccessCallback, failure: @escaping FailureCallback) {
        executor.get(url(forPath: path), parameters: parameters, success: success, failure: failure)
    }
    //MARK: - Private
    
    private func url(forPath path: String) -> URL {
        return baseUrl.appendingPathComponent(path)
    }
}

