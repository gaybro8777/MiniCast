//
//  ContainerService.swift
//  SocialPodcast
//
//  Created by Vinh Nguyen on 10/21/16.
//  Copyright © 2016 Axcoto. All rights reserved.
//

import Foundation
import UIKit


// Credit: http://krakendev.io/blog/the-right-way-to-write-a-singleton
class ContainerService🍼 {
    static let sharedApiManager = ApiManager(deviceId: UIDevice.current.identifierForVendor!.uuidString)
    
    static let player = PlayerController()
    static let localStorage = LocalStorage()
}
