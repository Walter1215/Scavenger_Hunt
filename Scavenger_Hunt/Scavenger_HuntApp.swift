//
//  Scavenger_HuntApp.swift
//  Scavenger_Hunt
//
//  Created by Walter Cuadra on 3/31/26.
//

import SwiftUI

@main
struct Scavenger_HuntApp: App {
    @StateObject private var store = TaskStore()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TaskListView()
                    .environmentObject(store)
            }
        }
    }
}
