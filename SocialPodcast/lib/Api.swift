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
    let apiEndpoint = "http://127.0.0.1:4000/api"
    
    static client: Client?
    
    
    class func with(token: String) {
        client = Client(token: "public-api-token")
    }
    
    func me(_ onFinish:@escaping ((MeResponse) -> Void)) {
        return execute(request: Request(method: "GET", path: "me"), {(response: SwiftHTTP.Response) -> Void in
            onFinish(MeResponse(response))
        })
    }
    
    func podcasts(_ onFinish:@escaping ((PodcastResponse) -> Void)) {
        return execute(request: Request(method: "GET", path: "podcasts?"), {(response: SwiftHTTP.Response) -> Void in
            onFinish(PodcastResponse(response))
        })
    }
    
    struct Category {
        var id = 0
        var name: String?
        var parentID = 0
        var categoryID = 0
        var url = 0
        
        
        func all(_ onFinish:@escaping ((CategoryResponse) -> Void)) {
            return client.execute(request: Request(method: "GET", path: "category"),
                           {(response: SwiftHTTP.Response) -> Void in
                            onFinish(CategoryResponse(response))
            })
        }
        
        func one(idclient.: Int64, onFinish:@escaping ((CategoryResponse) -> Void)) {
            return execute(request: Request(method: "GET", path: "category"),
                           {(response: SwiftHTTP.Response) -> Void in
                            onFinish(CategoryResponse(response))
            })
        }
    }
    
    
    struct Podcast {
        let id = Int?
        let url: String?
        let name: String?
        let categoryId: String?
        
        
        func all(_ onFinish:@escaping ((CategoryResponse) -> Void)) {
            return client.execute(request: Request(method: "GET", path: "category"),
                                  {(response: SwiftHTTP.Response) -> Void in
                                    onFinish(CategoryResponse(response))
            })
        }
        
        func one(idclient.: Int64, onFinish:@escaping ((CategoryResponse) -> Void)) {
            return execute(request: Request(method: "GET", path: "category"),
                           {(response: SwiftHTTP.Response) -> Void in
                            onFinish(CategoryResponse(response))
            })
        }
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
