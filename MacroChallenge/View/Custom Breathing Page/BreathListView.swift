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
    
    func sendWatchMessage(breath: [SendBreath]) {
        let message = ["Message" : breath]
        WCSession.default.sendMessage(message, replyHandler: nil)
    }
    
    func sendString(breath: String) {
        let message = ["Message" : breath]
        WCSession.default.sendMessage(message, replyHandler: nil)
    }
    
    func sendArrayOfString(breath: [[String]]) {
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
    @Environment(\.managedObjectContext) var manageObjectContext
    
    let sendWatchHelper = WatchHelper()
    
//    @State var breathingArray: [SendBreath] = []
    
    @State var breathing2DArray = [[String]]()
    
    var body: some View {
        VStack{
            Button {
                sync()
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
                .onDelete(perform: { indexSet in
                    deleteItem(indexSet: indexSet)
                })
            }
        }
    }
}

extension BreathListView {
    func sync() {
        for breath in self.breaths {
            var breathingArray = [String]()
            breathingArray.append(breath.name!)
            breathingArray.append(String(breath.inhale))
            breathingArray.append(String(breath.hold1))
            breathingArray.append(String(breath.exhale))
            breathingArray.append(String(breath.hold2))
            breathingArray.append(String(breath.sound))
            breathingArray.append(String(breath.haptic))
            breathingArray.append(breath.id.uuidString)
            breathing2DArray.append(breathingArray)
        }
        
        sendWatchHelper.sendArrayOfString(breath: breathing2DArray)
    }
    
    func deleteItem(indexSet: IndexSet) {
        let deleteItem = self.breaths[indexSet.first!]
        self.manageObjectContext.delete(deleteItem)
        
        do {
            try self.manageObjectContext.save()
        } catch {
            print("error deleting")
        }
    }
}

struct BreathListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        BreathListView().environment(\.managedObjectContext, viewContext)
    }
}
