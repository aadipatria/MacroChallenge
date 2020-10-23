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
    
    var dummy: [SendBreath] = []
    var dummyText = "yey"
    var dummyArrayOfText =  [[String]]()
    
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
//        let message = message["Message"] as! [SendBreath]
//        dummy = message
        
//        let message = message["Message"] as! String
//        dummyText = message
        
        let message = message["Message"] as! [[String]]
        dummyArrayOfText = message
        
        setNeedsBodyUpdate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    override var body: HomeWatchView {
        var hwv = HomeWatchView()
        if !dummyArrayOfText.isEmpty {
            hwv.breath2DArray = dummyArrayOfText
        }
        
        return hwv
    }
}
