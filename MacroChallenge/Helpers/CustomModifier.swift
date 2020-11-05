//
//  CustomModifier.swift
//  MacroChallenge
//
//  Created by Kenji Surya Utama on 26/10/20.
//

import Foundation
import SwiftUI

struct ScreenSize {

    static func windowHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }

    static func windowWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }

    }
struct SomeBackground{
    static func plusBackground() -> some View{
        RoundedRectangle(cornerRadius: 8).fill(Color(UIColor(.white)))
            .frame(width: ScreenSize.windowWidth() * (28/375), height: ScreenSize.windowHeight() * (28/812), alignment: .center)
        }
    static func headerBackground() -> some View{
        Rectangle()
            .fill(Color.clear)
            .background(Blur(style: .systemMaterial)
                            .opacity(0.95))
            .cornerRadius(8, corners: [.topLeft, .topRight])
            .frame(width: ScreenSize.windowWidth() * (0.9), height: ScreenSize.windowHeight() * 0.054, alignment: .leading)
        }
    static func editBackground() -> some View{
        RoundedRectangle(cornerRadius: 8).fill(Color(UIColor(.white)))
            .frame(width: ScreenSize.windowWidth() * (60/375), height: ScreenSize.windowHeight() * (28/812), alignment: .center)
        }
    
}
struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: ScreenSize.windowWidth()*0.9, height: ScreenSize.windowHeight() * 0.05, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 20).fill(Color(UIColor(.white))))
            
    }
}
struct DeleteButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: ScreenSize.windowWidth()*0.9, height: ScreenSize.windowHeight() * 0.05, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 20).fill(Color(UIColor(.red))))
            
    }
}
struct ButtonStrokeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: ScreenSize.windowWidth()*0.9, height: ScreenSize.windowHeight() * 0.05, alignment: .center)
            .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 5)
                    )
            
    }
}
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        ZStack (alignment: .trailing){
            content
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }, label: {
                    Image(systemName: "x.circle")
                        .foregroundColor(.black)
                })
                .padding(.trailing, 8)
            }
        }
    }
}

extension Image {
    
    func imageIconModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            // inget ganti ke dynamic
            .frame(width: ScreenSize.windowWidth() * (36/375), height: ScreenSize.windowHeight() * (36/812), alignment: .center)
    }
    func callIconModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            // inget ganti ke dynamic
            .frame(width: ScreenSize.windowWidth() * (46/375), height: ScreenSize.windowHeight() * (46/812), alignment: .center)
    }
    
    func backgroundImageModifier() -> some View{
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: ScreenSize.windowWidth(), height: ScreenSize.windowHeight(), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .ignoresSafeArea(.all)
    }
    func blurBackgroundImageModifier() -> some View{
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: ScreenSize.windowWidth() * 1.08, height: ScreenSize.windowHeight() * 1.08, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .blur(radius: 2)
            .ignoresSafeArea(.all)
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
