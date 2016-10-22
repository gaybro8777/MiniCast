//
//  Episode.swift
//  SocialPodcast
//
//  Created by Vinh Nguyen on 10/21/16.
//  Copyright © 2016 Axcoto. All rights reserved.
//

import Foundation

struct EpisodeEnclosure {
    let url: String?
    let length: String?
}

struct Episode {
    let title: String?
    let guid: String?
    let link: String?
    let enclosure: EpisodeEnclosure?
    let author: String?
    let pubDate: String?
    let description: String?    
}
