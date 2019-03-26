//
//  RefreshRequest.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.dev_name }} on 05/24/18.
//  Copyright © 2018 {{ cookiecutter.company_name }}. All rights reserved.
//

import UIKit
import Alamofire

class RefreshRequest: RequestAdapter, RequestRetrier {
    private typealias RefreshCompletion = (_ succeeded: Bool) -> Void
    private var accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        let token = "Bearer \(self.accessToken)"
        urlRequest.setValue(token, forHTTPHeaderField: "access-token")
        return urlRequest
    }
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            refreshToken(completion: { (successed) in
                completion(successed, 0.0)
            })
        } else {
            completion(false, 0.0)
        }
    }
    
    private func refreshToken(completion: @escaping RefreshCompletion) {
        Alamofire.request(BaseRouter.getToken()).responseJSON { (response) in
            self.accessToken = "yyyyyy"
            completion(true)
        }
    }
    
}
