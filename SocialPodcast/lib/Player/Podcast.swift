//
//  Podcast.swift
//  SocialPodcast
//
//  Created by Vinh Nguyen on 10/21/16.
//  Copyright © 2016 Axcoto. All rights reserved.
//

import Foundation

struct Podcast {
    let title: String?
    let description: String?
    let pubDate: String?
    let lastBuildDate: String?
    let link: String?
    let image: String?
    
    init(title: String? = nil, description: String? = nil, pubDate: String? = nil, lastBuildDate: String? = nil, link: String? = nil, image: String? = nil) {
        self.title = title
        self.description = description
        self.pubDate = pubDate
        self.lastBuildDate = lastBuildDate
        self.link = link
        self.image = image
    }
}
