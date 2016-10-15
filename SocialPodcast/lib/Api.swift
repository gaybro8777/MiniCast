//
//  Api.swift
//  SocialPodcast
//
//  Created by Vinh Nguyen on 10/10/16.
//  Copyright © 2016 Axcoto. All rights reserved.
//

import Foundation
import SwiftHTTP

class Api {
    var client: Client
    
    init() {
        client = Client(token: "public-api-token")
    }
    
    func me(_ onFinish:@escaping ((MeResponse) -> Void)) {
        return execute(request: Request(method: "GET", path: "me"), {(response: SwiftHTTP.Response) -> Void in
            onFinish(MeResponse(response))
        })
    }
    
    func execute(request: Request, _ onFinish:@escaping ((SwiftHTTP.Response) -> Void)) {
        // self.client.execute()
        do {
            let opt = try HTTP.GET("https://google.com")
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                //print("data is: \(response.data)") access the response of the data with response.data
                onFinish(response)
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }
}
