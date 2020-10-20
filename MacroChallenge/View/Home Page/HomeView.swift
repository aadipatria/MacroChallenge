//
//  ContentView.swift
//  MacroChallenge
//
//  Created by Vincent Alexander Christian on 12/10/20.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var navPop : NavigationPopObject
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Navigation")
                    .padding()
                NavigationLink(
                    destination: BreathListView(),
                    label: {
                        Text("Breath List")
                    })
                    .padding()
                
                Group {
                    Button(action: {
                        navPop.toHome = true
                    }, label: {
                        Text("Breath View")
                            .padding()
                    })
                    NavigationLink(
                        destination: BreathView(),
                        isActive: $navPop.toHome, label: {
                            EmptyView()
                    })
                }
                NavigationLink(
                    destination: EmergencyView(),
                    label: {
                        Text("Emergency")
                    })
                    .padding()
            }
            .navigationBarTitle("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        HomeView().environment(\.managedObjectContext, viewContext).environmentObject(NavigationPopObject())
    }
}
