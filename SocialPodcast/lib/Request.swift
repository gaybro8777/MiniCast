//
//  Request.swift
//  SocialPodcast
//
//  Created by Vinh Nguyen on 10/10/16.
//  Copyright © 2016 Axcoto. All rights reserved.
//

import Foundation

class Request {
    var method: String = "GET"
    var path: String = "/"
    
    var query: [String:String] = [:]
    var body: [String:ValueType] = [:]
    
}
