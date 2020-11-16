//
//  ContentView.swift
//  MacroChallenge
//
//  Created by Vincent Alexander Christian on 12/10/20.
//ac

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var navPop : NavigationPopObject
    @AppStorage("needsAppOnboarding") private var needsAppOnboarding: Bool = true
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView{
            ZStack {
                navPop.playLooping
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .animation(nil)
                    
                if navPop.page == 0 {
                    EmergencyView()
                }
                else if navPop.page == 1{
                    BreathView()
                }
                else if navPop.page == 2{
                    BreathListView()
                }
                VStack (spacing : 0) {
                    Spacer()
                    ZStack {
                        if !navPop.tabIsHidden{
                            ExtractedView()
                                
                        }

                    }
                    .animation(nil)
                    
                }
                .edgesIgnoringSafeArea(.bottom)
                
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                navPop.playLooping.player.playing()
                
            }
        }
        .accentColor( .white) /// ini buat ganti back button jd item
        .fullScreenCover(isPresented: self.$needsAppOnboarding) {
            MainOnboardingPage()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        HomeView().environment(\.managedObjectContext, viewContext).environmentObject(NavigationPopObject())
    }
}

struct ExtractedView: View {
    @EnvironmentObject var navPop : NavigationPopObject
    var body: some View {
        HStack {
            Button(action: {
                navPop.page = 0
                navPop.playLooping.player.moveBackground(name: "forest")
            }, label: {
                VStack (spacing: 0) {
                    if navPop.page == 0{
                        Image("water").imageIconModifier()
                        Text("Contact")
                            .font(Font.custom("Poppins-SemiBold", size: 10, relativeTo: .body))
                            .foregroundColor(.white)
                    }else{
                        Image("water_gray").imageIconModifier()
                        Text("Contact")
                            .font(Font.custom("Poppins-SemiBold", size: 10, relativeTo: .body))
                            .foregroundColor(.gray)
                    }
                }
                .frame(width : 80)
            }).padding(.horizontal)
            Spacer()
            Button(action: {
                navPop.page = 1
            }, label: {
                VStack (spacing: 0) {
                    if navPop.page == 1{
                        Image("wind").imageIconModifier()
                        Text("Breath")
                            .font(Font.custom("Poppins-SemiBold", size: 10, relativeTo: .body))
                            .foregroundColor(.white)
                    }else{
                        Image("wind_gray").imageIconModifier()
                        Text("Breath")
                            .font(Font.custom("Poppins-SemiBold", size: 10, relativeTo: .body))
                            .foregroundColor(.gray)
                    }
                }
                .frame(width : 80)
            }).padding(.horizontal)
            Spacer()
            Button(action: {
                navPop.page = 2
            }, label: {
                VStack (spacing: 0) {
                    if navPop.page == 2{
                        Image("earth").imageIconModifier()
                            .padding(.bottom, 1)
                        Text("Collection")
                            .font(Font.custom("Poppins-SemiBold", size: 10, relativeTo: .body))
                            .foregroundColor(.white)
                        
                    }else{
                        Image("earth_gray").imageIconModifier()
                            .padding(.bottom, 1)
                        Text("Collection")
                            .font(Font.custom("Poppins-SemiBold", size: 10, relativeTo: .body))
                            .foregroundColor(.gray)
                    }
                }
                .frame(width : 80)
            }).padding(.horizontal)
        }
        .frame(width : ScreenSize.windowWidth() * 0.95)
//        .padding(.bottom , 26)
        .padding(.bottom, ScreenSize.windowHeight() * 0.03)
        .background(Color(UIColor.white)
                        .frame(width : ScreenSize.windowWidth(), height : ScreenSize.windowHeight() * 0.1)
                        .opacity(0.12)
                        .background(Blur(style: .systemThinMaterialDark).opacity(0.95))
                        .cornerRadius(24))
        
    }
}
