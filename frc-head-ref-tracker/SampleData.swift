//
//  SampleData.swift
//  frc-head-ref-tracker
//
//  Created by Jack Doherty on 2/28/26.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()

    let modelContainer: ModelContainer

    var context: ModelContext {
        modelContainer.mainContext
    }
    
    var team: Team {
        Team.sampleData.first!
    }

    private init() {
        let schema = Schema([
            Settings.self,
            Team.self,
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            insertSampleData()
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    private func insertSampleData() {
        for team in Team.sampleData {
            context.insert(team)
        }
    }
}
