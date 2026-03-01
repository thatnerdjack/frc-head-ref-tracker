//
//  TeamDetailView.swift
//  frc-head-ref-tracker
//
//  Created by Jack Doherty on 2/28/26.
//

import SwiftUI

struct TeamDetailView: View {
    @Bindable var team: Team
    
    var body: some View {
        VStack {
            Image(systemName: "robotic.vacuum").font(.title).padding()
            Text("Team \(team.teamNumber.formatted(.number.grouping(.never))) – \(team.teamShortName)").padding(.bottom)
            
            Button("Add Note") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }
            
            List {
                ForEach(team.violations, id: \.id) { violation in
                    Text("Add violations to teams to see them here")
                }
            }
            .overlay {
                if team.violations.isEmpty {
                    ContentUnavailableView("No notes yet", systemImage: "face.smiling", description: Text("Add notes to a team to see them here."))
                }
            }
        }
    }
}

#Preview {
    TeamDetailView(team: SampleData.shared.team)
}
