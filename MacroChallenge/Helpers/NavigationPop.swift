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
    @Published var page : Int = 1
    @Published var emergency : Bool = false
    @Published var tabIsHidden : Bool = false
    @Published var addBreath : Bool = false
    @Published var editBreath : Bool = false
    @Published var halfModal : Bool = false
    @Published var breathCycles : Int = 0
    @Published var playLooping = LoopingPlayer()
    @Published var playLooping2 = LoopingPlayer()
    @Published var black = false
    @Published var black2 = false
    @Published var previous = ""
    @Published var indexBreath : Int = 0
}
