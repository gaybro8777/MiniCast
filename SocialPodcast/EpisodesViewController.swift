//
//  EpisodesViewController.swift
//  SocialPodcast
//
//  Created by Vinh Nguyen on 10/19/16.
//  Copyright © 2016 Axcoto. All rights reserved.
//

//
//  SecondViewController.swift
//  SocialPodcast
//
//  Created by Vinh Nguyen on 10/5/16.
//  Copyright © 2016 Axcoto. All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var apiManager: ApiManager?;
    var episodes: [String] = ["Taylor Otwell - Patterns for Simplifying Laravel Applications", "51: Matt Wynne - Building the Right Thing with BDD"]
    
    
    @IBOutlet var episodesTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        episodesTable.delegate = self
        episodesTable.dataSource = self
        episodesTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool){
        print(UIDevice.current.identifierForVendor!.uuidString)
        if apiManager == nil {
            apiManager = ApiManager(deviceId: UIDevice.current.identifierForVendor!.uuidString)
        }
        
        apiManager?.api.me({(response: MeResponse) -> Void in
            print(response)
        })
        
    }
    
    
    // Implementation data table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = episodesTable.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath) as UITableViewCell
        
        if let nameLabel = cell.viewWithTag(100) as? UILabel {
            nameLabel.text = episodes[indexPath.row]
        }
        
        if let countLabel = cell.viewWithTag(300) as? UILabel{
            countLabel.text = "2"
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("User select \(indexPath.row)" )
        
    }
}
