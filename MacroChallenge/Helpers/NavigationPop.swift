//
//  NavigationPop.swift
//  MacroChallenge
//
//  Created by Kenji Surya Utama on 19/10/20.
//

import Foundation

final class NavigationPopObject: ObservableObject {
    @Published var toHome: Bool = false
    @Published var toBreathing : Bool = false
    @Published var toEmergency : Bool  = false
}
