//
//  CreateRxCycleEditorView.swift
//  Rx Refill Reminders
//
//  Created by Lucas Popp on 5/13/26.
//

import SwiftData
import SwiftUI

struct CreateRxCycleEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var draft = RxCycleDraft.newMedicationTemplate

    private var trimmedName: String {
        draft.name.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var canSave: Bool {
        !trimmedName.isEmpty
    }

    private var hasDraftChanges: Bool {
        draft != RxCycleDraft.newMedicationTemplate
    }

    var body: some View {
        NavigationStack {
            RxCycleDraftForm(draft: $draft)
                .navigationTitle("New Medication")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(role: .cancel) {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .accessibilityLabel("Cancel")
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            save()
                        }
                        .disabled(!canSave)
                    }
                }
                .interactiveDismissDisabled(hasDraftChanges)
        }
    }

    private func save() {
        let name = trimmedName
        guard !name.isEmpty else {
            return
        }
        let cycle = RxCycle(
            name: name,
            refillIntervalDays: draft.refillIntervalDays,
            pharmacyFillAdvanceDays: draft.pharmacyFillAdvanceDays
        )
        modelContext.insert(cycle)
        if (try? modelContext.save()) != nil {
            dismiss()
        }
    }
}

#Preview("CreateRxCycleEditorView") {
    CreateRxCycleEditorView()
        .modelContainer(for: RxCycle.self, inMemory: true)
}
