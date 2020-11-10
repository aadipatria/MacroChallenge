//
//  Onboarding1.swift
//  MacroChallenge
//
//  Created by Vincent Alexander Christian on 10/11/20.
//

import SwiftUI

struct Onboarding: View {
    @AppStorage("needsAppOnboarding") var needsAppOnboarding = true
    @State var page = 1
    
    var contentDict : [Int:[String]] = [
        1 : ["Air\n", "Take a deep breath,\nlet the Air fill you with\npositive energy","onboarding 1", "onboarding 1_sym"],
        2 : ["Earth\n", "Customize your\nbreathing patterns to\nhelp you stay grounded.","onboarding 2","onboarding 2_sym"],
        3 : ["Water\n", "Call a friend to help\nyou stay as calm as\nstill Water.", "onboarding 3", "onboarding 3_sym"]
    ]
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "hale_sym")!)
                .resizable()
                .frame(width: 31.16, height: 39.31)
            
            Spacer()
            
            HStack {
                VStack (alignment: .leading){
                    Text("\(contentDict[page]![0])")
                    Text("\(contentDict[page]![1])")
                }
                .foregroundColor(.white)
                Spacer()
                Image(uiImage: UIImage(named: "\(contentDict[page]![3])")!)
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
        }
        .background(
            Image(uiImage: UIImage(named: "\(contentDict[page]![2])")!)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
        )
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onEnded({ value in
                    if value.translation.height < 0 {
                        if self.page < 3 {
                            self.page += 1
                        }
                    }
                    
                    else if value.translation.height > 0 {
                        if self.page > 1 {
                            self.page -= 1
                        }
                    }
                })
        )
    }
}

struct Onboarding1_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
