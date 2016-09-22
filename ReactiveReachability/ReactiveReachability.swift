//
//  Reachability.swift
//  Master Caster
//
//  Created by Miles Hollingsworth on 9/3/15.
//  Copyright © 2015 Miles Hollingsworth. All rights reserved.
//

import ReactiveSwift
import enum Result.NoError
import Reachability

open class ReactiveReachability {
    open static let sharedReachability = ReactiveReachability()
    
    open lazy var isReachableViaWiFi: Property<Bool> = {
        let reachabilityChangeSignal = NotificationCenter.default.rac_notifications(forName: ReachabilityChangedNotification, object: self.reachability)
        
        return Property(initial: self.reachability.isReachableViaWiFi, then: reachabilityChangeSignal.map ({ ($0.object as! Reachability).isReachableViaWiFi }))
    }()
    
    fileprivate let reachability = Reachability()!
    
    init() {
        try! reachability.startNotifier()
    }
}
