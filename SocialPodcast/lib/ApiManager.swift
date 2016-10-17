//
//  ApiManager.swift
//  SocialPodcast
//
//  Created by Vinh Nguyen on 10/15/16.
//  Copyright © 2016 Axcoto. All rights reserved.
//

import Foundation

class ApiManager {
    var deviceId: String;
    var api: Api;
    
    init(deviceId: String) {
        self.deviceId = deviceId
        self.api = Api()
    }
    
}
