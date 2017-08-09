//
//  AlamofireRequestExecutor.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import Alamofire

class AlamofireRequestExecutor: ApiRequestExecutor {
    
    //MARK: - Initialization
    
    //MARK: - ApiRequestExecutor
    
    func get(_ url: URL, parameters: [String: Any]?, success: @escaping SuccessCallback, failure: @escaping FailureCallback) {
        Alamofire.request(url, method: .get, parameters: parameters, headers: nil).responseJSON { response in
            
            print("GET URL: \(String(describing: response.request?.url))")
            print("GET RESPONSE: \(String(describing: response))")
            
            if response.result.isSuccess {
                success(response.result.value)
            } else {
                failure()
            }
        }
    }
    
    //MARK: - Overriden
    
    //MARK: - Actions
    
    //MARK: - Internal
    
    //MARK: - Private
}
