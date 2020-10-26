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

struct ButtonModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)

    }
}
extension Image {
    
    func imageIconModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            // inget ganti ke dynamic
            .frame(width: 36, height: 36, alignment: .center)
    }
    
    func backgroundImageModifier() -> some View{
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: ScreenSize.windowWidth(), height: ScreenSize.windowHeight(), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .ignoresSafeArea(.all)
    }
}
