//
//  EventView.swift
//  frc-head-ref-tracker
//
//  Created by Jack Doherty on 2/28/26.
//

import SwiftUI
import SwiftData

struct EventView: View {
    @Query(sort: \Team.teamNumber) private var teams: [Team]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        TabView {
            Tab("All Teams", systemImage: "person.3") {
                NavigationSplitView {
                    List {
                        ForEach(teams) { team in
                            TeamEntry(team: team)
                        }
                    }
                    .overlay {
                        if teams.isEmpty {
                            ContentUnavailableView("No teams yet", systemImage: "person.3", description: Text("Add teams to see them here."))
                        }
                    }
                    .navigationTitle("Teams")
                } detail: {
                    Text("Select a team")
                        .navigationTitle("Team Detail")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
            
            Tab("Cards/Warnings Only", systemImage: "exclamationmark.triangle") {
                let filteredTeams = teams.filter {!$0.violations.isEmpty}
                NavigationSplitView {
                    List {
                        ForEach(filteredTeams) { team in
                            TeamEntry(team: team)
                        }
                    }
                    .overlay {
                        if filteredTeams.isEmpty {
                            ContentUnavailableView("No teams yet", systemImage: "exclamationmark.triangle", description: Text("Only teams with notes will be seen here."))
                        }
                    }
                    .navigationTitle("Teams")
                } detail: {
                    Text("Select a team")
                        .navigationTitle("Team Detail")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}

struct TeamEntry: View {
    let team: Team
    
    var body: some View {
        NavigationLink(value: team.teamNumber) {
            HStack {
                Image(systemName: "robotic.vacuum")
                    .symbolRenderingMode(.monochrome)
                    .foregroundStyle(.primary)
                    .imageScale(.large)
                    .padding(.trailing, 4)
                Text("Team \(team.teamNumber.formatted(.number.grouping(.never))) – \(team.teamShortName)")
            }
        }
    }
}

#Preview {
    EventView()
        .modelContainer(SampleData.shared.modelContainer)
}

