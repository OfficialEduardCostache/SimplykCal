//
//  SimplykCalApp.swift
//  SimplykCal
//
//  Created by Eduard Costache on 23/05/2025.
//

import SwiftUI
import SwiftData

@main
struct SimplykCalApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .ignoresSafeArea(edges: .bottom)
        }
        .modelContainer(for: [User.self])
    }
}
