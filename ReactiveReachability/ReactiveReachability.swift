//
//  Reachability.swift
//  Master Caster
//
//  Created by Miles Hollingsworth on 9/3/15.
//  Copyright © 2015 Miles Hollingsworth. All rights reserved.
//

import ReactiveCocoa
import enum Result.NoError
import AFNetworking.AFNetworkReachabilityManager

public class Reachability {
    public static let sharedReachability = Reachability()
    
    private let reachabilitySignal: SignalProducer<NSNotification, NoError>
    public let isReachableViaWifi: AnyProperty<Bool>
    
    init() {
        reachabilitySignal = NSNotificationCenter.defaultCenter().rac_notifications(AFNetworkingReachabilityDidChangeNotification, object: nil)
        isReachableViaWifi = AnyProperty(initialValue: true,
            producer: reachabilitySignal.map {($0.userInfo![AFNetworkingReachabilityNotificationStatusItem as NSString] as! NSNumber).integerValue == AFNetworkReachabilityStatus.ReachableViaWiFi.rawValue})
        
        AFNetworkReachabilityManager.sharedManager().startMonitoring()
    }
}
