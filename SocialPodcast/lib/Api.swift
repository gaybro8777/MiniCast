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
        client = Client(token: "public-api-token")
    }
    
    func me()-> Response {
        return execute(request: Request())
    }
    
    func podcasts()-> Response {
        return PodcastsResponse(self.execute(request: Request())
    }
    
    
    
    func execute(request: Request)-> Response {
        // self.client.execute()
        return Response()
    }
}
