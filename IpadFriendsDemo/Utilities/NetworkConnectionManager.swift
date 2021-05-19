//
//  NetworkManager.swift
//  IpadFriendsDemo
//
//  Created by Thomas Woodfin on 5/19/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import Foundation
import Reachability
import NotificationBannerSwift


class NetworkConnectionManager: NSObject {
    
    static let shared = NetworkConnectionManager()
    
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .unavailable
    }
    var reachabilityStatus = Reachability.Connection.unavailable
    let reachability = try! Reachability()
    
    private var isDisplayingBanner = false
    
    @objc func reachabilityChanged(notification: Notification) {
//        if isDisplayingBanner {
//            return
//        } else {
//            isDisplayingBanner = true
//            DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
//                self.isDisplayingBanner = false
//            })
//        }
//        
//        let reachability = notification.object as! Reachability
//        switch reachability.connection {
//        case .none, .unavailable:
//            let banner = NotificationBanner(title: "No Internet Connection", subtitle: "swipe up to dismiss", style: .danger)
//            banner.titleLabel?.textAlignment = .center
//            banner.subtitleLabel?.textAlignment = .center
//            banner.subtitleLabel?.font = UIFont.systemFont(ofSize: 12)
//            banner.bannerHeight = 94
//            banner.duration = 8
//            banner.dismissOnSwipeUp = true
//            banner.show()
//        case .wifi:
//            let banner = StatusBarNotificationBanner(title: "Wifi Network Available", style: .success)
//            banner.duration = 3
//            banner.show()
//        case .cellular:
//            let banner = StatusBarNotificationBanner(title: "Cellular Network Available", style: .success)
//            banner.duration = 3
//            banner.show()
//        }
    }

    func startMonitoring() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged), name: Notification.Name.reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            debugPrint("Could not start reachability notifier")
        }
    }

    func stopMonitoring(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged, object: reachability)
    }
    
}
