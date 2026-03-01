import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var settings: [Settings]   // expect 0 or 1 row
    @State private var apiKey: String = ""
    @State private var eventCode: String = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            Form {
                TextField("TBA API Key", text: $apiKey)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                
                TextField("TBA Event Code", text: $eventCode)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let trimmed = apiKey.trimmingCharacters(in: .whitespacesAndNewlines)
                        if let record = settings.first {
                            record.apiKey = trimmed
                        } else {
                            let newSettings = Settings(apiKey: trimmed)
                            modelContext.insert(newSettings)
                        }
                        try? modelContext.save()
                        dismiss()
                    }
                    .disabled(apiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .onAppear {
                apiKey = settings.first?.apiKey ?? ""
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
