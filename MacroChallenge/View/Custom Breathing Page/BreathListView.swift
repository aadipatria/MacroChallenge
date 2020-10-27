//
//  BreathListView.swift
//  MacroChallenge
//
//  Created by Kenji Surya Utama on 13/10/20.
//

import SwiftUI
import WatchConnectivity



struct BreathListView: View {
    @FetchRequest(fetchRequest: Breathing.getAllBreathing()) var breaths: FetchedResults<Breathing>
    @Environment(\.managedObjectContext) var manageObjectContext
    
    let sendWatchHelper = WatchHelper()
    
    @State var breathing2DArray = [[String]]()
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().separatorColor = .clear
        UITableViewCell.appearance().backgroundColor = UIColor(Color.clear)
        UITableView.appearance().backgroundColor = UIColor(Color.clear)
      }
    
    var body: some View {
        
        VStack{
            HStack {
                Text("Breathing Library")
                Spacer()
                ZStack {
                    ScreenSize.plusBackground()
                    Image(systemName: "plus")
                }
            }.frame(width : ScreenSize.windowWidth() * 0.9)
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
            
            List {
                ForEach(self.breaths) { breath in
                    NavigationLink(
                        //gw bikin page baru khusus buat yg Edit breathing karna kayaknya ribet kalau modif yg Add new breathing
                        //mungkin ada cara lain? - Vincent
                        
                        //passing id (UUID) nya
                        destination: EditBreathing(id: breath.id),
                        label: {
//                            Text("\(breath.name ?? "My Breath") = \(breath.inhale) inhale || \(breath.hold1) hold || \(breath.exhale) exhale || \(breath.hold2) hold || sound \(breath.sound == true ? "on" : "off") || haptic \(breath.haptic == true ? "on" : "off") || \(breath.id)")
                            HStack{
                                VStack{
                                    Text(breath.name ?? "")
                                    Text("\(breath.inhale)-\(breath.hold1)-\(breath.exhale)-\(breath.hold2)")
                                }
                                Image(systemName: "heart")
                            }
                        })
                }
                .onDelete(perform: { indexSet in
                    deleteItem(indexSet: indexSet)
                })
            }
//            .environment(\.defaultMinListRowHeight, 100)
            .listStyle(SidebarListStyle())
            
        }
        .background(Image("ocean").backgroundImageModifier())
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
            breathingArray.append(String(breath.favorite))
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
