//
//  AfterBreathingView.swift
//  MacroChallenge
//
//  Created by Kenji Surya Utama on 13/10/20.
//

import SwiftUI

struct AfterBreathingView: View {
    
    @EnvironmentObject var navPop : NavigationPopObject
    @State var success : Bool
    @State var index : Int
    @State var name : String
    @State var pattern : String
    
    var body: some View {
        ZStack {
            LoopingPlayer()
                .edgesIgnoringSafeArea(.all)
            VStack (spacing : 16){
                if success{
                    SuccessView(name: self.name, pattern: self.pattern)
                }else{
                    VStack (alignment: .leading, spacing : 16){
                        Text("Hi there!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 48)
                        Text("Seems like you stopped in the middle of the breathing. How can we help you?")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                            .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                            
                    }
                    .frame(width : ScreenSize.windowWidth() * 0.7)
                    .padding(.trailing, 80)
                    
                }
                Spacer()
                Button(action: {
                    navPop.toBreathing = false
                    // gmn cara start lansung yg baru
                }, label: {
                    Text("Repeat")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .modifier(ButtonModifier())
                })
                
                Button(action: {
                    navPop.toBreathing = false
                }, label: {
                    Text("Finish")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .modifier(ButtonStrokeModifier())
                        .background(Rectangle()
                                        .fill(Color.clear)
                                        .background(Blur(style: .systemThinMaterial)
                                                        .opacity(0.5))
                                        .cornerRadius(36))
                })
                Spacer()
                Button(action: {
                    navPop.toBreathing = false
                    navPop.page = 0
                }, label: {
                    HStack {
                        Text("Emergency Contact")
                            .foregroundColor(.white)
                        Image("call")
                            .callIconModifier()
                    }
                })
                .padding(.horizontal)
                .frame(width: ScreenSize.windowWidth(), alignment: .trailing)
                
            }
            .navigationBarHidden(true)
//            .background(Image("ocean").blurBackgroundImageModifier())
        }
    }
}

struct AfterBreathingView_Previews: PreviewProvider {
    static var previews: some View {
        AfterBreathingView(success: false, index: 0, name: "Relax", pattern: "4 - 7 - 8 - 0").environmentObject(NavigationPopObject())
    }
}

struct SuccessView: View {
    
    @State var name : String
    @State var pattern : String
    
    var body: some View {
        VStack (alignment: .leading, spacing : 16){
            Text("Well Done !")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.top, 48)
            Text("You have completed your session.")
                .font(.title2)
                .foregroundColor(.white)
            VStack(alignment: .leading, spacing : 16){
                Text(name)
                    .font(.title)
                    .fontWeight(.semibold)
                Text(pattern)
                    .font(.body)
                    .fontWeight(.medium)
                Text("Relax. Don’t rush. Don’t force. Don’t stress.\nLet things happen, trust the process, and enjoy the ride.")
                    .font(.callout)
                    .fontWeight(.light)
                Text("- Lori Deschene")
                    .font(.callout)
                    .fontWeight(.light)
            }
            .padding(20)
            .frame(width: ScreenSize.windowWidth() * 0.9, height: ScreenSize.windowHeight() * 0.28, alignment: .center)
            .background(Rectangle()
                            .fill(Color.clear)
                            .background(Blur(style: .systemThinMaterial)
                                            .opacity(0.95))
                            .cornerRadius(10))
        }.frame(width : ScreenSize.windowWidth() * 0.9, alignment: .leading)
    }
}
