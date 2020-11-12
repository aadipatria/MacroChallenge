//
//  AfterBreathingView.swift
//  MacroChallenge
//
//  Created by Kenji Surya Utama on 13/10/20.
// udah bisa

import SwiftUI
var playLooping = LoopingPlayer()

struct AfterBreathingView: View {
    
    @EnvironmentObject var navPop : NavigationPopObject
    @State var success : Bool
    @State var index : Int
    @State var name : String
    @State var pattern : String
    
    var body: some View {
        ZStack {
            playLooping
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .animation(nil)
//            LoopingPlayer()
//                .edgesIgnoringSafeArea(.all)
            VStack (spacing : 16){
                if success{
                    SuccessView(name: self.name, pattern: self.pattern)
                }else{
                    VStack (alignment: .leading, spacing : 16){
                        Text("Hi there!")
                            .font(Font.custom("Poppins-Bold", size: 24, relativeTo: .body))
                            .foregroundColor(.white)
                            .padding(.top, 48)
                        Text("Seems like you stopped in the middle of the breathing. How can we help you?")
                            .font(Font.custom("Poppins-Light", size: 24, relativeTo: .body))
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
                        .font(Font.custom("Poppins-SemiBold", size: 14, relativeTo: .body))
                        .foregroundColor(.black)
                        .modifier(ButtonModifier())
                })
                
                Button(action: {
                    navPop.toBreathing = false
                    navPop.breathCycles = 0
                }, label: {
                    Text("Finish")
                        .font(Font.custom("Poppins-SemiBold", size: 14, relativeTo: .body))
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
                    navPop.breathCycles = 0
                }, label: {
                    HStack {
                        Text("Emergency Contact")
                            .font(Font.custom("Poppins-Medium", size: 12, relativeTo: .body))
                            .foregroundColor(.white)
                        Image("call")
                            .callIconModifier()
                    }
                })
                .padding(.horizontal)
                .frame(width: ScreenSize.windowWidth(), alignment: .trailing)
                
                
                
            }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                playLooping.player.playing()
                
            }
        
            .navigationBarHidden(true)
            .onAppear(perform: {
                navPop.tabIsHidden = false
            
            })
//            .background(Image("ocean").blurBackgroundImageModifier())
            .background(playLooping
                            .frame(width: ScreenSize.windowWidth(), height: ScreenSize.windowHeight(), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .ignoresSafeArea(.all))
            
        }
    }
}

struct AfterBreathingView_Previews: PreviewProvider {
    static var previews: some View {
        AfterBreathingView(success: true, index: 0, name: "Relax", pattern: "4 - 7 - 8 - 0").environmentObject(NavigationPopObject())
    }
}

struct SuccessView: View {
    @State var name : String
    @State var pattern : String
    @State var randQuotes: String = ""
    
    var body: some View {
        VStack (alignment: .leading, spacing : 16){
            Text("Well Done !")
                .font(Font.custom("Poppins-SemiBold", size: 24, relativeTo: .body))
                .foregroundColor(.white)
                .padding(.top, 48)
            Text("You have completed your session.")
                .font(Font.custom("Poppins-Regular", size: 18, relativeTo: .body))
                .foregroundColor(.white)
            VStack(alignment: .leading, spacing : 16){
                Text(name)
                    .font(Font.custom("Poppins-SemiBold", size: 24, relativeTo: .body))
                Text(pattern)
                    .font(Font.custom("Poppins-Medium", size: 14, relativeTo: .body))
                Text("\(randQuotes)")
                    .font(Font.custom("Poppins-Light", size: 12, relativeTo: .body))
            }
            .padding(20)
            .frame(width: ScreenSize.windowWidth() * 0.9, height: ScreenSize.windowHeight() * 0.28, alignment: .center)
            .background(Rectangle()
                            .fill(Color.clear)
                            .background(Blur(style: .systemThinMaterial)
                                            .opacity(0.95))
                            .cornerRadius(10))
        }
        .frame(width : ScreenSize.windowWidth() * 0.9, alignment: .leading)
        .onAppear {
            self.randQuotes = Quotes.getRandQuotes()
        
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            playLooping.player.playing()
            
        }
    }
}
