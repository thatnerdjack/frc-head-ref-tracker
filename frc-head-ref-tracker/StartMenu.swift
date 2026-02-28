//
//  StartMenu.swift
//  frc-head-ref-tracker
//
//  Created by Jack Doherty on 2/27/26.
//

import SwiftUI

struct StartMenu: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "list.bullet.clipboard")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .font(Font.largeTitle)
                    .padding()
                Text("FRC Head Referee Tracker")
                    .font(Font.largeTitle)
                    .padding()
                
                NavigationLink {
                    EventView()
                } label: {
                    Label("Access Event", systemImage: "pencil.circle").font(Font.largeTitle)
                }.padding(.bottom)
                
                NavigationLink {
                    SettingsView()
                } label: {
                    Label("Settings", systemImage: "gearshape").font(Font.largeTitle)
                }.padding()
            }
        }
    }
}

#Preview {
    StartMenu()
}
