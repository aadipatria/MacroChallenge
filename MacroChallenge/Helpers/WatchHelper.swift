//
//  WatchHelper.swift
//  MacroChallenge
//
//  Created by Vincent Alexander Christian on 23/10/20.
//

import Foundation
import WatchConnectivity

class WatchHelper: NSObject, WCSessionDelegate {
    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func sendArrayOfString(breath: [[String]]) {
        let message = ["Message" : breath]
        WCSession.default.sendMessage(message, replyHandler: nil)
    }
    
    func sendArrayOfContact(contact: [[String]]) {
        let message = ["Contact" : contact]
        WCSession.default.sendMessage(message, replyHandler: nil)
    }
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
}
