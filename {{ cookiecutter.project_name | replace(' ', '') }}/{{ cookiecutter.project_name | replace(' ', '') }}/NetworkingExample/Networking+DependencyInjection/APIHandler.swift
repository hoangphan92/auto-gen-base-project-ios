//
//  APIHandler.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.dev_name }} on 05/24/18.
//  Copyright © 2018 {{ cookiecutter.company_name }}. All rights reserved.
//

import UIKit
import Alamofire

protocol IPostHandler {
    func getPostList(withCompletion success: (([String: Any]?)->())?, orError failure: ((Error?) -> ())?)
}

class APIHandler: IPostHandler {

    let sessionManager = SessionManager()
    
    func getPostList(withCompletion success: (([String: Any]?)->())?, orError failure: ((Error?) -> ())?) {
        self.sessionManager.request(BaseRouter.getPostlist()).responseJSON { (response) in
            switch response.result {
            case .success(let jsonReturned):
                
                if let convertedJson = jsonReturned as? [String:Any]{
                    success?(convertedJson)
                    return
                }else{
                    success?(nil)
                    return
                }
                
            case .failure(let error):
                failure?(error)
                break
                
            }
        }
    }
}
