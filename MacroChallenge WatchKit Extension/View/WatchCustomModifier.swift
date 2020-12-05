//
//  WatchCustomModifier.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Aghawidya Adipatria on 18/11/20.
//

import SwiftUI

struct ScreenSize {
    static func windowHeight() -> CGFloat {
        return WKInterfaceDevice.current().screenBounds.height
    }

    static func windowWidth() -> CGFloat {
        return WKInterfaceDevice.current().screenBounds.width
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

extension Color {
    public static var watchButton: Color {
        return Color(UIColor(red: 36/255, green: 36/255, blue: 36/255, alpha: 1.0))
    }
    
    public static var watchStopButton: Color {
        return Color(UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0))
    }
}
