//
//  HostingController.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Vincent Alexander Christian on 12/10/20.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<HomeWatchView> {
    override var body: HomeWatchView {
        return HomeWatchView()
    }
}
