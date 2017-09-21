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
        guard let reachability = self.reachability else {
            return Property(value: false)
        }
        
        let reachabilityChangeSignal = NotificationCenter.default.reactive.notifications(forName: Notification.Name.reachabilityChanged, object: self.reachability)
        
        return Property(initial: reachability.isReachableViaWiFi, then: reachabilityChangeSignal.map ({ ($0.object as! Reachability).isReachableViaWiFi }))
    }()
    
    fileprivate let reachability = Reachability()
    
    init() {
        try! reachability?.startNotifier()
    }
}
