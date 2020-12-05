//
//  NavigationWatchPop.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Kenji Surya Utama on 04/11/20.
//

import Foundation

final class NavigationWatchPopObject: ObservableObject {
    @Published var selected : Int = 0
    @Published var toAnimation: Bool = false
    //@Published var afterBreathing: Bool = false
    @Published var animationPage: Int = 0
    @Published var breathCycles : Int = 0
}
