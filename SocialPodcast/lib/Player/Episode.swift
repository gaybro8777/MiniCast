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
    let length: Int
}

struct Episode {
    let title: String?
    let guid: String?
    let link: String?
    let enclosure: EpisodeEnclosure?
    let author: String?
    let pubDate: String?
    let description: String?
    
    init(title: String, guid: String? = nil, link: String? = nil, enclosure: EpisodeEnclosure? = nil, author: String? = nil, pubDate: String? = nil, description: String? = nil) {
        self.title = title
        self.guid = guid
        self.link = link
        self.enclosure = enclosure
        self.author = author
        self.pubDate = pubDate
        self.description = description
    }
}
