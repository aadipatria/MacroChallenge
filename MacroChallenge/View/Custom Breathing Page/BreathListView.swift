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
    @EnvironmentObject var navPop : NavigationPopObject
    
    let sendWatchHelper = WatchHelper()
    
    @State var breathing2DArray = [[String]]()
    @State var edit : Bool = false
    
//    init() {
//        UITableView.appearance().tableFooterView = UIView()
//        UITableView.appearance().separatorStyle = .none
//        UITableView.appearance().separatorColor = .clear
//        UITableViewCell.appearance().backgroundColor = UIColor(Color.clear)
//        UITableView.appearance().backgroundColor = UIColor(Color.clear)
//      }
    
    var body: some View {
        
        VStack(spacing : 0){
            HStack {
                Text("Breathing Library")
                    .font(Font.custom("Poppins-Bold", size: 24, relativeTo: .body))
                    .foregroundColor(.white)
                Spacer()
                ZStack {
                    SomeBackground.plusBackground()
                    NavigationLink(
                        destination: CustomBreathingView(),
                        isActive : $navPop.addBreath,
                        label: {
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                        })
                    
                }
            }
            .frame(width : ScreenSize.windowWidth() * 0.9, height : ScreenSize.windowHeight() * 0.05)
//            .padding()
//            .padding(10)
            .padding(.vertical)
//            Button {
//                sync()
//            } label: {
//                Text("Sync With Apple Watch")
//            }

            
            if !breaths.isEmpty{
                ForEach(self.breaths) { breath in
                    NavigationLink(
                        //gw bikin page baru khusus buat yg Edit breathing karna kayaknya ribet kalau modif yg Add new breathing
                        //mungkin ada cara lain? - Vincent
                        
                        //passing id (UUID) nya
                        destination: EditBreathing(id: breath.id),
//                        isActive : $navPop.editBreath,
                        label: {
                            HStack{
                                VStack(alignment : .leading, spacing : 4){
                                    Text(breath.name ?? "")
                                        .font(Font.custom("Poppins-SemiBold", size: 16, relativeTo: .body))
                                        .foregroundColor(.black)
                                    Text("\(breath.inhale) - \(breath.hold1) - \(breath.exhale) - \(breath.hold2)")
                                        .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .body))
                                        .foregroundColor(.black)
                                }.padding()
                                Spacer()
                                Button(action: {
                                    breath.favorite.toggle()
                                    do{
                                        try self.manageObjectContext.save()
                                    } catch {
                                        print(error)
                                    }
                                }, label: {
                                    if breath.favorite{
                                        Image(systemName: "heart.fill")
                                            .foregroundColor(.black)
                                            .font(.system(size: 20))
                                            .padding()
                                    }else{
                                        Image(systemName: "heart")
                                            .foregroundColor(.black)
                                            .font(.system(size: 20))
                                            .padding()
                                    }
                                })
                                
                            }
                            .padding()
                            .frame(width: ScreenSize.windowWidth() * 0.9, height: ScreenSize.windowHeight() * 0.1)
                            .background(Rectangle()
                                            .fill(Color.clear)
                                            .background(Blur(style: .systemThinMaterial)
                                                            .opacity(0.95))
                                            .cornerRadius(8))
                        })
                }
                .padding(.bottom, 20)
                .animation(.easeInOut(duration: 0.6))
                
            }
            else{
                Text("You have no breath pattern. Tap on the “+” button to add a new one.")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width : ScreenSize.windowWidth() * 0.5)
                    .padding()
            }
            
            Spacer()
            
        }
//        .background(Image("ocean").backgroundImageModifier())
        .onAppear(perform: {
            sync()
        })
        
    }
}

extension BreathListView {
    func sync() {
        breathing2DArray.removeAll()
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
        BreathListView().environment(\.managedObjectContext, viewContext).environmentObject(NavigationPopObject())
    }
}
