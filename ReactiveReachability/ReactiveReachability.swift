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
    
    public lazy var isReachableViaWiFi: AnyProperty<Bool> = {
        let reachabilityChangeSignal = NSNotificationCenter.defaultCenter().rac_notifications(ReachabilityChangedNotification, object: self.reachability)
        
        return AnyProperty(initialValue: self.reachability.isReachableViaWiFi(), producer: reachabilityChangeSignal.map ({ ($0.object as! Reachability).isReachableViaWiFi() }))
    }()
    
    private let reachability = try! Reachability.reachabilityForLocalWiFi()
}
