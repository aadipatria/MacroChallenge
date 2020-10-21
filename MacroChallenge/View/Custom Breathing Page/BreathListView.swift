//
//  BreathListView.swift
//  MacroChallenge
//
//  Created by Kenji Surya Utama on 13/10/20.
//

import SwiftUI
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
    
    func sendWatchMessage(breath: [Breathing]) {
        let message = ["Message" : breath]
        WCSession.default.sendMessage(message, replyHandler: nil)
    }
    
    func sendString(breath: String) {
        let message = ["Message" : breath]
        WCSession.default.sendMessage(message, replyHandler: nil)
    }
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
}

struct BreathListView: View {
    @FetchRequest(fetchRequest: Breathing.getAllBreathing()) var breaths: FetchedResults<Breathing>
    
    let sendWatchHelper = WatchHelper()
    
    var body: some View {
        VStack{
            
            Button {
                sendWatchHelper.sendString(breath: "hello")
            } label: {
                Text("Sync With Apple Watch")
            }

            
            NavigationLink(
                destination: CustomBreathingView(),
                label: {
                    Text("Add New Breathing")
                })
                .navigationBarTitle("Breath List", displayMode: .inline)
            
            List {
                ForEach(self.breaths) { breath in
                    NavigationLink(
                        //gw bikin page baru khusus buat yg Edit breathing karna kayaknya ribet kalau modif yg Add new breathing
                        //mungkin ada cara lain? - Vincent
                        
                        //passing id (UUID) nya
                        destination: EditBreathing(id: breath.id),
                        label: {
                            Text("\(breath.name ?? "My Breath") = \(breath.inhale) inhale || \(breath.hold1) hold || \(breath.exhale) exhale || \(breath.hold2) hold || sound \(breath.sound == true ? "on" : "off") || haptic \(breath.haptic == true ? "on" : "off") || \(breath.id)")
                        })
                }
            }
        }
    }
}

struct BreathListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        BreathListView().environment(\.managedObjectContext, viewContext)
    }
}
