//
//  Player.swift
//  SocialPodcast
//
//  Created by Vinh Nguyen on 10/21/16.
//  Copyright © 2016 Axcoto. All rights reserved.
//

import Foundation
import Jukebox

// Currently we will support play only a single song
// However in future we will support play list
// TODO: support playlist
class Player: JukeboxDelegate {
    let jukebox: Jukebox?
    var status: String?
    
    init() {
        // configure jukebox
        self.jukebox = Jukebox()
        self.status = "ready"
    }
    
    
    func enqueueEpisode(_ episode: Episode) {
        if episode.enclosure?.url != nil {
            self.jukebox?.stop()
            self.jukebox?.removeItems(withURL: NSURL(string: (episode.enclosure?.url)!) as! URL)
            
            self.jukebox?.append(
                item: JukeboxItem(URL: NSURL(string: (episode.enclosure?.url)!) as! URL),
                loadingAssets: true
            )
        }
        
        if self.status == "playing" {
            self.stop()
            
        }
        
        self.playNext()
    }
    
    func play() {
        status = "playing"
        self.jukebox?.play(atIndex: 0)
    }
    
    func playNext() {
        status = "playing"
        self.jukebox?.playNext()
    }
    
    func next() {
        
    }
    
    func back() {
        
    }
    
    func stop() {
        self.jukebox?.stop()
        status = "stop"
    }
    
    // Jukebox event
    func jukeboxStateDidChange(_ state : Jukebox) {
        
    }
    func jukeboxPlaybackProgressDidChange(_ jukebox : Jukebox) {
        
    }
    func jukeboxDidLoadItem(_ jukebox : Jukebox, item : JukeboxItem) {
        
    }
    func jukeboxDidUpdateMetadata(_ jukebox : Jukebox, forItem: JukeboxItem) {
        
    }
}
