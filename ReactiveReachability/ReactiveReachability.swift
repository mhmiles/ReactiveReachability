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
    public static let sharedReachability = ReactiveReachability()
    
    public private(set) lazy var isReachableViaWiFi: Property<Bool> = {
        guard let reachability = self.reachability else {
            return Property(value: false)
        }
        
        let reachabilityChangeSignal = NotificationCenter.default.reactive.notifications(forName: .reachabilityChanged, object: nil)
        
        return Property(initial: reachability.connection == .wifi, then: reachabilityChangeSignal.map ({ ($0.object as! Reachability).connection == .wifi}))
    }()
    
    private let reachability = Reachability()
    
    init() {
      do {
        try reachability?.startNotifier()
      } catch let error {
        print(error)
      }
    }
}
