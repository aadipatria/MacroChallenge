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
    
    var playLooping = LoopingPlayer()
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView{
            ZStack {
                playLooping
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
                playLooping.player.playing()
                
            }
        }
        .accentColor( .white) /// ini buat ganti back button jd item
//        .sheet(isPresented: self.$needsAppOnboarding, content: {
//            Button {
//                self.needsAppOnboarding = false
//            } label: {
//                Text("set onboarding false")
//            }
//        })
        .fullScreenCover(isPresented: self.$needsAppOnboarding) {
            Onboarding()
        }
//        .animation(.easeOut)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        HomeView().environment(\.managedObjectContext, viewContext).environmentObject(NavigationPopObject())
//        LoopingPlayer()
//            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct ExtractedView: View {
    @EnvironmentObject var navPop : NavigationPopObject
    var body: some View {
        HStack {
            Button(action: {
                navPop.page = 0
            }, label: {
                VStack (spacing: 0) {
                    if navPop.page == 0{
                        Image("water").imageIconModifier()
                        Text("Contact")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }else{
                        Image("water_gray").imageIconModifier()
                        Text("Contact")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                }
                .frame(width : 80)
            }).padding()
            Spacer()
            Button(action: {
                navPop.page = 1
            }, label: {
                VStack (spacing: 0) {
                    if navPop.page == 1{
                        Image("wind").imageIconModifier()
                        Text("Breath")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }else{
                        Image("wind_gray").imageIconModifier()
                        Text("Breath")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                }
                .frame(width : 80)
            }).padding()
            Spacer()
            Button(action: {
                navPop.page = 2
            }, label: {
                VStack (spacing: 0) {
                    if navPop.page == 2{
                        Image("earth").imageIconModifier()
                        Text("Collection")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                    }else{
                        Image("earth_gray").imageIconModifier()
                        Text("Collection")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                }
                .frame(width : 80)
            }).padding()
        }
        .frame(width : ScreenSize.windowWidth() * 0.95)
        .background(Color(UIColor.white)
                        .frame(width : ScreenSize.windowWidth(), height : ScreenSize.windowHeight() * 0.1)
                        .opacity(0.12)
                        .background(Blur(style: .systemThinMaterialDark).opacity(0.95))
                        .cornerRadius(24))
    }
}
