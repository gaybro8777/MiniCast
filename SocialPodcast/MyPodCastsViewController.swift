//
//  SecondViewController.swift
//  SocialPodcast
//
//  Created by Vinh Nguyen on 10/5/16.
//  Copyright © 2016 Axcoto. All rights reserved.
//

import UIKit

class MyPodcastsViewController: UIViewController {
    var apiManager: ApiManager?;
    
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
}

