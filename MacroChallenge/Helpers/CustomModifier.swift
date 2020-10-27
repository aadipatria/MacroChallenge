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
    static func plusBackground() -> some View{
        RoundedRectangle(cornerRadius: 8).fill(Color(UIColor(.white)))
            .frame(width: ScreenSize.windowWidth() * (28/375), height: ScreenSize.windowHeight() * (28/812), alignment: .center)
        }
    }
struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: ScreenSize.windowWidth()*0.9, height: ScreenSize.windowHeight() * 0.05, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 20).fill(Color(UIColor(.white))))
            
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
            .frame(width: ScreenSize.windowWidth() * 1.05, height: ScreenSize.windowHeight() * 1.05, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .ignoresSafeArea(.all)
    }
}
