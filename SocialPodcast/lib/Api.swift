//
//  Api.swift
//  SocialPodcast
//
//  Created by Vinh Nguyen on 10/10/16.
//  Copyright © 2016 Axcoto. All rights reserved.
//

import Foundation

class Api {
    var client: Client
    
    init() {
        client = Client("public-api-token")
    }
    
    func me() {
        request('me', Request())
    }
    
    func request(path: String, request: Request) Response {
    
    }
}
