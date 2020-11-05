//
//  ContentView.swift
//  MacroChallenge
//
//  Created by Vincent Alexander Christian on 12/10/20.
//ac

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var navPop : NavigationPopObject
    
    var body: some View {
        NavigationView{
            ZStack {
                LoopingPlayer()
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                if navPop.page == 0 {
                    EmergencyView()
                }
                else if navPop.page == 1{
                    BreathView()
                }
                else if navPop.page == 2{
                    BreathListView()
                }
                VStack {
                    Spacer()
                    ZStack {
                        if !navPop.tabIsHidden{
                            ExtractedView()
                        }

                    }
                    
                }.edgesIgnoringSafeArea(.bottom)
                
            }
        }.accentColor( .black) /// ini buat ganti back button jd item
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
                VStack {
                    if navPop.page == 0{
                        Image("water").imageIconModifier()
                        Text("Contact").foregroundColor(.white)
                    }else{
                        Image("water_gray").imageIconModifier()
                        Text("Contact").foregroundColor(.gray)
                    }
                }
                .frame(width : 80)
            }).padding()
            Spacer()
            Button(action: {
                navPop.page = 1
            }, label: {
                VStack {
                    if navPop.page == 1{
                        Image("wind").imageIconModifier()
                        Text("Breath").foregroundColor(.white)
                    }else{
                        Image("wind_gray").imageIconModifier()
                        Text("Breath").foregroundColor(.gray)
                    }
                }
                .frame(width : 80)
            }).padding()
            Spacer()
            Button(action: {
                navPop.page = 2
            }, label: {
                VStack {
                    if navPop.page == 2{
                        Image("earth").imageIconModifier()
                        Text("Collection").foregroundColor(.white)
                        
                    }else{
                        Image("earth_gray").imageIconModifier()
                        Text("Collection").foregroundColor(.gray)
                    }
                }
                .frame(width : 80)
            }).padding()
        }
        .frame(width : ScreenSize.windowWidth() * 0.95)
        .background(Color(UIColor.white)
                        .frame(width : ScreenSize.windowWidth(), height : ScreenSize.windowHeight() * 0.12)
                        .opacity(0.12)
                        .background(Blur(style: .systemThinMaterialDark).opacity(0.95))
                        .cornerRadius(24))
    }
}
