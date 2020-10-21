//
//  HostingController.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Vincent Alexander Christian on 12/10/20.
//

import WatchKit
import Foundation
import SwiftUI
import WatchConnectivity

class HostingController: WKHostingController<HomeWatchView>, WCSessionDelegate {
    
    var dummy: [Breathing] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let message = message["Message"] as! [Breathing]
        dummy = message
        setNeedsBodyUpdate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    override var body: HomeWatchView {
        var hwv = HomeWatchView()
        hwv.breathName = dummy[0].name ?? "empty"
        hwv.inhale = dummy[0].inhale
        hwv.hold1 = dummy[0].inhale
        hwv.exhale = dummy[0].inhale
        hwv.hold2 = dummy[0].inhale
        hwv.sound = dummy[0].sound
        hwv.haptic = dummy[0].haptic

        return hwv
    }
}
