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
    
    public lazy var isReachableViaWifiProducer: SignalProducer<Bool, NoError> = {
        let reachabilityChangeSignal = NSNotificationCenter.defaultCenter().rac_notifications(ReachabilityChangedNotification, object: self.reachability)
        try! self.reachability.startNotifier()
        
        return SignalProducer<Bool, NoError> { observer, disposable in
            observer.sendNext(self.reachability.isReachableViaWiFi())
            disposable += reachabilityChangeSignal.map ({ ($0.object as! Reachability).isReachableViaWiFi() }).start(observer)
        }
    }()
    
    private let reachability = try! Reachability.reachabilityForLocalWiFi()
}
