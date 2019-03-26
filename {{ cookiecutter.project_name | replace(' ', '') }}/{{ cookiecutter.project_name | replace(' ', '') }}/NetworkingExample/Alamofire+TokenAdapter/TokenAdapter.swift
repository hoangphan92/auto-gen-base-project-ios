//
//  TokenAdapter.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.dev_name }} on 05/24/18.
//  Copyright © 2018 {{ cookiecutter.company_name }}. All rights reserved.
//

import UIKit
import Alamofire

class TokenAdapter: RequestAdapter {
    private let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        let token = "Bearer \(self.accessToken)"
        urlRequest.setValue(token, forHTTPHeaderField: "access-token")
        return urlRequest
    }
}
