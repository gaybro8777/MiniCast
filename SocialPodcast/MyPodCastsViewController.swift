//
//  SecondViewController.swift
//  SocialPodcast
//
//  Created by Vinh Nguyen on 10/5/16.
//  Copyright © 2016 Axcoto. All rights reserved.
//

import UIKit

class MyPodcastsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var apiManager: ApiManager?;
    var podcasts: [String] = ["Ruby Rogue", "Go time"]

    
    @IBOutlet var podcastsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = podcastsTable.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        cell.textLabel?.text = podcasts[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("User select \(indexPath.row)" )
    }
}
