//
//  BaseRouter.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.dev_name }} on 05/24/18.
//  Copyright © 2018 {{ cookiecutter.company_name }}. All rights reserved.
//

import UIKit
import Alamofire

enum BaseRouter: URLRequestConvertible {
    
    static let baseUrl = "https://jsonplaceholder.typicode.com"
    
    case getToken()
    case getPostlist()
    case getPostDetail(postId: Int)
    case sendNewPost(parameter: [String: Any])
    
    var apiPath: String {
        switch self {
        case .getPostlist:
            return "/posts"
        case .getPostDetail(let postId):
            return "/posts/\(postId)"
        case .sendNewPost:
            return "/post"
        case .getToken:
            return "/getToken"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPostlist,
             .getPostDetail,
             .getToken:
            return .get
        case .sendNewPost:
            return .post
        }
    }
    
    var headers: [String: String] {
        switch self {
        default:
            return [:]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let baseUrl = try BaseRouter.baseUrl.asURL()
        var urlRequest = URLRequest(url: baseUrl.appendingPathComponent(apiPath))
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.allHTTPHeaderFields = self.headers
        
        switch self {
        case .getPostlist,
             .getPostDetail,
             .getToken:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .sendNewPost(let param):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: param)
        default:
            break
        }
        
        return urlRequest
    }
}

