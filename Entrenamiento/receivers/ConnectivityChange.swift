//
//  ConnectivityChange.swift
//  Smart Catalog iOS App
//
//  Created by Jesus Sarco on 9/17/18.
//  Copyright © 2018 Smart Builders C.A. All rights reserved.
//

import Foundation
import UIKit

class ConnectivityChange {
    
    static let sharedInstance = ConnectivityChange()
    private var reachability : Reachability!
    private var backgroundTaskID: UIBackgroundTaskIdentifier?
    
    func observeReachability(){
        self.reachability = Reachability()
        NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        do {
            try self.reachability.startNotifier()
        } catch(let error) {
            print("Error occured while starting reachability notifications : \(error.localizedDescription)")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        if (reachability.connection == .cellular || reachability.connection == .wifi) {
            Utils.reloadImagesNotDownloaded()
        }
    }
}
