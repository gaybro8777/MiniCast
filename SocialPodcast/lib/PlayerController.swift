//
//  Player.swift
//  SocialPodcast
//
//  Created by Vinh Nguyen on 10/21/16.
//  Copyright © 2016 Axcoto. All rights reserved.
//

import Foundation
import Jukebox
import UIKit

// Currently we will support play only a single song
// However in future we will support play list
// TODO: support playlist
class PlayerController: UIView, JukeboxDelegate {
    let titleLbl: UILabel = UILabel()
    let controlBtn: UIButton = UIButton()
    
    let jukebox: Jukebox? = Jukebox()
    var status: String = "ready"
    var lastItem: Episode? = nil
    
    init() {
        // configure jukebox
        super.init(frame: CGRect(x: 0, y: 400, width: 400, height: 100))
        self.addPlayerView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addPlayerView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addPlayerView() {
        titleLbl.frame = CGRect(x: 0, y:0, width: 50, height: 20)
        titleLbl.backgroundColor = UIColor.white
        titleLbl.textAlignment = NSTextAlignment.center
        titleLbl.text = "Init"
        self.addSubview(titleLbl)
        
        controlBtn.frame=CGRect(x: 60, y:10, width: 30, height: 10)
        controlBtn.backgroundColor=UIColor.red
        
        controlBtn.setTitle("Play", for: UIControlState.normal)
        
        controlBtn.addTarget(self, action: #selector(play), for: UIControlEvents.touchUpInside)
        self.addSubview(controlBtn)
        
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    
    
    func enqueueEpisode(_ episode: Episode) {
        if episode.enclosure?.url != nil {
            let url = NSURL(string: (episode.enclosure?.url)!) as! URL
            print("Play url", url)
            
            if lastItem != nil && lastItem?.enclosure != nil {
                self.jukebox?.stop()
                self.jukebox?.removeItems(withURL: NSURL(string: (lastItem?.enclosure?.url)!) as! URL)
            }
            
            self.jukebox?.append(
                item: JukeboxItem(URL: url),
                loadingAssets: false
            )
            self.lastItem = episode
        }
        
        if self.status == "playing" {
            self.stop()
            
        }
        
        self.play()
    }
    
    func play() {
        status = "playing"
        titleLbl.text = lastItem?.title
        controlBtn.setTitle("Pause", for: UIControlState.normal)
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
