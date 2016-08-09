//
//  ViewController.swift
//  Sample App
//
//  Created by Miles Hollingsworth on 8/9/16.
//  Copyright © 2016 Miles Hollingsworth. All rights reserved.
//

import UIKit
import ReactiveReachability

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ReactiveReachability.sharedReachability.isReachableViaWifiProducer.startWithNext { (isReachableViaWifi) in
            self.imageView.tintColor = isReachableViaWifi ? UIColor.greenColor() : UIColor.redColor()
            print("WIFI: \(isReachableViaWifi)")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

