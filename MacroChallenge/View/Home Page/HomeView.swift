//
//  ContentView.swift
//  MacroChallenge
//
//  Created by Vincent Alexander Christian on 12/10/20.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var navPop : NavigationPopObject
    @State var page = 1
    
    var body: some View {
        NavigationView{
//            VStack {
//                Text("Navigation")
//                    .padding()
//                NavigationLink(
//                    destination: BreathListView(),
//                    label: {
//                        Text("Breath List")
//                    })
//                    .padding()
//
//                Group {
//                    Button(action: {
//                        navPop.toHome = true
//                    }, label: {
//                        Text("Breath View")
//                            .padding()
//                    })
//                    NavigationLink(
//                        destination: BreathView(),
//                        isActive: $navPop.toHome, label: {
//                            EmptyView()
//                    })
//                }
//                NavigationLink(
//                    destination: EmergencyView(),
//                    label: {
//                        Text("Emergency")
//                    })
//                    .padding()
//            }
            VStack {
                if page == 0 || navPop.toEmergency {
                    EmergencyView()
                }else if page == 1{
                    BreathView()
                }else if page == 2{
                    BreathListView()
                }
                Spacer()
                HStack {
                    Button(action: {
                        navPop.toEmergency = false
                        page = 0
                    }, label: {
                        Text("Call")
                    }).padding()
                    Button(action: {
                        navPop.toEmergency = false
                        page = 1
                    }, label: {
                        Text("Home")
                    }).padding()
                    Button(action: {
                        navPop.toEmergency = false
                        page = 2
                    }, label: {
                        Text("Custom")
                    }).padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        HomeView().environment(\.managedObjectContext, viewContext).environmentObject(NavigationPopObject())
    }
}
