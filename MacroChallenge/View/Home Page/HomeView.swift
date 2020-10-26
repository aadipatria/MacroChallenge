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
            ZStack {
                if page == 0 || navPop.toEmergency {
                    EmergencyView()
                }
                else if page == 1{
                    BreathView()
                }
                else if page == 2{
                    BreathListView()
                }
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            navPop.toEmergency = false
                            page = 0
                        }, label: {
                            VStack {
                                Image("water").imageIconModifier()
                                Text("Contact")
                            }
                        }).padding()
                        Button(action: {
                            navPop.toEmergency = false
                            page = 1
                        }, label: {
                            VStack {
                                Image("wind").imageIconModifier()
                                Text("Breath")
                            }
                        }).padding()
                        Button(action: {
                            navPop.toEmergency = false
                            page = 2
                        }, label: {
                            VStack {
                                Image("earth").imageIconModifier()
                                Text("Collection")
                            }
                        }).padding()
                    }
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
