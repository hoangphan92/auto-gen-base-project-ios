//
//  ViewController.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.dev_name }} on 05/24/18.
//  Copyright © 2018 {{ cookiecutter.company_name }}. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    // class variables
    private let sessionManager: SessionManager = SessionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchPostList()
    }
    
    func fetchPostList() {
        let refreshRetrier = RefreshRequest(accessToken: "xxxx")
        sessionManager.adapter = refreshRetrier
        sessionManager.retrier = refreshRetrier

        Alamofire.request(BaseRouter.getPostlist()).responseJSON { (response) in
            print(response)
        }
        
        sessionManager.request(BaseRouter.getPostlist()).responseJSON { (response) in
            print(response)
        }
    }
 
}

