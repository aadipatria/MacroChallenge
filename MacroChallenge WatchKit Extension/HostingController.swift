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

class HostingController: WKHostingController<AnyView>, WCSessionDelegate {
    
    var ArrayOfBreathing =  [[String]]()
    var ArrayOfContact = [[String]]()
    
    @AppStorage("arrayOfBreathing") var arrayOfBreathing = Data()
    @AppStorage("arrayOfContact") var arrayOfContact = Data()
    
    
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
        
        let message = message["Message"] as! [[String]]
        
        print(message)
        
        let uuid = UUID(uuidString: message[0][0])
        
        if uuid == nil {
            ArrayOfBreathing = message
            arrayOfBreathing = Storage.archive(object: ArrayOfBreathing)
        }
        else {
            ArrayOfContact = message
            arrayOfContact = Storage.archive(object: ArrayOfContact)
        }
        
        setNeedsBodyUpdate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    
    override var body: AnyView {
        return AnyView(HomeWatchView()
            .environmentObject(NavigationWatchPopObject()))
    }
}
