//
//  AddViolationView.swift
//  frc-head-ref-tracker
//
//  Created by Jack Doherty on 2/28/26.
//

import SwiftUI

struct AddViolationView: View {
    @Bindable var team: Team
    @Environment(\.dismiss) private var dismiss

    @State private var selectedRuleID: String = ""
    @State private var selectedViolationType: ViolationType = .FirstVerbalWarning
    @State private var searchText: String = ""

    // TODO: Replace with frequently‑called rule IDs
    private let quickRuleIDs: [String] = ["G101", "G201", "G418"]

    private var sortedRules: [Rule] {
        rulesByID.values.sorted { $0.id < $1.id }
    }

    private var filteredRules: [Rule] {
        if searchText.isEmpty {
            return sortedRules
        }
        let query = searchText.lowercased()
        return sortedRules.filter {
            $0.id.lowercased().contains(query) ||
            $0.friendlyName.lowercased().contains(query)
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                // MARK: Quick‑pick buttons
                Section("Common Rules") {
                    HStack {
                        ForEach(quickRuleIDs, id: \.self) { ruleID in
                            if let rule = rulesByID[ruleID] {
                                Button {
                                    selectedRuleID = ruleID
                                } label: {
                                    VStack(spacing: 4) {
                                        Text(rule.id)
                                            .font(.headline)
                                        Text(rule.friendlyName)
                                            .font(.caption2)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.center)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                    .background(
                                        selectedRuleID == ruleID
                                            ? Color.accentColor.opacity(0.2)
                                            : Color.clear
                                    )
                                    .cornerRadius(8)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }

                // MARK: Full rule list
                Section("All Rules") {
                    ForEach(filteredRules) { rule in
                        Button {
                            selectedRuleID = rule.id
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(rule.id)
                                        .font(.subheadline.weight(.semibold))
                                    Text(rule.friendlyName)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)
                                }
                                Spacer()
                                if selectedRuleID == rule.id {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.accent)
                                }
                            }
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                    }
                }

                // MARK: Violation type
                Section("Violation Type") {
                    Picker("Type", selection: $selectedViolationType) {
                        Text("Verbal Warning (1st)").tag(ViolationType.FirstVerbalWarning)
                        Text("Verbal Warning (Repeated)").tag(ViolationType.RepeatedVerbalWarning)
                        Text("Yellow Card").tag(ViolationType.YellowCard)
                        Text("Red Card").tag(ViolationType.RedCard)
                        Text("Other (Severe)").tag(ViolationType.OtherSevere)
                        Text("Other Note").tag(ViolationType.OtherNote)
                    }
                    #if os(iOS)
                    .pickerStyle(.inline)
                    #endif
                    .labelsHidden()
                }
            }
            .searchable(text: $searchText, prompt: "Search rules")
            .navigationTitle("Add Violation")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let violation = Violation(
                            id: UUID(),
                            ruleId: selectedRuleID,
                            type: selectedViolationType
                        )
                        team.violations.append(violation)
                        dismiss()
                    }
                    .disabled(selectedRuleID.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddViolationView(team: SampleData.shared.team)
}
