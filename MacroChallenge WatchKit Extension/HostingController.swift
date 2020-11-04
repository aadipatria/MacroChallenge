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
        
        let uuid = UUID(uuidString: message[0][0])
        
        if uuid == nil {
            ArrayOfBreathing = message
            UserDefaults.standard.setValue(ArrayOfBreathing, forKey: "arrayOfBreathing")
        }
        else {
            ArrayOfContact = message
            UserDefaults.standard.setValue(ArrayOfContact, forKey: "arrayOfContact")
        }
        
        setNeedsBodyUpdate()
        updateBodyIfNeeded()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    
    override var body: AnyView {
//        let hwv = HomeWatchView()
//        if !ArrayOfBreathing.isEmpty {
//            hwv.breath2DArray = ArrayOfBreathing
//        }
//
//        if !ArrayOfContact.isEmpty {
//            hwv.contact2DArray = ArrayOfContact
//        }
        
        return AnyView(HomeWatchView().environmentObject(DataObserver()))
    }
}
