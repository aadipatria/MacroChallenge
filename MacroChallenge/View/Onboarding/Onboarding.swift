//
//  Page1.swift
//  MacroChallenge
//
//  Created by Vincent Alexander Christian on 11/11/20.
//

import SwiftUI

struct ContentData {
    static var contentDict : [Int:[String]] = [
        1 : ["Air\n", "Take a deep breath,\nlet the Air fill you with\npositive energy","onboarding 1", "onboarding 1_sym"],
        2 : ["Earth\n", "Customize your\nbreathing patterns to\nhelp you stay grounded.","onboarding 2","onboarding 2_sym"],
        3 : ["Water\n", "Call a friend to help\nyou stay as calm as\nstill Water.", "onboarding 3", "onboarding 3_sym"]
    ]
}

struct MainOnboardingPage: View {
    let off = UIScreen.main.bounds.height
    @State var page = 1
    
    var body: some View {
        ZStack {
            VStack {
                Page(title: ContentData.contentDict[1]![0], content: ContentData.contentDict[1]![1], sym: ContentData.contentDict[1]![3], background: ContentData.contentDict[1]![2], page: $page)
                    .offset(y: page == 1 ? off : (page == 2 ? 0 : -off * 2))
                
                Page(title: ContentData.contentDict[2]![0], content: ContentData.contentDict[2]![1], sym: ContentData.contentDict[2]![3], background: ContentData.contentDict[2]![2], page: $page)
                    .offset(y: page == 2 ? 0 : (page == 3 ? -off : off))
                
                Page(title: ContentData.contentDict[3]![0], content: ContentData.contentDict[3]![1], sym: ContentData.contentDict[3]![3], background: ContentData.contentDict[3]![2], page: $page)
                    .offset(y: page == 3 ? -off : (page == 2 ? 0 : off * 2))
            }
            .animation(.easeInOut(duration: 1))
        }
    }
}

struct Page: View {
    @AppStorage("needsAppOnboarding") var needsAppOnboarding = true
    
    var title = ""
    var content = ""
    var sym = ""
    var background = ""
    @Binding var page: Int
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "hale_sym")!)
                .resizable()
                .frame(width: 31.16, height: 39.31)
                .padding(.top, 50)
            
            Spacer()
            
            HStack {
                VStack (alignment: .leading){
                    Text("\(title)")
                    Text("\(content)")
                }
                .foregroundColor(.white)
                Spacer()
                Image(uiImage: UIImage(named: "\(sym)")!)
                    .resizable()
                    .frame(width: 45, height: 201)
            }
            .padding(.leading, 32)
            .padding(.trailing, 24)
            
            Spacer()
            
            HStack {
                if page == 3 {
                    Button(action: {
                        self.needsAppOnboarding = false
                    }, label: {
                        Text("Get Started")
                            .foregroundColor(.white)
                    })
                }
                else {
                    EmptyView()
                    
                    Spacer()
                    
                    Button(action: {
                        self.page += 1
                    }, label: {
                        Image(uiImage: UIImage(named: "down_sym")!)
                            .resizable()
                            .frame(width: 30, height: 30)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        self.needsAppOnboarding = false
                    }, label: {
                        Text("Skip")
                            .foregroundColor(.white)
                    })
                }
            }
            .frame(width: 253, height: 60)
            .padding(.trailing, 23)
            .padding(.leading, 50)
            .padding(.bottom, 50)
        }
        .background(
            Image(uiImage: UIImage(named: "\(background)")!)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 1.01)
                .edgesIgnoringSafeArea(.vertical)
        )
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onEnded({ value in
                    if value.translation.height < 0 {
                        //swipe up
                        if page < 3 {
                            page += 1
                        }
                    }
                    
                    else if value.translation.height > 0 {
                        //swipe down
                        if page > 1 {
                            page -= 1
                        }
                    }
                })
        )
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}

struct Page1_Previews: PreviewProvider {
    static var previews: some View {
        MainOnboardingPage()
    }
}

