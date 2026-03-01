//
//  frc_head_ref_trackerApp.swift
//  frc-head-ref-tracker
//
//  Created by Jack Doherty on 2/27/26.
//

import SwiftUI
import SwiftData

@main
struct frc_head_ref_trackerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Settings.self,
            Team.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            StartMenu()
        }
        .modelContainer(sharedModelContainer)
    }
}
