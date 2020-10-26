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
                    ZStack {
                        Color(UIColor.white)
                            .frame(width : ScreenSize.windowWidth(), height : ScreenSize.windowHeight() * 0.127)
                            .opacity(0.12)
                        HStack {
                            Button(action: {
                                navPop.toEmergency = false
                                page = 0
                            }, label: {
                                VStack {
                                    if page == 0{
                                        Image("water").imageIconModifier()
                                        Text("Contact").foregroundColor(.white)
                                    }else{
                                        Image("water_gray").imageIconModifier()
                                        Text("Contact").foregroundColor(.gray)
                                    }
                                    
                                }
                            }).padding()
                            Spacer()
                            Button(action: {
                                navPop.toEmergency = false
                                page = 1
                            }, label: {
                                VStack {
                                    if page == 1{
                                        Image("wind").imageIconModifier()
                                        Text("Breath").foregroundColor(.white)
                                    }else{
                                        Image("wind_gray").imageIconModifier()
                                        Text("Breath").foregroundColor(.gray)
                                    }
                                }
                            }).padding()
                            Spacer()
                            Button(action: {
                                navPop.toEmergency = false
                                page = 2
                            }, label: {
                                VStack {
                                    if page == 2{
                                        Image("earth").imageIconModifier()
                                        Text("Collection").foregroundColor(.white)
                                    }else{
                                        Image("earth_gray").imageIconModifier()
                                        Text("Collection").foregroundColor(.gray)
                                    }
                                }
                            }).padding()
                        }
                        .frame(width : ScreenSize.windowWidth() * 0.9)
                        .padding(.bottom)
                    }
                    
                }.edgesIgnoringSafeArea(.bottom)
                
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
