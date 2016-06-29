//
//  Reachability.swift
//  Master Caster
//
//  Created by Miles Hollingsworth on 9/3/15.
//  Copyright © 2015 Miles Hollingsworth. All rights reserved.
//

import ReactiveCocoa
import enum Result.NoError
import Reachability

public class ReactiveReachability {
    public static let sharedReachability = ReactiveReachability()
    
    public let isReachableViaWifi: AnyProperty<Bool>
    
    init() {
        let reachability = try! Reachability.reachabilityForLocalWiFi()
        
        let reachabilityChangeSignal = NSNotificationCenter.defaultCenter().rac_notifications(ReachabilityChangedNotification, object: reachability)
        
        isReachableViaWifi = AnyProperty(initialValue: true,
                                         producer: reachabilityChangeSignal.map ({ ($0.object as! Reachability).isReachableViaWiFi() }))
        
        try! reachability.startNotifier()
    }
}
